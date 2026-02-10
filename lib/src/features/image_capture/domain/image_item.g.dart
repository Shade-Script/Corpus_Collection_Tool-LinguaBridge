// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageItemImpl _$$ImageItemImplFromJson(Map<String, dynamic> json) =>
    _$ImageItemImpl(
      id: json['id'] as String,
      filePath: json['filePath'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$$ImageItemImplToJson(_$ImageItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
      'tags': instance.tags,
      'timestamp': instance.timestamp.toIso8601String(),
      'userId': instance.userId,
    };
