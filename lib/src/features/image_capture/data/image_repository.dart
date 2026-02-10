import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linguabridge/src/services/cloudinary_service.dart';
import 'package:linguabridge/src/features/image_capture/domain/image_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_repository.g.dart';

class ImageRepository {
  final FirebaseFirestore _firestore;
  final CloudinaryService _cloudinaryService;

  ImageRepository(this._firestore, this._cloudinaryService);

  Stream<List<ImageItem>> watchImages() {
    return _firestore
        .collection('images')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ImageItem.fromJson(doc.data()))
              .toList(),
        );
  }

  Future<void> addImage(ImageItem item) async {
    // 1. Upload image file to Cloudinary
    final String? imageUrl = await _cloudinaryService.uploadImage(
      item.filePath,
    );

    if (imageUrl == null) {
      throw Exception('Failed to upload image to Cloudinary');
    }

    // 2. Create updated item with Cloud URL (we re-use filePath for now or add a new field)
    // For simplicity, let's assume filePath in ImageItem can store the URL or local path.
    // Ideally, we'd separate them. Here, we'll store the URL in the 'filePath' field of the DB object.

    // Create map for Firestore
    final data = item.toJson();
    data['filePath'] = imageUrl; // Update with remote URL

    // 3. Save metadata to Firestore
    await _firestore.collection('images').doc(item.id).set(data);
  }
}

@Riverpod(keepAlive: true)
ImageRepository imageRepository(ImageRepositoryRef ref) {
  return ImageRepository(
    FirebaseFirestore.instance,
    ref.read(cloudinaryServiceProvider),
  );
}

@riverpod
Stream<List<ImageItem>> watchImages(WatchImagesRef ref) {
  return ref.watch(imageRepositoryProvider).watchImages();
}
