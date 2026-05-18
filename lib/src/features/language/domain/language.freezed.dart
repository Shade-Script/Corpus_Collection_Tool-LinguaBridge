// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Language _$LanguageFromJson(Map<String, dynamic> json) {
  return _Language.fromJson(json);
}

/// @nodoc
mixin _$Language {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get nativeName => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String? get tribe => throw _privateConstructorUsedError;
  String? get dialect => throw _privateConstructorUsedError;
  String get script => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get contributorId => throw _privateConstructorUsedError;

  /// Serializes this Language to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LanguageCopyWith<Language> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageCopyWith<$Res> {
  factory $LanguageCopyWith(Language value, $Res Function(Language) then) =
      _$LanguageCopyWithImpl<$Res, Language>;
  @useResult
  $Res call({
    String id,
    String name,
    String? nativeName,
    String location,
    String? tribe,
    String? dialect,
    String script,
    DateTime timestamp,
    String? contributorId,
  });
}

/// @nodoc
class _$LanguageCopyWithImpl<$Res, $Val extends Language>
    implements $LanguageCopyWith<$Res> {
  _$LanguageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nativeName = freezed,
    Object? location = null,
    Object? tribe = freezed,
    Object? dialect = freezed,
    Object? script = null,
    Object? timestamp = null,
    Object? contributorId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            nativeName: freezed == nativeName
                ? _value.nativeName
                : nativeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            tribe: freezed == tribe
                ? _value.tribe
                : tribe // ignore: cast_nullable_to_non_nullable
                      as String?,
            dialect: freezed == dialect
                ? _value.dialect
                : dialect // ignore: cast_nullable_to_non_nullable
                      as String?,
            script: null == script
                ? _value.script
                : script // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            contributorId: freezed == contributorId
                ? _value.contributorId
                : contributorId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LanguageImplCopyWith<$Res>
    implements $LanguageCopyWith<$Res> {
  factory _$$LanguageImplCopyWith(
    _$LanguageImpl value,
    $Res Function(_$LanguageImpl) then,
  ) = __$$LanguageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? nativeName,
    String location,
    String? tribe,
    String? dialect,
    String script,
    DateTime timestamp,
    String? contributorId,
  });
}

/// @nodoc
class __$$LanguageImplCopyWithImpl<$Res>
    extends _$LanguageCopyWithImpl<$Res, _$LanguageImpl>
    implements _$$LanguageImplCopyWith<$Res> {
  __$$LanguageImplCopyWithImpl(
    _$LanguageImpl _value,
    $Res Function(_$LanguageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nativeName = freezed,
    Object? location = null,
    Object? tribe = freezed,
    Object? dialect = freezed,
    Object? script = null,
    Object? timestamp = null,
    Object? contributorId = freezed,
  }) {
    return _then(
      _$LanguageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        nativeName: freezed == nativeName
            ? _value.nativeName
            : nativeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        tribe: freezed == tribe
            ? _value.tribe
            : tribe // ignore: cast_nullable_to_non_nullable
                  as String?,
        dialect: freezed == dialect
            ? _value.dialect
            : dialect // ignore: cast_nullable_to_non_nullable
                  as String?,
        script: null == script
            ? _value.script
            : script // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        contributorId: freezed == contributorId
            ? _value.contributorId
            : contributorId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LanguageImpl implements _Language {
  const _$LanguageImpl({
    required this.id,
    required this.name,
    this.nativeName,
    required this.location,
    this.tribe,
    this.dialect,
    required this.script,
    required this.timestamp,
    this.contributorId,
  });

  factory _$LanguageImpl.fromJson(Map<String, dynamic> json) =>
      _$$LanguageImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? nativeName;
  @override
  final String location;
  @override
  final String? tribe;
  @override
  final String? dialect;
  @override
  final String script;
  @override
  final DateTime timestamp;
  @override
  final String? contributorId;

  @override
  String toString() {
    return 'Language(id: $id, name: $name, nativeName: $nativeName, location: $location, tribe: $tribe, dialect: $dialect, script: $script, timestamp: $timestamp, contributorId: $contributorId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nativeName, nativeName) ||
                other.nativeName == nativeName) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.tribe, tribe) || other.tribe == tribe) &&
            (identical(other.dialect, dialect) || other.dialect == dialect) &&
            (identical(other.script, script) || other.script == script) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.contributorId, contributorId) ||
                other.contributorId == contributorId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    nativeName,
    location,
    tribe,
    dialect,
    script,
    timestamp,
    contributorId,
  );

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageImplCopyWith<_$LanguageImpl> get copyWith =>
      __$$LanguageImplCopyWithImpl<_$LanguageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LanguageImplToJson(this);
  }
}

abstract class _Language implements Language {
  const factory _Language({
    required final String id,
    required final String name,
    final String? nativeName,
    required final String location,
    final String? tribe,
    final String? dialect,
    required final String script,
    required final DateTime timestamp,
    final String? contributorId,
  }) = _$LanguageImpl;

  factory _Language.fromJson(Map<String, dynamic> json) =
      _$LanguageImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get nativeName;
  @override
  String get location;
  @override
  String? get tribe;
  @override
  String? get dialect;
  @override
  String get script;
  @override
  DateTime get timestamp;
  @override
  String? get contributorId;

  /// Create a copy of Language
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LanguageImplCopyWith<_$LanguageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
