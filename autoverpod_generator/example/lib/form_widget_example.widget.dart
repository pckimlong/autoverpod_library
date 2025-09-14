// **************************************************************************
// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// ignore_for_file: type=lint, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unnecessary_import, unused_import
// coverage:ignore-file

import 'package:autoverpod_generator_example/form_widget_example.dart';
import 'dart:typed_data';
import 'package:autoverpod/autoverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp_utils/kimapp_utils.dart';

// ============================================================================
// AUTOVERPOD GENERATED FORM WIDGET - DO NOT MODIFY BY HAND
// ============================================================================
//
// Source: updateUserProvider → UpdateUserModel
//
// Widgets: UpdateUserScope, UpdateUserState, UpdateUserStatus, UpdateUserSelect
//
// Fields:
// - NameField (String): ref.textController | ref.updateName(value)
// - AgeField (int?): ref.updateAge(value)
// - EmailField (String?): ref.textController | ref.updateEmail(value)
// - AddressField (String?): ref.textController | ref.updateAddress(value)
// - PhoneField (String?): ref.textController | ref.updatePhone(value)
//

/// Extension that adds field update methods to the form provider.
/// These methods allow updating individual fields that have copyWith support.
extension UpdateUserFieldUpdater on UpdateUser {
  /// Update the name field of UpdateUserModel class.
  void updateName(String newValue) =>
      state = state.whenData((state) => state.copyWith(name: newValue));

  /// Update the age field of UpdateUserModel class.
  void updateAge(int? newValue) =>
      state = state.whenData((state) => state.copyWith(age: newValue));

  /// Update the email field of UpdateUserModel class.
  void updateEmail(String? newValue) => state = state.whenData(
    (state) => state.copyWith(
      email: newValue == null || newValue.isEmpty ? null : newValue,
    ),
  );

  /// Update the address field of UpdateUserModel class.
  void updateAddress(String? newValue) => state = state.whenData(
    (state) => state.copyWith(
      address: newValue == null || newValue.isEmpty ? null : newValue,
    ),
  );

  /// Update the phone field of UpdateUserModel class.
  void updatePhone(String? newValue) => state = state.whenData(
    (state) => state.copyWith(
      phone: newValue == null || newValue.isEmpty ? null : newValue,
    ),
  );
}

class _UpdateUserFormInheritedWidget extends InheritedWidget {
  const _UpdateUserFormInheritedWidget({
    required this.formKey,
    required this.params,
    required super.child,
  });

  final GlobalKey<FormState> formKey;
  final ({int id}) params;

  static _UpdateUserFormInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_UpdateUserFormInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(covariant _UpdateUserFormInheritedWidget oldWidget) {
    return formKey != oldWidget.formKey && params != oldWidget.params;
  }
}

class UpdateUserProxyWidgetRef extends WidgetRef {
  UpdateUserProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  ({int id}) get params => _UpdateUserFormInheritedWidget.of(context).params;

  AsyncValue<bool>? get status =>
      _ref.watch(updateUserCallStatusProvider((id: params.id)));

  GlobalKey<FormState> get formKey =>
      _UpdateUserFormInheritedWidget.of(context).formKey;

  UpdateUser get notifier => _ref.read(updateUserProvider(params.id).notifier);

  /// Submits the form. Internally this calls [notifier.submit] with the form key validated.
  Future<AsyncValue<bool>> submit({required Uint8List? photoBytes}) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return AsyncValue.error(
        Exception('Form is not valid'),
        StackTrace.current,
      );
    }
    formKey.currentState?.save();

    return await notifier(photoBytes: photoBytes);
  }

  Selected select<Selected>(Selected Function(UpdateUserModel) selector) =>
      _ref.watch(
        updateUserProvider(
          params.id,
        ).select((value) => selector(value.requireValue)),
      );

  @override
  BuildContext get context => _ref.context;

  @override
  bool exists(ProviderBase<Object?> provider) => _ref.exists(provider);

  @override
  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);

  @override
  void listen<T>(
    ProviderListenable<T> provider,
    void Function(T?, T) listener, {
    void Function(Object, StackTrace)? onError,
  }) => _ref.listen(provider, listener, onError: onError);

  @override
  ProviderSubscription<T> listenManual<T>(
    ProviderListenable<T> provider,
    void Function(T?, T) listener, {
    void Function(Object, StackTrace)? onError,
    bool fireImmediately = false,
  }) => _ref.listenManual(
    provider,
    listener,
    onError: onError,
    fireImmediately: fireImmediately,
  );

  @override
  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);

  @override
  State refresh<State>(Refreshable<State> provider) => _ref.refresh(provider);

  @override
  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);
}

