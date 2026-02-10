// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TranslationItem _$TranslationItemFromJson(Map<String, dynamic> json) {
  return _TranslationItem.fromJson(json);
}

/// @nodoc
mixin _$TranslationItem {
  String get id => throw _privateConstructorUsedError;
  String get sourceText => throw _privateConstructorUsedError;
  String get translatedText => throw _privateConstructorUsedError;
  String get sourceLanguage => throw _privateConstructorUsedError;
  String get targetLanguage => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this TranslationItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TranslationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TranslationItemCopyWith<TranslationItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationItemCopyWith<$Res> {
  factory $TranslationItemCopyWith(
    TranslationItem value,
    $Res Function(TranslationItem) then,
  ) = _$TranslationItemCopyWithImpl<$Res, TranslationItem>;
  @useResult
  $Res call({
    String id,
    String sourceText,
    String translatedText,
    String sourceLanguage,
    String targetLanguage,
    DateTime timestamp,
    String? userId,
    String? imageUrl,
  });
}

/// @nodoc
class _$TranslationItemCopyWithImpl<$Res, $Val extends TranslationItem>
    implements $TranslationItemCopyWith<$Res> {
  _$TranslationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceText = null,
    Object? translatedText = null,
    Object? sourceLanguage = null,
    Object? targetLanguage = null,
    Object? timestamp = null,
    Object? userId = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceText: null == sourceText
                ? _value.sourceText
                : sourceText // ignore: cast_nullable_to_non_nullable
                      as String,
            translatedText: null == translatedText
                ? _value.translatedText
                : translatedText // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceLanguage: null == sourceLanguage
                ? _value.sourceLanguage
                : sourceLanguage // ignore: cast_nullable_to_non_nullable
                      as String,
            targetLanguage: null == targetLanguage
                ? _value.targetLanguage
                : targetLanguage // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TranslationItemImplCopyWith<$Res>
    implements $TranslationItemCopyWith<$Res> {
  factory _$$TranslationItemImplCopyWith(
    _$TranslationItemImpl value,
    $Res Function(_$TranslationItemImpl) then,
  ) = __$$TranslationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String sourceText,
    String translatedText,
    String sourceLanguage,
    String targetLanguage,
    DateTime timestamp,
    String? userId,
    String? imageUrl,
  });
}

/// @nodoc
class __$$TranslationItemImplCopyWithImpl<$Res>
    extends _$TranslationItemCopyWithImpl<$Res, _$TranslationItemImpl>
    implements _$$TranslationItemImplCopyWith<$Res> {
  __$$TranslationItemImplCopyWithImpl(
    _$TranslationItemImpl _value,
    $Res Function(_$TranslationItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TranslationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceText = null,
    Object? translatedText = null,
    Object? sourceLanguage = null,
    Object? targetLanguage = null,
    Object? timestamp = null,
    Object? userId = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$TranslationItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceText: null == sourceText
            ? _value.sourceText
            : sourceText // ignore: cast_nullable_to_non_nullable
                  as String,
        translatedText: null == translatedText
            ? _value.translatedText
            : translatedText // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceLanguage: null == sourceLanguage
            ? _value.sourceLanguage
            : sourceLanguage // ignore: cast_nullable_to_non_nullable
                  as String,
        targetLanguage: null == targetLanguage
            ? _value.targetLanguage
            : targetLanguage // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TranslationItemImpl implements _TranslationItem {
  const _$TranslationItemImpl({
    required this.id,
    required this.sourceText,
    required this.translatedText,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.timestamp,
    this.userId,
    this.imageUrl,
  });

  factory _$TranslationItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TranslationItemImplFromJson(json);

  @override
  final String id;
  @override
  final String sourceText;
  @override
  final String translatedText;
  @override
  final String sourceLanguage;
  @override
  final String targetLanguage;
  @override
  final DateTime timestamp;
  @override
  final String? userId;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'TranslationItem(id: $id, sourceText: $sourceText, translatedText: $translatedText, sourceLanguage: $sourceLanguage, targetLanguage: $targetLanguage, timestamp: $timestamp, userId: $userId, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceText, sourceText) ||
                other.sourceText == sourceText) &&
            (identical(other.translatedText, translatedText) ||
                other.translatedText == translatedText) &&
            (identical(other.sourceLanguage, sourceLanguage) ||
                other.sourceLanguage == sourceLanguage) &&
            (identical(other.targetLanguage, targetLanguage) ||
                other.targetLanguage == targetLanguage) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sourceText,
    translatedText,
    sourceLanguage,
    targetLanguage,
    timestamp,
    userId,
    imageUrl,
  );

  /// Create a copy of TranslationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationItemImplCopyWith<_$TranslationItemImpl> get copyWith =>
      __$$TranslationItemImplCopyWithImpl<_$TranslationItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TranslationItemImplToJson(this);
  }
}

abstract class _TranslationItem implements TranslationItem {
  const factory _TranslationItem({
    required final String id,
    required final String sourceText,
    required final String translatedText,
    required final String sourceLanguage,
    required final String targetLanguage,
    required final DateTime timestamp,
    final String? userId,
    final String? imageUrl,
  }) = _$TranslationItemImpl;

  factory _TranslationItem.fromJson(Map<String, dynamic> json) =
      _$TranslationItemImpl.fromJson;

  @override
  String get id;
  @override
  String get sourceText;
  @override
  String get translatedText;
  @override
  String get sourceLanguage;
  @override
  String get targetLanguage;
  @override
  DateTime get timestamp;
  @override
  String? get userId;
  @override
  String? get imageUrl;

  /// Create a copy of TranslationItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranslationItemImplCopyWith<_$TranslationItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
