import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linguabridge/src/features/language/data/language_repository.dart';
import 'package:linguabridge/src/features/language/domain/language.dart';
import 'package:uuid/uuid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class RegisterLanguagePage extends ConsumerStatefulWidget {
  const RegisterLanguagePage({super.key});

  @override
  ConsumerState<RegisterLanguagePage> createState() => _RegisterLanguagePageState();
}

class _RegisterLanguagePageState extends ConsumerState<RegisterLanguagePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nativeNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _tribeController = TextEditingController();
  final _dialectController = TextEditingController();
  final _scriptController = TextEditingController();
  
  bool _isLoading = false;
  bool _isDetectingLocation = false;

  Future<void> _detectLocation() async {
    setState(() => _isDetectingLocation = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          throw Exception('Location permission denied.');
        }
      }

      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final region = placemark.administrativeArea ?? placemark.subAdministrativeArea ?? '';
        final country = placemark.country ?? '';
        
        final detectedLocation = [region, country].where((s) => s.isNotEmpty).join(', ');
        if (detectedLocation.isNotEmpty) {
          _locationController.text = detectedLocation;
        } else {
          throw Exception('Could not resolve region name from coordinates.');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('GPS Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isDetectingLocation = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nativeNameController.dispose();
    _locationController.dispose();
    _tribeController.dispose();
    _dialectController.dispose();
    _scriptController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final newLanguage = Language(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        nativeName: _nativeNameController.text.trim().isEmpty ? null : _nativeNameController.text.trim(),
        location: _locationController.text.trim(),
        tribe: _tribeController.text.trim().isEmpty ? null : _tribeController.text.trim(),
        dialect: _dialectController.text.trim().isEmpty ? null : _dialectController.text.trim(),
        script: _scriptController.text.trim(),
        timestamp: DateTime.now(),
      );

      try {
        await ref.read(languageRepositoryProvider).addLanguage(newLanguage);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Language registered successfully!')),
          );
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
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
      appBar: AppBar(title: const Text('Register New Language')),
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
                    'Add a Missing Language',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Language Name (English)*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.language),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nativeNameController,
                    decoration: const InputDecoration(
                      labelText: 'Native Name (Autonym)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.translate),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: 'Primary Location (Region/State)*',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.place),
                      suffixIcon: _isDetectingLocation 
                        ? const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                          )
                        : IconButton(
                            icon: const Icon(Icons.my_location, color: Colors.blue),
                            tooltip: 'Detect via GPS',
                            onPressed: _detectLocation,
                          ),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _tribeController,
                    decoration: const InputDecoration(
                      labelText: 'Tribe / Community',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.groups),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _dialectController,
                    decoration: const InputDecoration(
                      labelText: 'Specific Dialect',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.record_voice_over),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _scriptController,
                    decoration: const InputDecoration(
                      labelText: 'Writing Script (e.g., Latin, Ol Chiki)*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.edit_document),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
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
                        : const Icon(Icons.save),
                    label: Text(
                      _isLoading ? 'Registering...' : 'Register Language',
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
