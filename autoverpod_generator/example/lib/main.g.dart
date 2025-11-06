// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// FormProviderGenerator
// **************************************************************************

// ============================================================================
// AUTOVERPOD GENERATED FORM PROVIDER - DO NOT MODIFY BY HAND
// ============================================================================
//
// Generated from: shopCreateProvider
//
// GENERATED PROVIDER:
// - shopCreateCallStatusProvider: Form submission mutation provider
//
// ABSTRACT CLASS: _$ShopCreateWidget
// - call(): Submit form with mutation handling
// - submit(): Override to implement form submission logic with MutationTransaction
// - onSuccess(): Override to handle successful submissions
//

final shopCreateCallStatusProvider = Mutation<int>();

abstract class _$ShopCreateWidget extends _$ShopCreate {
  /// Callback for when the form is successfully submitted.
  /// Override this method and run "dart pub run build_runner build" to make it work. otherwise error will be thrown.
  @protected
  void onSuccess(int result);
  @nonVirtual
  Future<int> call() async {
    final result = await shopCreateCallStatusProvider.run(this.ref, (
      tsx,
    ) async {
      final result = await submit(tsx, this.state);
      return result;
    });

    if (this.ref.read(shopCreateCallStatusProvider).isSuccess) {
      onSuccess(result);
    }

    return result;
  }

  void invalidateSelf() {
    shopCreateCallStatusProvider.reset(this.ref);
    this.ref.invalidateSelf();
  }

  /// Internal submit implementation for form submission.
  ///
  /// ⚠️ WARNING: Do not call this method directly - use [call] instead.
  /// Direct usage bypasses:
  /// - Error handling
  /// - Loading state management
  /// - Success callback handling
  /// - Form validation
  ///
  /// This method should be overridden to implement the actual form submission logic:
  /// 1. Validate form data
  /// 2. Transform data if needed
  /// 3. Call API/repository methods
  /// 4. Return success/failure result
  @visibleForOverriding
  @protected
  Future<int> submit(MutationTransaction tsx, ShopCreateState state);

  /// Update the state of the form.
  /// This allows for more flexible updates to specific fields.
  void updateState(ShopCreateState Function(ShopCreateState state) update) =>
      this.state = update(this.state);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShopCreate)
@formWidget
const shopCreateProvider = ShopCreateProvider._();

@formWidget
final class ShopCreateProvider
    extends $NotifierProvider<ShopCreate, ShopCreateState> {
  const ShopCreateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shopCreateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shopCreateHash();

  @$internal
  @override
  ShopCreate create() => ShopCreate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShopCreateState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShopCreateState>(value),
    );
  }
}

String _$shopCreateHash() => r'39a4fb22132a7f6e6baf775401d4e437210661de';

@formWidget
abstract class _$ShopCreate extends $Notifier<ShopCreateState> {
  ShopCreateState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ShopCreateState, ShopCreateState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ShopCreateState, ShopCreateState>,
              ShopCreateState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