class UpdateUserFormScope extends ConsumerStatefulWidget {
  const UpdateUserFormScope({
    super.key,
    required this.id,
    this.formKey,
    this.autovalidateMode,
    this.onPopInvokedWithResult,
    required this.builder,
    this.child,
    this.onSucceed,
    this.onInitLoading,
    this.onInitError,
  }) : assert(
         child != null || builder != null,
         'Either child or builder must be provided',
       );
  final int id;
  final Widget Function(
    BuildContext context,
    UpdateUserProxyWidgetRef ref,
    Widget? child,
  )?
  builder;
  final Widget? child;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;
  final void Function(bool, Object?)? onPopInvokedWithResult;
  final void Function(BuildContext context, bool value)? onSucceed;
  final Widget Function()? onInitLoading;
  final Widget Function(Object error, StackTrace stack)? onInitError;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateUserFormScopeState();
}

class _UpdateUserFormScopeState extends ConsumerState<UpdateUserFormScope> {
  late final GlobalKey<FormState> _cachedFormKey;

  @override
  void initState() {
    super.initState();
    _cachedFormKey = widget.formKey ?? GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _cachedFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(updateUserCallStatusProvider((id: widget.id)), (previous, next) {
      if (previous?.hasValue == false && next?.hasValue == true) {
        widget.onSucceed?.call(context, next!.requireValue);
      }
    });

    return _UpdateUserFormInheritedWidget(
      formKey: _cachedFormKey,
      params: (id: widget.id),
      child: Form(
        key: _cachedFormKey,
        autovalidateMode: widget.autovalidateMode,
        onPopInvokedWithResult: widget.onPopInvokedWithResult,
        child: Consumer(
          builder: (context, ref, child) {
            final isInitializedAsync = ref.watch(
              updateUserProvider(
                widget.id,
              ).select((dataAsync) => dataAsync.whenData((_) => true)),
            );

            return isInitializedAsync.when(
              skipLoadingOnReload: true,
              skipLoadingOnRefresh: true,
              data: (_) {
                if (widget.builder != null) {
                  return widget.builder!(
                    context,
                    UpdateUserProxyWidgetRef(ref),
                    widget.child,
                  );
                }

                return widget.child!;
              },
              error: (error, stack) =>
                  widget.onInitError?.call(error, stack) ??
                  Theme.of(context)
                      .extension<KimappThemeExtension>()
                      ?.defaultErrorStateWidget
                      ?.call(context, ref, error) ??
                  const SizedBox.shrink(),
              loading: () {
                return widget.onInitLoading?.call() ??
                    Theme.of(context)
                        .extension<KimappThemeExtension>()
                        ?.defaultLoadingStateWidget
                        ?.call(context, ref) ??
                    const Center(child: CircularProgressIndicator());
              },
            );
          },
        ),
      ),
    );
  }
}

bool _debugCheckHasUpdateUserForm(BuildContext context) {
  assert(() {
    if (context.widget is! UpdateUserFormScope &&
        context.findAncestorWidgetOfExactType<UpdateUserFormScope>() == null) {
      // Check if we're in a navigation context (dialog or pushed screen)
      final isInNavigation = ModalRoute.of(context) != null;

      if (!isInNavigation) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No UpdateUserFormScope found'),
          ErrorDescription(
            '${context.widget.runtimeType} widgets require a UpdateUserFormScope widget ancestor '
            'or to be used in a navigation context with proper state management.',
          ),
        ]);
      }
      // If in navigation context, we'll return true but log a warning
      debugPrint(
        'Widget ${context.widget.runtimeType} used in navigation without direct UpdateUserFormScope',
      );
    }
    return true;
  }());
  return true;
}

class UpdateUserFormParams extends ConsumerWidget {
  const UpdateUserFormParams({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    UpdateUserProxyWidgetRef ref,
    ({int id}) params,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    final params = _UpdateUserFormInheritedWidget.of(context).params;
    return builder(context, UpdateUserProxyWidgetRef(ref), params);
  }
}

class UpdateUserFormSelect<Selected> extends ConsumerWidget {
  const UpdateUserFormSelect({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(UpdateUserModel state) selector;
  final Widget Function(
    BuildContext context,
    UpdateUserProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    if (onStateChanged != null) {
      final params = _UpdateUserFormInheritedWidget.of(context).params;
      ref.listen(
        updateUserProvider(
          params.id,
        ).select((value) => selector(value.requireValue)),
        (pre, next) {
          if (pre != next) onStateChanged!(pre, next);
        },
      );
    }
    final stateRef = UpdateUserProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.select(selector));
  }
}

class UpdateUserFormState extends ConsumerWidget {
  const UpdateUserFormState({
    super.key,
    required this.builder,
    this.child,
    this.onStateChanged,
  });

