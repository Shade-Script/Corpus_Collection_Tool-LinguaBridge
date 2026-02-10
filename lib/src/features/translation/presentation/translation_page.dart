import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linguabridge/src/features/translation/data/translation_repository.dart';
import 'package:linguabridge/src/features/translation/domain/translation_item.dart';
import 'package:uuid/uuid.dart';

class TranslationPage extends ConsumerStatefulWidget {
  const TranslationPage({super.key});

  @override
  ConsumerState<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends ConsumerState<TranslationPage> {
  final _formKey = GlobalKey<FormState>();
  final _sourceController = TextEditingController();
  final _targetController = TextEditingController();
  final _sourceLangController = TextEditingController(text: 'English');
  final _targetLangController = TextEditingController(text: 'Yoruba');

  File? _imageFile;
  final _picker = ImagePicker();
  bool _isLoading = false;

  @override
  void dispose() {
    _sourceController.dispose();
    _targetController.dispose();
    _sourceLangController.dispose();
    _targetLangController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final newItem = TranslationItem(
        id: const Uuid().v4(),
        sourceText: _sourceController.text,
        translatedText: _targetController.text,
        sourceLanguage: _sourceLangController.text,
        targetLanguage: _targetLangController.text,
        timestamp: DateTime.now(),
      );

      try {
        await ref
            .read(translationRepositoryProvider)
            .addTranslation(newItem, imagePath: _imageFile?.path);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Contribution submitted successfully!'),
            ),
          );
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contribute Translation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Add a New Word',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _sourceLangController,
                          decoration: const InputDecoration(
                            labelText: 'From Language',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.language),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.arrow_forward),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _targetLangController,
                          decoration: const InputDecoration(
                            labelText: 'To Language',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.language),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _sourceController,
                    decoration: const InputDecoration(
                      labelText: 'Source Text',
                      hintText: 'Enter text to translate',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.text_fields),
                    ),
                    maxLines: 3,
                    minLines: 1,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter text'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _targetController,
                    decoration: const InputDecoration(
                      labelText: 'Translated Text',
                      hintText: 'Enter translation',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.translate),
                    ),
                    maxLines: 3,
                    minLines: 1,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter translation'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'Attach Image (Optional)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  if (_imageFile != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _imageFile!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        IconButton(
                          onPressed: () => setState(() => _imageFile = null),
                          icon: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.close),
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => _pickImage(ImageSource.camera),
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Camera'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Gallery'),
                        ),
                      ],
                    ),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: _isLoading ? null : _submit,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send),
                    label: Text(
                      _isLoading ? 'Submitting...' : 'Submit Contribution',
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
