// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_resolution_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ImportResolution)
@stateWidget
final importResolutionProvider = ImportResolutionProvider._();

@stateWidget
final class ImportResolutionProvider
    extends $NotifierProvider<ImportResolution, ImportResolutionState> {
  ImportResolutionProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'importResolutionProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$importResolutionHash();

  @$internal
  @override
  ImportResolution create() => ImportResolution();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImportResolutionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImportResolutionState>(value),
    );
  }
}

String _$importResolutionHash() => r'95f1b409f906292b3d411693719673b6a6cb7872';

@stateWidget
abstract class _$ImportResolution extends $Notifier<ImportResolutionState> {
  ImportResolutionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ImportResolutionState, ImportResolutionState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ImportResolutionState, ImportResolutionState>,
        ImportResolutionState,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
