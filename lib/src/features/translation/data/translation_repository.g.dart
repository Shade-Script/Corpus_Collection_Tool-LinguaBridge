// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$translationRepositoryHash() =>
    r'bf8bf39fb5a38c612f39374a0aad1ea02f124243';

/// See also [translationRepository].
@ProviderFor(translationRepository)
final translationRepositoryProvider = Provider<TranslationRepository>.internal(
  translationRepository,
  name: r'translationRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$translationRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TranslationRepositoryRef = ProviderRef<TranslationRepository>;
String _$watchTranslationsHash() => r'b959b61f496f72773fcf0fd4a9209b4960cb951b';

/// See also [watchTranslations].
@ProviderFor(watchTranslations)
final watchTranslationsProvider =
    AutoDisposeStreamProvider<List<TranslationItem>>.internal(
      watchTranslations,
      name: r'watchTranslationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$watchTranslationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WatchTranslationsRef =
    AutoDisposeStreamProviderRef<List<TranslationItem>>;
String _$watchTranslationsByLanguageHash() =>
    r'7572971d6acfeec4991943b00a10eaffa9086880';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [watchTranslationsByLanguage].
@ProviderFor(watchTranslationsByLanguage)
const watchTranslationsByLanguageProvider = WatchTranslationsByLanguageFamily();

/// See also [watchTranslationsByLanguage].
class WatchTranslationsByLanguageFamily
    extends Family<AsyncValue<List<TranslationItem>>> {
  /// See also [watchTranslationsByLanguage].
  const WatchTranslationsByLanguageFamily();

  /// See also [watchTranslationsByLanguage].
  WatchTranslationsByLanguageProvider call(String languageName) {
    return WatchTranslationsByLanguageProvider(languageName);
  }

  @override
  WatchTranslationsByLanguageProvider getProviderOverride(
    covariant WatchTranslationsByLanguageProvider provider,
  ) {
    return call(provider.languageName);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'watchTranslationsByLanguageProvider';
}

/// See also [watchTranslationsByLanguage].
class WatchTranslationsByLanguageProvider
    extends AutoDisposeStreamProvider<List<TranslationItem>> {
  /// See also [watchTranslationsByLanguage].
  WatchTranslationsByLanguageProvider(String languageName)
    : this._internal(
        (ref) => watchTranslationsByLanguage(
          ref as WatchTranslationsByLanguageRef,
          languageName,
        ),
        from: watchTranslationsByLanguageProvider,
        name: r'watchTranslationsByLanguageProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$watchTranslationsByLanguageHash,
        dependencies: WatchTranslationsByLanguageFamily._dependencies,
        allTransitiveDependencies:
            WatchTranslationsByLanguageFamily._allTransitiveDependencies,
        languageName: languageName,
      );

  WatchTranslationsByLanguageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.languageName,
  }) : super.internal();

  final String languageName;

  @override
  Override overrideWith(
    Stream<List<TranslationItem>> Function(
      WatchTranslationsByLanguageRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchTranslationsByLanguageProvider._internal(
        (ref) => create(ref as WatchTranslationsByLanguageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        languageName: languageName,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<TranslationItem>> createElement() {
    return _WatchTranslationsByLanguageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchTranslationsByLanguageProvider &&
        other.languageName == languageName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, languageName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WatchTranslationsByLanguageRef
    on AutoDisposeStreamProviderRef<List<TranslationItem>> {
  /// The parameter `languageName` of this provider.
  String get languageName;
}

class _WatchTranslationsByLanguageProviderElement
    extends AutoDisposeStreamProviderElement<List<TranslationItem>>
    with WatchTranslationsByLanguageRef {
  _WatchTranslationsByLanguageProviderElement(super.provider);

  @override
  String get languageName =>
      (origin as WatchTranslationsByLanguageProvider).languageName;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
