import 'package:freezed_annotation/freezed_annotation.dart';

part 'language.freezed.dart';
part 'language.g.dart';

@freezed
class Language with _$Language {
  const factory Language({
    required String id,
    required String name,
    String? nativeName,
    required String location,
    String? tribe,
    String? dialect,
    required String script,
    required DateTime timestamp,
    String? contributorId,
  }) = _Language;

  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);
}
