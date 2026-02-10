import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_item.freezed.dart';
part 'image_item.g.dart';

@freezed
class ImageItem with _$ImageItem {
  const factory ImageItem({
    required String id,
    required String filePath,
    required List<String> tags,
    required DateTime timestamp,
    String? userId,
  }) = _ImageItem;

  factory ImageItem.fromJson(Map<String, dynamic> json) =>
      _$ImageItemFromJson(json);
}
