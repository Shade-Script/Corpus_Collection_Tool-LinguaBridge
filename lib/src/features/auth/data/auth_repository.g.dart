// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'2c8ad8222b9be48f6b27bf7158bf7eb5ed6a3d34';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$authStateChangesHash() => r'516467ccef2d665b1316843bfc1759e7248e9dc2';

/// See also [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = StreamProvider<User?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthStateChangesRef = StreamProviderRef<User?>;
String _$watchAppUserHash() => r'919a03cb02bfc837e9f289d01a03f9975662b89c';

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

/// See also [watchAppUser].
@ProviderFor(watchAppUser)
const watchAppUserProvider = WatchAppUserFamily();

/// See also [watchAppUser].
class WatchAppUserFamily extends Family<AsyncValue<AppUser?>> {
  /// See also [watchAppUser].
  const WatchAppUserFamily();

  /// See also [watchAppUser].
  WatchAppUserProvider call(String uid) {
    return WatchAppUserProvider(uid);
  }

  @override
  WatchAppUserProvider getProviderOverride(
    covariant WatchAppUserProvider provider,
  ) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'watchAppUserProvider';
}

/// See also [watchAppUser].
class WatchAppUserProvider extends AutoDisposeStreamProvider<AppUser?> {
  /// See also [watchAppUser].
  WatchAppUserProvider(String uid)
    : this._internal(
        (ref) => watchAppUser(ref as WatchAppUserRef, uid),
        from: watchAppUserProvider,
        name: r'watchAppUserProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$watchAppUserHash,
        dependencies: WatchAppUserFamily._dependencies,
        allTransitiveDependencies:
            WatchAppUserFamily._allTransitiveDependencies,
        uid: uid,
      );

  WatchAppUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    Stream<AppUser?> Function(WatchAppUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchAppUserProvider._internal(
        (ref) => create(ref as WatchAppUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<AppUser?> createElement() {
    return _WatchAppUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchAppUserProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WatchAppUserRef on AutoDisposeStreamProviderRef<AppUser?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _WatchAppUserProviderElement
    extends AutoDisposeStreamProviderElement<AppUser?>
    with WatchAppUserRef {
  _WatchAppUserProviderElement(super.provider);

  @override
  String get uid => (origin as WatchAppUserProvider).uid;
}

String _$watchLeaderboardHash() => r'4e9adb6344aaa4029c73dc7e63d5e4a63ee1c675';

/// See also [watchLeaderboard].
@ProviderFor(watchLeaderboard)
final watchLeaderboardProvider =
    AutoDisposeStreamProvider<List<AppUser>>.internal(
      watchLeaderboard,
      name: r'watchLeaderboardProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$watchLeaderboardHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WatchLeaderboardRef = AutoDisposeStreamProviderRef<List<AppUser>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
