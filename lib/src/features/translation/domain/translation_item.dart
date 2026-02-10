import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_item.freezed.dart';
part 'translation_item.g.dart';

@freezed
class TranslationItem with _$TranslationItem {
  const factory TranslationItem({
    required String id,
    required String sourceText,
    required String translatedText,
    required String sourceLanguage,
    required String targetLanguage,
    required DateTime timestamp,
    String? userId,
    String? imageUrl,
  }) = _TranslationItem;

  factory TranslationItem.fromJson(Map<String, dynamic> json) =>
      _$TranslationItemFromJson(json);
}
