import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linguabridge/src/constants/api_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cloudinary_service.g.dart';

class CloudinaryService {
  final Dio _dio = Dio();

  Future<String?> uploadImage(XFile file) async {
    if (ApiKeys.cloudinaryCloudName == 'YOUR_CLOUD_NAME') {
      throw Exception(
        'Please configure Cloudinary Credentials in lib/src/constants/api_keys.dart',
      );
    }

    try {
      final String url =
          'https://api.cloudinary.com/v1_1/${ApiKeys.cloudinaryCloudName}/image/upload';

      final bytes = await file.readAsBytes();
      final FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(bytes, filename: file.name),
        'upload_preset': ApiKeys.cloudinaryUploadPreset,
      });

      final response = await _dio.post(url, data: formData);

      if (response.statusCode == 200) {
        return response.data['secure_url'] as String?;
      } else {
        throw Exception('Failed to upload image: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data['error']?['message'] ?? e.message;
      throw Exception('Cloudinary Upload Error: $errorMsg');
    } catch (e) {
      throw Exception('Cloudinary Upload Error: $e');
    }
  }

  Future<String?> uploadAudio(String filePath) async {
    if (ApiKeys.cloudinaryCloudName == 'YOUR_CLOUD_NAME') {
      throw Exception('Please configure Cloudinary Credentials in lib/src/constants/api_keys.dart');
    }

    try {
      // Audio files in Cloudinary are always handled under the "video" resource type
      final String url =
          'https://api.cloudinary.com/v1_1/${ApiKeys.cloudinaryCloudName}/video/upload';

      final FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        'upload_preset': ApiKeys.cloudinaryUploadPreset,
      });

      final response = await _dio.post(url, data: formData);

      if (response.statusCode == 200) {
        return response.data['secure_url'] as String?;
      } else {
        throw Exception('Failed to upload audio: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data['error']?['message'] ?? e.message;
      throw Exception('Cloudinary Upload Error: $errorMsg');
    } catch (e) {
      throw Exception('Cloudinary Upload Error: $e');
    }
  }
}

@riverpod
CloudinaryService cloudinaryService(CloudinaryServiceRef ref) {
  return CloudinaryService();
}
