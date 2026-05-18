// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LanguageImpl _$$LanguageImplFromJson(Map<String, dynamic> json) =>
    _$LanguageImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      nativeName: json['nativeName'] as String?,
      location: json['location'] as String,
      tribe: json['tribe'] as String?,
      dialect: json['dialect'] as String?,
      script: json['script'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      contributorId: json['contributorId'] as String?,
    );

Map<String, dynamic> _$$LanguageImplToJson(_$LanguageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nativeName': instance.nativeName,
      'location': instance.location,
      'tribe': instance.tribe,
      'dialect': instance.dialect,
      'script': instance.script,
      'timestamp': instance.timestamp.toIso8601String(),
      'contributorId': instance.contributorId,
    };
