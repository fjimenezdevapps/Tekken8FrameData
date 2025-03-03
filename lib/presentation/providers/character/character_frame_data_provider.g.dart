// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_frame_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'fe8960d513b40b38c3d2d1c5e5d493532cf85cfe';

/// Proveedor para la instancia de Dio.
///
/// Copied from [dio].
@ProviderFor(dio)
final dioProvider = Provider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRef = ProviderRef<Dio>;
String _$remoteDataSourceHash() => r'9ef51a85cbf5352322af16f5e33852effb5ba5bd';

/// Proveedor para el data source remoto.
///
/// Copied from [remoteDataSource].
@ProviderFor(remoteDataSource)
final remoteDataSourceProvider =
    Provider<CharacterFrameDataRemoteDataSource>.internal(
  remoteDataSource,
  name: r'remoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemoteDataSourceRef = ProviderRef<CharacterFrameDataRemoteDataSource>;
String _$characterFrameDataRepositoryHash() =>
    r'707295f67366b78e4aa6301a53612ab610d8a090';

/// Proveedor para el repositorio.
///
/// Copied from [characterFrameDataRepository].
@ProviderFor(characterFrameDataRepository)
final characterFrameDataRepositoryProvider =
    Provider<CharacterFrameDataRepository>.internal(
  characterFrameDataRepository,
  name: r'characterFrameDataRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$characterFrameDataRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CharacterFrameDataRepositoryRef
    = ProviderRef<CharacterFrameDataRepository>;
String _$characterFrameDataHash() =>
    r'2ac2a29690e8cd91f1a6a82d599e82e49b4bf903';

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

/// Family Provider que expone el caso de uso para obtener la información de un personaje
///
/// Copied from [characterFrameData].
@ProviderFor(characterFrameData)
const characterFrameDataProvider = CharacterFrameDataFamily();

/// Family Provider que expone el caso de uso para obtener la información de un personaje
///
/// Copied from [characterFrameData].
class CharacterFrameDataFamily extends Family<AsyncValue<CharacterFrameData>> {
  /// Family Provider que expone el caso de uso para obtener la información de un personaje
  ///
  /// Copied from [characterFrameData].
  const CharacterFrameDataFamily();

  /// Family Provider que expone el caso de uso para obtener la información de un personaje
  ///
  /// Copied from [characterFrameData].
  CharacterFrameDataProvider call(
    String characterName,
  ) {
    return CharacterFrameDataProvider(
      characterName,
    );
  }

  @override
  CharacterFrameDataProvider getProviderOverride(
    covariant CharacterFrameDataProvider provider,
  ) {
    return call(
      provider.characterName,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'characterFrameDataProvider';
}

/// Family Provider que expone el caso de uso para obtener la información de un personaje
///
/// Copied from [characterFrameData].
class CharacterFrameDataProvider extends FutureProvider<CharacterFrameData> {
  /// Family Provider que expone el caso de uso para obtener la información de un personaje
  ///
  /// Copied from [characterFrameData].
  CharacterFrameDataProvider(
    String characterName,
  ) : this._internal(
          (ref) => characterFrameData(
            ref as CharacterFrameDataRef,
            characterName,
          ),
          from: characterFrameDataProvider,
          name: r'characterFrameDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$characterFrameDataHash,
          dependencies: CharacterFrameDataFamily._dependencies,
          allTransitiveDependencies:
              CharacterFrameDataFamily._allTransitiveDependencies,
          characterName: characterName,
        );

  CharacterFrameDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.characterName,
  }) : super.internal();

  final String characterName;

  @override
  Override overrideWith(
    FutureOr<CharacterFrameData> Function(CharacterFrameDataRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CharacterFrameDataProvider._internal(
        (ref) => create(ref as CharacterFrameDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        characterName: characterName,
      ),
    );
  }

  @override
  FutureProviderElement<CharacterFrameData> createElement() {
    return _CharacterFrameDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CharacterFrameDataProvider &&
        other.characterName == characterName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, characterName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CharacterFrameDataRef on FutureProviderRef<CharacterFrameData> {
  /// The parameter `characterName` of this provider.
  String get characterName;
}

class _CharacterFrameDataProviderElement
    extends FutureProviderElement<CharacterFrameData>
    with CharacterFrameDataRef {
  _CharacterFrameDataProviderElement(super.provider);

  @override
  String get characterName =>
      (origin as CharacterFrameDataProvider).characterName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
