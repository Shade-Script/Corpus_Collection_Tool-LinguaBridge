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
    String? phoneticSpelling,
    String? contextSentenceOriginal,
    String? contextSentenceTranslated,
    String? userId,
    String? imageUrl,
    String? audioUrl,
    @Default(5) int pointsEarned,
  }) = _TranslationItem;

  factory TranslationItem.fromJson(Map<String, dynamic> json) =>
      _$TranslationItemFromJson(json);
}
