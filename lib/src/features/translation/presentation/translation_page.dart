import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:linguabridge/src/features/auth/data/auth_repository.dart';
import 'package:linguabridge/src/features/language/data/language_repository.dart';
import 'package:linguabridge/src/features/language/domain/language.dart';
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
  final _phoneticController = TextEditingController();
  final _contextOriginalController = TextEditingController();
  final _contextTranslatedController = TextEditingController();
  final _targetLangController = TextEditingController(text: 'Hindi');
  
  String? _selectedLanguageName;

  XFile? _imageFile;
  Uint8List? _imageBytes; // For web/mobile compatible preview
  final _picker = ImagePicker();

  // Audio Recording State
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _recordedAudioPath;

  bool _isLoading = false;

  @override
  void dispose() {
    _sourceController.dispose();
    _targetController.dispose();
    _targetLangController.dispose();
    _phoneticController.dispose();
    _contextOriginalController.dispose();
    _contextTranslatedController.dispose();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageFile = pickedFile;
        _imageBytes = bytes;
      });
    }
  }

  Future<void> _toggleRecording() async {
    try {
      if (_isRecording) {
        final path = await _audioRecorder.stop();
        if (path != null) {
          setState(() {
            _isRecording = false;
            _recordedAudioPath = path;
          });
        }
      } else {
        if (await _audioRecorder.hasPermission()) {
          final dir = await getApplicationDocumentsDirectory();
          final filePath = '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
          
          await _audioRecorder.start(
            const RecordConfig(encoder: AudioEncoder.aacLc),
            path: filePath,
          );
          setState(() => _isRecording = true);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Microphone permission is required to record audio.')),
            );
          }
        }
      }
    } catch (e) {
      debugPrint('Error handling recording: $e');
    }
  }

  Future<void> _togglePlayback() async {
    if (_recordedAudioPath == null) return;
    
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() => _isPlaying = false);
    } else {
      await _audioPlayer.play(DeviceFileSource(_recordedAudioPath!));
      setState(() => _isPlaying = true);
      _audioPlayer.onPlayerComplete.listen((event) {
        if (mounted) setState(() => _isPlaying = false);
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate() && _selectedLanguageName != null) {
      setState(() => _isLoading = true);

      // Secure Points Logic
      int points = 5;
      bool hasImage = _imageBytes != null;
      bool hasAudio = _recordedAudioPath != null;

      if (hasImage && hasAudio) {
        points = 30; // Holy Grail reward!
      } else if (hasImage || hasAudio) {
        points = 10;
      }

      final authUser = ref.read(authRepositoryProvider).currentUser;

      final newItem = TranslationItem(
        id: const Uuid().v4(),
        sourceText: _sourceController.text.trim(),
        translatedText: _targetController.text.trim(),
        sourceLanguage: _selectedLanguageName!,
        targetLanguage: _targetLangController.text.trim(),
        phoneticSpelling: _phoneticController.text.trim().isEmpty ? null : _phoneticController.text.trim(),
        contextSentenceOriginal: _contextOriginalController.text.trim().isEmpty ? null : _contextOriginalController.text.trim(),
        contextSentenceTranslated: _contextTranslatedController.text.trim().isEmpty ? null : _contextTranslatedController.text.trim(),
        pointsEarned: points,
        userId: authUser?.uid, 
        timestamp: DateTime.now(),
      );

      try {
        await ref
            .read(translationRepositoryProvider)
            .addTranslation(newItem, imageFile: _imageFile, audioFilePath: _recordedAudioPath);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Contribution submitted! You earned $points points!'),
              backgroundColor: Colors.green,
            ),
          );
          _sourceController.clear();
          _targetController.clear();
          _phoneticController.clear();
          _contextOriginalController.clear();
          _contextTranslatedController.clear();
          setState(() {
            _imageFile = null;
            _imageBytes = null;
            _recordedAudioPath = null;
            _isLoading = false;
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
          setState(() => _isLoading = false);
        }
      } 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all required fields.')),
      );
    }
  }

  void _showPointsInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Points Distribution'),
        content: const Text(
          '+5 - Word (Text Only)\n+10 - Word + Image OR Audio\n+30 - Word + Image AND Audio',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languagesAsync = ref.watch(watchLanguagesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Contribute Word')),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      languagesAsync.when(
                        data: (languages) {
                          if (languages.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                'Oops! No languages exist yet.\nRegister one using the button below!',
                                style: TextStyle(color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: _selectedLanguageName,
                            decoration: const InputDecoration(
                              labelText: 'From Language*',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.language),
                            ),
                            items: languages.map((Language lang) {
                              return DropdownMenuItem<String>(
                                value: lang.name,
                                child: Text(lang.name, overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (String? newValue) => setState(() => _selectedLanguageName = newValue),
                            validator: (value) => value == null ? 'Required' : null,
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (e, st) => const Text('Error loading languages'),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Icon(Icons.arrow_downward, color: Colors.grey),
                      ),
                      TextFormField(
                        controller: _targetLangController,
                        decoration: const InputDecoration(
                          labelText: 'To Language*',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.language),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _sourceController,
                    decoration: const InputDecoration(
                      labelText: 'Original Text / Word*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.text_fields),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter text' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneticController,
                    decoration: const InputDecoration(
                      labelText: 'Phonetic Spelling (Optional)',
                      hintText: 'How is it pronounced?',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.sort_by_alpha),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _targetController,
                    decoration: const InputDecoration(
                      labelText: 'Translated Text*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.translate),
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter translation' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _contextOriginalController,
                    decoration: const InputDecoration(
                      labelText: 'Context Sentence (Original Language)',
                      hintText: 'Use the word in a sentence',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.format_quote),
                    ),
                    maxLines: 2,
                    minLines: 1,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _contextTranslatedController,
                    decoration: const InputDecoration(
                      labelText: 'Context Sentence (Translated)',
                      hintText: 'Translate the sentence',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.format_quote),
                    ),
                    maxLines: 2,
                    minLines: 1,
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  
                  // AUDIO SECTION
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Attach Pronunciation Audio', style: Theme.of(context).textTheme.titleMedium),
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: _showPointsInfo,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_recordedAudioPath != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                            onPressed: _togglePlayback,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Expanded(child: Text('Audio Recorded Successfully')),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => setState(() {
                              _recordedAudioPath = null;
                              if (_isPlaying) _togglePlayback();
                            }),
                          ),
                        ],
                      ),
                    )
                  else
                    ElevatedButton.icon(
                      onPressed: _toggleRecording,
                      icon: Icon(_isRecording ? Icons.stop_circle : Icons.mic),
                      label: Text(_isRecording ? 'Stop Recording' : 'Record Pronunciation'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isRecording ? Colors.red.shade100 : null,
                        foregroundColor: _isRecording ? Colors.red : null,
                        padding: const EdgeInsets.all(16),
                      ),
                    ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),

                  // IMAGE SECTION
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Attach Image', style: Theme.of(context).textTheme.titleMedium),
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: _showPointsInfo,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_imageBytes != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(_imageBytes!, height: 200, width: double.infinity, fit: BoxFit.cover),
                        ),
                        IconButton(
                          onPressed: () => setState(() {
                            _imageFile = null;
                            _imageBytes = null;
                          }),
                          icon: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.close)),
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
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Icon(Icons.send),
                    label: Text(_isLoading ? 'Submitting Media & Translation...' : 'Submit Contribution'),
                    style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => context.push('/contribute/register'),
                    icon: const Icon(Icons.add_location_alt),
                    label: const Text('Language Missing? Register a Tribe/Dialect Here'),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
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
