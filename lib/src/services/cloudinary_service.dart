import 'dart:io';
import 'package:dio/dio.dart';
import 'package:linguabridge/src/constants/api_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cloudinary_service.g.dart';

class CloudinaryService {
  final Dio _dio = Dio();

  Future<String?> uploadImage(String filePath) async {
    if (ApiKeys.cloudinaryCloudName == 'YOUR_CLOUD_NAME') {
      throw Exception(
        'Please configure Cloudinary Credentials in lib/src/constants/api_keys.dart',
      );
    }

    try {
      final String url =
          'https://api.cloudinary.com/v1_1/${ApiKeys.cloudinaryCloudName}/image/upload';

      final FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        'upload_preset': ApiKeys.cloudinaryUploadPreset,
      });

      final response = await _dio.post(url, data: formData);

      if (response.statusCode == 200) {
        return response.data['secure_url'] as String?;
      } else {
        throw Exception('Failed to upload image: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Cloudinary Upload Error: $e');
    }
  }
}

@riverpod
CloudinaryService cloudinaryService(CloudinaryServiceRef ref) {
  return CloudinaryService();
}