  /// The builder function that constructs the widget tree.
  /// Access the state directly via ref.state, which is equivalent to ref.watch(updateUserProvider(params.id))
  ///
  /// For selecting specific fields, use ref.select() - e.g. ref.select((value) => value.someField)
  /// The ref parameter provides type-safe access to the provider state and notifier
  final Widget Function(
    BuildContext context,
    UpdateUserProxyWidgetRef ref,
    Widget? child,
  )
  builder;
  final Widget? child;
  final void Function(UpdateUserModel? previous, UpdateUserModel? next)?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    if (onStateChanged != null) {
      final params = _UpdateUserFormInheritedWidget.of(context).params;
      ref.listen(updateUserProvider(params.id), (pre, next) {
        if (pre != next) onStateChanged!(pre?.valueOrNull, next.valueOrNull);
      });
    }
    return UpdateUserFormParams(
      builder: (context, ref, params) =>
          builder(context, UpdateUserProxyWidgetRef(ref), child),
    );
  }
}

class UpdateUserFormStatus extends ConsumerWidget {
  const UpdateUserFormStatus({
    super.key,
    required this.builder,
    this.onChanged,
  });

  final Widget Function(
    BuildContext context,
    UpdateUserProxyWidgetRef ref,
    AsyncValue<bool>? status,
  )
  builder;
  final void Function(AsyncValue<bool>? previous, AsyncValue<bool>? next)?
  onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    if (onChanged != null) {
      final params = _UpdateUserFormInheritedWidget.of(context).params;
      ref.listen(updateUserCallStatusProvider((id: params.id)), (
        previous,
        next,
      ) {
        if (previous != next) {
          onChanged!(previous, next);
        }
      });
    }
    final stateRef = UpdateUserProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.status);
  }
}

class UpdateUserNameProxyWidgetRef extends UpdateUserProxyWidgetRef {
  UpdateUserNameProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get name => select((state) => state.name);

  /// Update the field value directly.
  void updateName(String newValue) => notifier.updateName(newValue);
}

class UpdateUserNameField extends HookConsumerWidget {
  const UpdateUserNameField({
    super.key,
    this.textController,
    this.onChanged,
    required this.builder,
  });

  /// Text controller for the field. If not provided, one will be created automatically.
  final TextEditingController? textController;

  /// Builder function that will be called with the context and ref.
  /// Field utilities are accessible via [ref]
  final Widget Function(BuildContext context, UpdateUserNameProxyWidgetRef ref)
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    final params = _UpdateUserFormInheritedWidget.of(context).params;

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref
        .read(updateUserProvider(params.id))
        .valueOrNull
        ?.name;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(
      updateUserProvider(params.id).select((value) => value.valueOrNull?.name),
      (previous, next) {
        if (previous != next && controller.text != next) {
          controller.text = next ?? "";
        }
        onChanged?.call(previous, next ?? "");
      },
    );

    // Initialize external controller if provided
    useEffect(() {
      if (textController != null &&
          initialValue != null &&
          textController!.text.isEmpty) {
        textController!.text = initialValue;
      }
      return null;
    }, []);

