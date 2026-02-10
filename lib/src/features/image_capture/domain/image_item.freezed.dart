// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ImageItem _$ImageItemFromJson(Map<String, dynamic> json) {
  return _ImageItem.fromJson(json);
}

/// @nodoc
mixin _$ImageItem {
  String get id => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;

  /// Serializes this ImageItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageItemCopyWith<ImageItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageItemCopyWith<$Res> {
  factory $ImageItemCopyWith(ImageItem value, $Res Function(ImageItem) then) =
      _$ImageItemCopyWithImpl<$Res, ImageItem>;
  @useResult
  $Res call({
    String id,
    String filePath,
    List<String> tags,
    DateTime timestamp,
    String? userId,
  });
}

/// @nodoc
class _$ImageItemCopyWithImpl<$Res, $Val extends ImageItem>
    implements $ImageItemCopyWith<$Res> {
  _$ImageItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filePath = null,
    Object? tags = null,
    Object? timestamp = null,
    Object? userId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            filePath: null == filePath
                ? _value.filePath
                : filePath // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ImageItemImplCopyWith<$Res>
    implements $ImageItemCopyWith<$Res> {
  factory _$$ImageItemImplCopyWith(
    _$ImageItemImpl value,
    $Res Function(_$ImageItemImpl) then,
  ) = __$$ImageItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String filePath,
    List<String> tags,
    DateTime timestamp,
    String? userId,
  });
}

/// @nodoc
class __$$ImageItemImplCopyWithImpl<$Res>
    extends _$ImageItemCopyWithImpl<$Res, _$ImageItemImpl>
    implements _$$ImageItemImplCopyWith<$Res> {
  __$$ImageItemImplCopyWithImpl(
    _$ImageItemImpl _value,
    $Res Function(_$ImageItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ImageItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filePath = null,
    Object? tags = null,
    Object? timestamp = null,
    Object? userId = freezed,
  }) {
    return _then(
      _$ImageItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        filePath: null == filePath
            ? _value.filePath
            : filePath // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageItemImpl implements _ImageItem {
  const _$ImageItemImpl({
    required this.id,
    required this.filePath,
    required final List<String> tags,
    required this.timestamp,
    this.userId,
  }) : _tags = tags;

  factory _$ImageItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageItemImplFromJson(json);

  @override
  final String id;
  @override
  final String filePath;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime timestamp;
  @override
  final String? userId;

  @override
  String toString() {
    return 'ImageItem(id: $id, filePath: $filePath, tags: $tags, timestamp: $timestamp, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    filePath,
    const DeepCollectionEquality().hash(_tags),
    timestamp,
    userId,
  );

  /// Create a copy of ImageItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageItemImplCopyWith<_$ImageItemImpl> get copyWith =>
      __$$ImageItemImplCopyWithImpl<_$ImageItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageItemImplToJson(this);
  }
}

abstract class _ImageItem implements ImageItem {
  const factory _ImageItem({
    required final String id,
    required final String filePath,
    required final List<String> tags,
    required final DateTime timestamp,
    final String? userId,
  }) = _$ImageItemImpl;

  factory _ImageItem.fromJson(Map<String, dynamic> json) =
      _$ImageItemImpl.fromJson;

  @override
  String get id;
  @override
  String get filePath;
  @override
  List<String> get tags;
  @override
  DateTime get timestamp;
  @override
  String? get userId;

  /// Create a copy of ImageItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageItemImplCopyWith<_$ImageItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
