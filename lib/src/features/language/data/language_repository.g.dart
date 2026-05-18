// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$languageRepositoryHash() =>
    r'bea90154276848296dd2810b3720cc8e9d3de6ad';

/// See also [languageRepository].
@ProviderFor(languageRepository)
final languageRepositoryProvider = Provider<LanguageRepository>.internal(
  languageRepository,
  name: r'languageRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$languageRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LanguageRepositoryRef = ProviderRef<LanguageRepository>;
String _$watchLanguagesHash() => r'557720eecff8f4ea0942892fe2cd55deb0f0a398';

/// See also [watchLanguages].
@ProviderFor(watchLanguages)
final watchLanguagesProvider =
    AutoDisposeStreamProvider<List<Language>>.internal(
      watchLanguages,
      name: r'watchLanguagesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$watchLanguagesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WatchLanguagesRef = AutoDisposeStreamProviderRef<List<Language>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
