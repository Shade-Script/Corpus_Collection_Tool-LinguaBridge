import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> addTranslation(TranslationItem item, {String? imagePath}) async {
    // If an image is provided, upload it first
    String? finalImageUrl = item.imageUrl;

    if (imagePath != null) {
      final uploadedUrl = await _cloudinaryService.uploadImage(imagePath);
      if (uploadedUrl != null) {
        finalImageUrl = uploadedUrl;
      }
    }

    // Create a copy with the image URL if changed
    final itemToSave = finalImageUrl != item.imageUrl
        ? item.copyWith(imageUrl: finalImageUrl)
        : item;

    await _firestore
        .collection('translations')
        .doc(item.id)
        .set(itemToSave.toJson());
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
