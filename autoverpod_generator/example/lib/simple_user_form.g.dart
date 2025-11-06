// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_user_form.dart';

// **************************************************************************
// FormProviderGenerator
// **************************************************************************

// ============================================================================
// AUTOVERPOD GENERATED FORM PROVIDER - DO NOT MODIFY BY HAND
// ============================================================================
//
// Generated from: simpleUserFormProvider
//
// GENERATED PROVIDER:
// - simpleUserFormCallStatusProvider: Form submission mutation provider
//
// ABSTRACT CLASS: _$SimpleUserFormWidget
// - call(): Submit form with mutation handling
// - submit(): Override to implement form submission logic with MutationTransaction
// - onSuccess(): Override to handle successful submissions
//

final simpleUserFormCallStatusProvider = Mutation<int>();

abstract class _$SimpleUserFormWidget extends _$SimpleUserForm {
  /// Callback for when the form is successfully submitted.
  /// Override this method and run "dart pub run build_runner build" to make it work. otherwise error will be thrown.
  @protected
  void onSuccess(int result);
  @nonVirtual
  Future<int> call() async {
    final result = await simpleUserFormCallStatusProvider.run(this.ref, (
      tsx,
    ) async {
      final result = await submit(tsx, this.state);
      return result;
    });

    if (this.ref.read(simpleUserFormCallStatusProvider).isSuccess) {
      onSuccess(result);
    }

    return result;
  }

  void invalidateSelf() {
    simpleUserFormCallStatusProvider.reset(this.ref);
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
  Future<int> submit(MutationTransaction tsx, SimpleUserState state);

  /// Update the state of the form.
  /// This allows for more flexible updates to specific fields.
  void updateState(SimpleUserState Function(SimpleUserState state) update) =>
      this.state = update(this.state);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SimpleUserForm)
@formWidget
const simpleUserFormProvider = SimpleUserFormProvider._();

@formWidget
final class SimpleUserFormProvider
    extends $NotifierProvider<SimpleUserForm, SimpleUserState> {
  const SimpleUserFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'simpleUserFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$simpleUserFormHash();

  @$internal
  @override
  SimpleUserForm create() => SimpleUserForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SimpleUserState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SimpleUserState>(value),
    );
  }
}

String _$simpleUserFormHash() => r'd492c949c7777405479d567d8d4207559bb1f344';

@formWidget
abstract class _$SimpleUserForm extends $Notifier<SimpleUserState> {
  SimpleUserState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SimpleUserState, SimpleUserState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SimpleUserState, SimpleUserState>,
              SimpleUserState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
