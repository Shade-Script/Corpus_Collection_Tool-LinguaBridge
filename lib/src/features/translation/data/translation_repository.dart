import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linguabridge/src/features/translation/domain/translation_item.dart';
import 'package:linguabridge/src/services/cloudinary_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_repository.g.dart';

class TranslationRepository {
  final FirebaseFirestore _firestore;
  final CloudinaryService _cloudinaryService;

  TranslationRepository(this._firestore, this._cloudinaryService);

  Stream<List<TranslationItem>> watchTranslations() {
    return _firestore
        .collection('translations')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TranslationItem.fromJson(doc.data()))
              .toList(),
        );
  }

  Stream<List<TranslationItem>> watchTranslationsByLanguage(String languageName) {
    return _firestore
        .collection('translations')
        .where('sourceLanguage', isEqualTo: languageName)
        .snapshots()
        .map(
          (snapshot) {
            final list = snapshot.docs
                .map((doc) => TranslationItem.fromJson(doc.data()))
                .toList();
            // Client-side sort prevents complex Firestore composite index faults
            list.sort((a, b) => b.timestamp.compareTo(a.timestamp));
            return list;
          },
        );
  }

  Future<void> addTranslation(TranslationItem item, {XFile? imageFile, String? audioFilePath}) async {
    String? finalImageUrl = item.imageUrl;
    String? finalAudioUrl = item.audioUrl;

    // Upload media in parallel if both exist
    final uploadTasks = <Future>[];

    if (imageFile != null) {
      uploadTasks.add(
        _cloudinaryService.uploadImage(imageFile).then((url) {
          if (url != null) finalImageUrl = url;
        })
      );
    }

    if (audioFilePath != null) {
      uploadTasks.add(
        _cloudinaryService.uploadAudio(audioFilePath).then((url) {
          if (url != null) finalAudioUrl = url;
        })
      );
    }

    await Future.wait(uploadTasks);

    // Create a copy with the secure cloud URLs if they exist
    final itemToSave = item.copyWith(
      imageUrl: finalImageUrl,
      audioUrl: finalAudioUrl,
    );

    // Use a Firestore transaction to write the translation and increment the user's score simultaneously!
    await _firestore.runTransaction((transaction) async {
      // 1. Add Translation
      final translationDoc = _firestore.collection('translations').doc(itemToSave.id);
      transaction.set(translationDoc, itemToSave.toJson());

      // 2. Increment User's total points securely
      if (itemToSave.userId != null) {
        final userDoc = _firestore.collection('users').doc(itemToSave.userId);
        transaction.set(userDoc, {
          'totalPoints': FieldValue.increment(itemToSave.pointsEarned),
        }, SetOptions(merge: true));
      }
    });
  }
}

@Riverpod(keepAlive: true)
TranslationRepository translationRepository(TranslationRepositoryRef ref) {
  return TranslationRepository(
    FirebaseFirestore.instance,
    ref.read(cloudinaryServiceProvider),
  );
}

@riverpod
Stream<List<TranslationItem>> watchTranslations(WatchTranslationsRef ref) {
  return ref.watch(translationRepositoryProvider).watchTranslations();
}

@riverpod
Stream<List<TranslationItem>> watchTranslationsByLanguage(WatchTranslationsByLanguageRef ref, String languageName) {
  return ref.watch(translationRepositoryProvider).watchTranslationsByLanguage(languageName);
}