    // Setup text listener
    useEffect(() {
      void listener() {
        final currentValue = ref
            .read(updateUserProvider(params.id))
            .valueOrNull
            ?.name;
        if (currentValue != controller.text) {
          ref
              .read(updateUserProvider(params.id).notifier)
              .updateName(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = UpdateUserNameProxyWidgetRef(ref, textController: controller);

    return builder(context, proxy);
  }
}

class UpdateUserAgeProxyWidgetRef extends UpdateUserProxyWidgetRef {
  UpdateUserAgeProxyWidgetRef(super._ref);

  /// Access the field value directly.
  int? get age => select((state) => state.age);

  /// Update the field value directly.
  void updateAge(int? newValue) => notifier.updateAge(newValue);
}

class UpdateUserAgeField extends ConsumerWidget {
  const UpdateUserAgeField({super.key, required this.builder});

  final Widget Function(BuildContext context, UpdateUserAgeProxyWidgetRef ref)
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    final proxy = UpdateUserAgeProxyWidgetRef(ref);
    return builder(context, proxy);
  }
}

class UpdateUserEmailProxyWidgetRef extends UpdateUserProxyWidgetRef {
  UpdateUserEmailProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String? get email => select((state) => state.email);

  /// Update the field value directly.
  void updateEmail(String? newValue) => notifier.updateEmail(newValue);
}

class UpdateUserEmailField extends HookConsumerWidget {
  const UpdateUserEmailField({
    super.key,
    this.textController,
    this.onChanged,
    required this.builder,
  });

  /// Text controller for the field. If not provided, one will be created automatically.
  final TextEditingController? textController;

  /// Builder function that will be called with the context and ref.
  /// Field utilities are accessible via [ref]
  final Widget Function(BuildContext context, UpdateUserEmailProxyWidgetRef ref)
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String? next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    final params = _UpdateUserFormInheritedWidget.of(context).params;

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref
        .read(updateUserProvider(params.id))
        .valueOrNull
        ?.email;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(
      updateUserProvider(params.id).select((value) => value.valueOrNull?.email),
      (previous, next) {
        if (previous != next && controller.text != next) {
          controller.text = next ?? "";
        }
        onChanged?.call(previous, next ?? "");
      },
    );

    // Initialize external controller if provided
    useEffect(() {
      if (textController != null &&
          initialValue != null &&
          textController!.text.isEmpty) {
        textController!.text = initialValue;
      }
      return null;
    }, []);

    // Setup text listener
    useEffect(() {
      void listener() {
        final currentValue = ref
            .read(updateUserProvider(params.id))
            .valueOrNull
            ?.email;
        if (currentValue != controller.text) {
          ref
              .read(updateUserProvider(params.id).notifier)
              .updateEmail(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = UpdateUserEmailProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}

class UpdateUserAddressProxyWidgetRef extends UpdateUserProxyWidgetRef {
  UpdateUserAddressProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String? get address => select((state) => state.address);

  /// Update the field value directly.
  void updateAddress(String? newValue) => notifier.updateAddress(newValue);
}

class UpdateUserAddressField extends HookConsumerWidget {
  const UpdateUserAddressField({
    super.key,
    this.textController,
    this.onChanged,
    required this.builder,
  });

  /// Text controller for the field. If not provided, one will be created automatically.
  final TextEditingController? textController;

  /// Builder function that will be called with the context and ref.
  /// Field utilities are accessible via [ref]
  final Widget Function(
    BuildContext context,
    UpdateUserAddressProxyWidgetRef ref,
  )
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String? next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    final params = _UpdateUserFormInheritedWidget.of(context).params;

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref
        .read(updateUserProvider(params.id))
        .valueOrNull
        ?.address;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(
      updateUserProvider(
        params.id,
      ).select((value) => value.valueOrNull?.address),
      (previous, next) {
        if (previous != next && controller.text != next) {
          controller.text = next ?? "";
        }
        onChanged?.call(previous, next ?? "");
      },
    );

    // Initialize external controller if provided
    useEffect(() {
      if (textController != null &&
          initialValue != null &&
          textController!.text.isEmpty) {
        textController!.text = initialValue;
      }
      return null;
    }, []);

    // Setup text listener
    useEffect(() {
      void listener() {
        final currentValue = ref
            .read(updateUserProvider(params.id))
            .valueOrNull
            ?.address;
        if (currentValue != controller.text) {
          ref
              .read(updateUserProvider(params.id).notifier)
              .updateAddress(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = UpdateUserAddressProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}

class UpdateUserPhoneProxyWidgetRef extends UpdateUserProxyWidgetRef {
  UpdateUserPhoneProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String? get phone => select((state) => state.phone);

  /// Update the field value directly.
  void updatePhone(String? newValue) => notifier.updatePhone(newValue);
}

class UpdateUserPhoneField extends HookConsumerWidget {
  const UpdateUserPhoneField({
    super.key,
    this.textController,
    this.onChanged,
    required this.builder,
  });

  /// Text controller for the field. If not provided, one will be created automatically.
  final TextEditingController? textController;

  /// Builder function that will be called with the context and ref.
  /// Field utilities are accessible via [ref]
  final Widget Function(BuildContext context, UpdateUserPhoneProxyWidgetRef ref)
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String? next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasUpdateUserForm(context);

    final params = _UpdateUserFormInheritedWidget.of(context).params;

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref
        .read(updateUserProvider(params.id))
        .valueOrNull
        ?.phone;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(
      updateUserProvider(params.id).select((value) => value.valueOrNull?.phone),
      (previous, next) {
        if (previous != next && controller.text != next) {
          controller.text = next ?? "";
        }
        onChanged?.call(previous, next ?? "");
      },
    );

    // Initialize external controller if provided
    useEffect(() {
      if (textController != null &&
          initialValue != null &&
          textController!.text.isEmpty) {
        textController!.text = initialValue;
      }
      return null;
    }, []);

    // Setup text listener
    useEffect(() {
      void listener() {
        final currentValue = ref
            .read(updateUserProvider(params.id))
            .valueOrNull
            ?.phone;
        if (currentValue != controller.text) {
          ref
              .read(updateUserProvider(params.id).notifier)
              .updatePhone(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = UpdateUserPhoneProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}
