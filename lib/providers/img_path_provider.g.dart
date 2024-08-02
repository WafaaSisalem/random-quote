// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'img_path_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$imgsPathsHash() => r'9c18c133e6289f824476f22bcbf759a2143e8148';

/// See also [imgsPaths].
@ProviderFor(imgsPaths)
final imgsPathsProvider = FutureProvider<List<String>>.internal(
  imgsPaths,
  name: r'imgsPathsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$imgsPathsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ImgsPathsRef = FutureProviderRef<List<String>>;
String _$selectedImagePathHash() => r'7885ff625d4fb512320639bb184853c576488393';

/// See also [SelectedImagePath].
@ProviderFor(SelectedImagePath)
final selectedImagePathProvider =
    NotifierProvider<SelectedImagePath, String>.internal(
  SelectedImagePath.new,
  name: r'selectedImagePathProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedImagePathHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedImagePath = Notifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
