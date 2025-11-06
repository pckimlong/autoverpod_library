// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_product_form.dart';

// **************************************************************************
// FormProviderGenerator
// **************************************************************************

// ============================================================================
// AUTOVERPOD GENERATED FORM PROVIDER - DO NOT MODIFY BY HAND
// ============================================================================
//
// Generated from: simpleProductFormProvider
//
// GENERATED PROVIDER:
// - simpleProductFormCallStatusProvider: Form submission mutation provider
//
// ABSTRACT CLASS: _$SimpleProductFormWidget
// - call(): Submit form with mutation handling
// - submit(): Override to implement form submission logic with MutationTransaction
// - onSuccess(): Override to handle successful submissions
//

final simpleProductFormCallStatusProvider = Mutation<String>();

abstract class _$SimpleProductFormWidget extends _$SimpleProductForm {
  /// Callback for when the form is successfully submitted.
  /// Override this method and run "dart pub run build_runner build" to make it work. otherwise error will be thrown.
  @protected
  void onSuccess(String result);
  @nonVirtual
  Future<String> call() async {
    final result = await simpleProductFormCallStatusProvider.run(this.ref, (
      tsx,
    ) async {
      final result = await submit(tsx, this.state);
      return result;
    });

    if (this.ref.read(simpleProductFormCallStatusProvider).isSuccess) {
      onSuccess(result);
    }

    return result;
  }

  void invalidateSelf() {
    simpleProductFormCallStatusProvider.reset(this.ref);
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
  Future<String> submit(MutationTransaction tsx, SimpleProductState state);

  /// Update the state of the form.
  /// This allows for more flexible updates to specific fields.
  void updateState(
    SimpleProductState Function(SimpleProductState state) update,
  ) => this.state = update(this.state);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SimpleProductForm)
@formWidget
const simpleProductFormProvider = SimpleProductFormProvider._();

@formWidget
final class SimpleProductFormProvider
    extends $NotifierProvider<SimpleProductForm, SimpleProductState> {
  const SimpleProductFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'simpleProductFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$simpleProductFormHash();

  @$internal
  @override
  SimpleProductForm create() => SimpleProductForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SimpleProductState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SimpleProductState>(value),
    );
  }
}

String _$simpleProductFormHash() => r'971a68a21f5e4a152aa2a9abb3c0d4b3665683a0';

@formWidget
abstract class _$SimpleProductForm extends $Notifier<SimpleProductState> {
  SimpleProductState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SimpleProductState, SimpleProductState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SimpleProductState, SimpleProductState>,
              SimpleProductState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
