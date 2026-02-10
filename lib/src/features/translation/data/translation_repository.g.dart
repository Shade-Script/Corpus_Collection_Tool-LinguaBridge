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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
