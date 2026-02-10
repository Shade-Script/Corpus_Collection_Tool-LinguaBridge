// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TranslationItemImpl _$$TranslationItemImplFromJson(
  Map<String, dynamic> json,
) => _$TranslationItemImpl(
  id: json['id'] as String,
  sourceText: json['sourceText'] as String,
  translatedText: json['translatedText'] as String,
  sourceLanguage: json['sourceLanguage'] as String,
  targetLanguage: json['targetLanguage'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  userId: json['userId'] as String?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$$TranslationItemImplToJson(
  _$TranslationItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sourceText': instance.sourceText,
  'translatedText': instance.translatedText,
  'sourceLanguage': instance.sourceLanguage,
  'targetLanguage': instance.targetLanguage,
  'timestamp': instance.timestamp.toIso8601String(),
  'userId': instance.userId,
  'imageUrl': instance.imageUrl,
};
