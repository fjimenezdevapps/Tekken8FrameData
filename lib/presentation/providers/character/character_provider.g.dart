// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$characterNotifierHash() => r'67e569b5cf614aeb1af317a0903a8101e101b877';

/// Notificador de estado para gestionar la lista de personajes
///
/// Copied from [CharacterNotifier].
@ProviderFor(CharacterNotifier)
final characterNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CharacterNotifier, List<Character>>.internal(
  CharacterNotifier.new,
  name: r'characterNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$characterNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CharacterNotifier = AutoDisposeAsyncNotifier<List<Character>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
