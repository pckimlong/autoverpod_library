// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_example.dart';

// **************************************************************************
// FormProviderGenerator
// **************************************************************************

// ============================================================================
// AUTOVERPOD GENERATED FORM PROVIDER - DO NOT MODIFY BY HAND
// ============================================================================
//
// Generated from: counterFormProvider
//
// GENERATED PROVIDER:
// - counterFormCallStatusProvider: Form submission mutation provider
//
// ABSTRACT CLASS: _$CounterFormWidget
// - call(): Submit form with mutation handling
// - submit(): Override to implement form submission logic with MutationTransaction
// - onSuccess(): Override to handle successful submissions
//

final counterFormCallStatusProvider = Mutation<String>();

abstract class _$CounterFormWidget extends _$CounterForm {
  /// Callback for when the form is successfully submitted.
  /// Override this method and run "dart pub run build_runner build" to make it work. otherwise error will be thrown.
  @protected
  void onSuccess(String result);
  @nonVirtual
  Future<String> call() async {
    final result = await counterFormCallStatusProvider.run(this.ref, (
      tsx,
    ) async {
      final result = await submit(tsx, this.state);
      return result;
    });

    if (this.ref.read(counterFormCallStatusProvider).isSuccess) {
      onSuccess(result);
    }

    return result;
  }

  void invalidateSelf() {
    counterFormCallStatusProvider.reset(this.ref);
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
  Future<String> submit(MutationTransaction tsx, CounterState state);

  /// Update the state of the form.
  /// This allows for more flexible updates to specific fields.
  void updateState(CounterState Function(CounterState state) update) =>
      this.state = update(this.state);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CounterForm)
@formWidget
const counterFormProvider = CounterFormProvider._();

@formWidget
final class CounterFormProvider
    extends $NotifierProvider<CounterForm, CounterState> {
  const CounterFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'counterFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$counterFormHash();

  @$internal
  @override
  CounterForm create() => CounterForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CounterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CounterState>(value),
    );
  }
}

String _$counterFormHash() => r'e6a94e6e766a5e634ba08633f285aaf176bc7a81';

@formWidget
abstract class _$CounterForm extends $Notifier<CounterState> {
  CounterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CounterState, CounterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CounterState, CounterState>,
              CounterState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
