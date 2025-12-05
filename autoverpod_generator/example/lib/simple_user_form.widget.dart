// **************************************************************************
// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// ignore_for_file: type=lint, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unnecessary_import, unused_import
// coverage:ignore-file

import 'package:example/simple_user_form.dart';
import 'package:autoverpod/autoverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/experimental/mutation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';

// ============================================================================
// AUTOVERPOD GENERATED FORM WIDGET - DO NOT MODIFY BY HAND
// ============================================================================
//
// Source: simpleUserFormProvider → SimpleUserState
//
// Widgets: SimpleUserFormScope, SimpleUserFormState, SimpleUserFormStatus, SimpleUserFormSelect
//
// Fields:
// - FirstNameField (String): ref.textController | ref.updateFirstName(value)
// - LastNameField (String): ref.textController | ref.updateLastName(value)
// - EmailField (String): ref.textController | ref.updateEmail(value)
// - PhoneField (String): ref.textController | ref.updatePhone(value)
// - CompanyField (String): ref.textController | ref.updateCompany(value)
// - JobTitleField (String): ref.textController | ref.updateJobTitle(value)
// - IsActiveField (bool): ref.updateIsActive(value)
// - AcceptsMarketingField (bool): ref.updateAcceptsMarketing(value)
//

/// Extension that adds field update methods to the form provider.
/// These methods allow updating individual fields that have copyWith support.
extension SimpleUserFormFieldUpdater on SimpleUserForm {
  /// Update the firstName field of SimpleUserState class.
  void updateFirstName(String newValue) =>
      state = state.copyWith(firstName: newValue);

  /// Update the lastName field of SimpleUserState class.
  void updateLastName(String newValue) =>
      state = state.copyWith(lastName: newValue);

  /// Update the email field of SimpleUserState class.
  void updateEmail(String newValue) => state = state.copyWith(email: newValue);

  /// Update the phone field of SimpleUserState class.
  void updatePhone(String newValue) => state = state.copyWith(phone: newValue);

  /// Update the company field of SimpleUserState class.
  void updateCompany(String newValue) =>
      state = state.copyWith(company: newValue);

  /// Update the jobTitle field of SimpleUserState class.
  void updateJobTitle(String newValue) =>
      state = state.copyWith(jobTitle: newValue);

  /// Update the isActive field of SimpleUserState class.
  void updateIsActive(bool newValue) =>
      state = state.copyWith(isActive: newValue);

  /// Update the acceptsMarketing field of SimpleUserState class.
  void updateAcceptsMarketing(bool newValue) =>
      state = state.copyWith(acceptsMarketing: newValue);
}

class _SimpleUserFormFormInheritedWidget extends InheritedWidget {
  const _SimpleUserFormFormInheritedWidget({
    required this.formKey,
    required super.child,
  });

  final GlobalKey<FormState> formKey;

  static _SimpleUserFormFormInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
          _SimpleUserFormFormInheritedWidget
        >()!;
  }

  @override
  bool updateShouldNotify(
    covariant _SimpleUserFormFormInheritedWidget oldWidget,
  ) {
    return formKey != oldWidget.formKey;
  }
}

class SimpleUserFormProxyWidgetRef extends MutationTarget {
  SimpleUserFormProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  MutationState<int>? get status =>
      _ref.watch(simpleUserFormCallStatusProvider);

  GlobalKey<FormState> get formKey =>
      _SimpleUserFormFormInheritedWidget.of(context).formKey;

  SimpleUserForm get notifier => _ref.read(simpleUserFormProvider.notifier);

  Selected select<Selected>(Selected Function(SimpleUserState) selector) =>
      _ref.watch(simpleUserFormProvider.select((value) => selector(value)));

  BuildContext get context => _ref.context;

  bool exists(ProviderBase<Object?> provider) => _ref.exists(provider);

  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);

  void listen<T>(
    ProviderListenable<T> provider,
    void Function(T?, T) listener, {
    void Function(Object, StackTrace)? onError,
  }) => _ref.listen(provider, listener, onError: onError);

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

  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);

  State refresh<State>(Refreshable<State> provider) => _ref.refresh(provider);

  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);

  ProviderContainer get container => _ref.container;
}

class SimpleUserFormFormScope extends ConsumerStatefulWidget {
  const SimpleUserFormFormScope({
    super.key,
    this.formKey,
    this.autovalidateMode,
    this.onPopInvokedWithResult,
    required this.builder,
    this.child,
    this.onSucceed,
    this.onStatusChanged,
  }) : assert(
         child != null || builder != null,
         'Either child or builder must be provided',
       );

  final Widget Function(
    BuildContext context,
    SimpleUserFormProxyWidgetRef ref,
    Widget? child,
  )?
  builder;
  final Widget? child;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;
  final void Function(bool, Object?)? onPopInvokedWithResult;
  final void Function(BuildContext context, int value)? onSucceed;
  final void Function(MutationState<int>? previous, MutationState<int>? next)?
  onStatusChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SimpleUserFormFormScopeState();
}

class _SimpleUserFormFormScopeState
    extends ConsumerState<SimpleUserFormFormScope> {
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
    ref.listen(simpleUserFormCallStatusProvider, (previous, next) {
      if (widget.onStatusChanged != null) {
        if (previous != next) {
          widget.onStatusChanged!(previous, next);
        }
      }
      if (widget.onSucceed != null) {
        if ((previous?.isSuccess ?? false) == false &&
            (next.isSuccess) == true) {
          widget.onSucceed!(context, (next as MutationSuccess<int>).value);
        }
      }
    });

    return _SimpleUserFormFormInheritedWidget(
      formKey: _cachedFormKey,
      child: Form(
        key: _cachedFormKey,
        autovalidateMode: widget.autovalidateMode,
        onPopInvokedWithResult: widget.onPopInvokedWithResult,
        child: Consumer(
          builder: (context, ref, child) {
            if (widget.builder != null) {
              return widget.builder!(
                context,
                SimpleUserFormProxyWidgetRef(ref),
                widget.child,
              );
            }

            return widget.child!;
          },
        ),
      ),
    );
  }
}

bool _debugCheckHasSimpleUserFormForm(BuildContext context) {
  assert(() {
    if (context.widget is! SimpleUserFormFormScope &&
        context.findAncestorWidgetOfExactType<SimpleUserFormFormScope>() ==
            null) {
      // Check if we're in a navigation context (dialog or pushed screen)
      final isInNavigation = ModalRoute.of(context) != null;

      if (!isInNavigation) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No SimpleUserFormFormScope found'),
          ErrorDescription(
            '${context.widget.runtimeType} widgets require a SimpleUserFormFormScope widget ancestor '
            'or to be used in a navigation context with proper state management.',
          ),
        ]);
      }
      // If in navigation context, we'll return true but log a warning
      debugPrint(
        'Widget ${context.widget.runtimeType} used in navigation without direct SimpleUserFormFormScope',
      );
    }
    return true;
  }());
  return true;
}

class SimpleUserFormFormSelect<Selected> extends ConsumerWidget {
  const SimpleUserFormFormSelect({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(SimpleUserState state) selector;
  final Widget Function(
    BuildContext context,
    SimpleUserFormProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleUserFormForm(context);

    if (onStateChanged != null) {
      ref.listen(simpleUserFormProvider.select((value) => selector(value)), (
        pre,
        next,
      ) {
        if (pre != next) onStateChanged!(pre, next);
      });
    }
    final stateRef = SimpleUserFormProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.select(selector));
  }
}

class SimpleUserFormFormState extends ConsumerWidget {
  const SimpleUserFormFormState({
    super.key,
    required this.builder,
    this.child,
    this.onStateChanged,
  });

  /// The builder function that constructs the widget tree.
  /// Access the state directly via ref.state, which is equivalent to ref.watch(simpleUserFormProvider)
  ///
  /// For selecting specific fields, use ref.select() - e.g. ref.select((value) => value.someField)
  /// The ref parameter provides type-safe access to the provider state and notifier
  final Widget Function(
    BuildContext context,
    SimpleUserFormProxyWidgetRef ref,
    Widget? child,
  )
  builder;
  final Widget? child;
  final void Function(SimpleUserState? previous, SimpleUserState? next)?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleUserFormForm(context);

    if (onStateChanged != null) {
      ref.listen(simpleUserFormProvider, (pre, next) {
        if (pre != next) onStateChanged!(pre, next);
      });
    }
    return builder(context, SimpleUserFormProxyWidgetRef(ref), child);
  }
}

class SimpleUserFormFormStatus extends ConsumerWidget {
  const SimpleUserFormFormStatus({
    super.key,
    required this.builder,
    this.onChanged,
  });

  final Widget Function(
    BuildContext context,
    SimpleUserFormProxyWidgetRef ref,
    MutationState<int>? status,
  )
  builder;
  final void Function(MutationState<int>? previous, MutationState<int>? next)?
  onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleUserFormForm(context);

    if (onChanged != null) {
      ref.listen(simpleUserFormCallStatusProvider, (previous, next) {
        if (previous != next) {
          onChanged!(previous, next);
        }
      });
    }
    final stateRef = SimpleUserFormProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.status);
  }
}

class SimpleUserFormFirstNameProxyWidgetRef
    extends SimpleUserFormProxyWidgetRef {
  SimpleUserFormFirstNameProxyWidgetRef(
    super._ref, {
    required this.textController,
  });

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get firstName => select((state) => state.firstName);

  /// Update the field value directly.
  void updateFirstName(String newValue) => notifier.updateFirstName(newValue);
}

class SimpleUserFormFirstNameField extends HookConsumerWidget {
  const SimpleUserFormFirstNameField({
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
    SimpleUserFormFirstNameProxyWidgetRef ref,
  )
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleUserFormForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(simpleUserFormProvider).firstName;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(simpleUserFormProvider.select((value) => value.firstName), (
      previous,
      next,
    ) {
      if (previous != next && controller.text != next) {
        controller.text = next;
      }
      onChanged?.call(previous, next);
    });

    // Initialize external controller if provided
    useEffect(() {
      if (textController != null && textController!.text.isEmpty) {
        textController!.text = initialValue;
      }
      return null;
    }, []);

    // Setup text listener
    useEffect(() {
      void listener() {
        final currentValue = ref.read(simpleUserFormProvider).firstName;
        if (currentValue != controller.text) {
          ref
              .read(simpleUserFormProvider.notifier)
              .updateFirstName(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = SimpleUserFormFirstNameProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}

class SimpleUserFormLastNameProxyWidgetRef
    extends SimpleUserFormProxyWidgetRef {
  SimpleUserFormLastNameProxyWidgetRef(
    super._ref, {
    required this.textController,
  });

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get lastName => select((state) => state.lastName);

  /// Update the field value directly.
  void updateLastName(String newValue) => notifier.updateLastName(newValue);
}

class SimpleUserFormLastNameField extends HookConsumerWidget {
  const SimpleUserFormLastNameField({
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
    SimpleUserFormLastNameProxyWidgetRef ref,
  )
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleUserFormForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(simpleUserFormProvider).lastName;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(simpleUserFormProvider.select((value) => value.lastName), (
      previous,
      next,
    ) {
      if (previous != next && controller.text != next) {
        controller.text = next;
      }
      onChanged?.call(previous, next);
    });

    // Initialize external controller if provided
    useEffect(() {
      if (textController != null && textController!.text.isEmpty) {
        textController!.text = initialValue;
      }
      return null;
    }, []);

    // Setup text listener
    useEffect(() {
      void listener() {
        final currentValue = ref.read(simpleUserFormProvider).lastName;
        if (currentValue != controller.text) {
          ref
              .read(simpleUserFormProvider.notifier)
              .updateLastName(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = SimpleUserFormLastNameProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}

class SimpleUserFormEmailProxyWidgetRef extends SimpleUserFormProxyWidgetRef {
  SimpleUserFormEmailProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get email => select((state) => state.email);

  /// Update the field value directly.
  void updateEmail(String newValue) => notifier.updateEmail(newValue);
}

class SimpleUserFormEmailField extends HookConsumerWidget {
  const SimpleUserFormEmailField({
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
    SimpleUserFormEmailProxyWidgetRef ref,
  )
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleUserFormForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(simpleUserFormProvider).email;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(simpleUserFormProvider.select((value) => value.email), (
      previous,
      next,
    ) {
      if (previous != next && controller.text != next) {
        controller.text = next;
      }
      onChanged?.call(previous, next);
    });

    // Initialize external controller if provided
    useEffect(() {
      if (textController != null && textController!.text.isEmpty) {
        textController!.text = initialValue;
      }
      return null;
    }, []);

    // Setup text listener
    useEffect(() {
      void listener() {
        final currentValue = ref.read(simpleUserFormProvider).email;
        if (currentValue != controller.text) {
          ref
              .read(simpleUserFormProvider.notifier)
              .updateEmail(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = SimpleUserFormEmailProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}

class SimpleUserFormPhoneProxyWidgetRef extends SimpleUserFormProxyWidgetRef {
  SimpleUserFormPhoneProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get phone => select((state) => state.phone);

  /// Update the field value directly.
  void updatePhone(String newValue) => notifier.updatePhone(newValue);
}

class SimpleUserFormPhoneField extends HookConsumerWidget {
  const SimpleUserFormPhoneField({
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
    SimpleUserFormPhoneProxyWidgetRef ref,
  )
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleUserFormForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(simpleUserFormProvider).phone;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(simpleUserFormProvider.select((value) => value.phone), (
      previous,
      next,
    ) {
      if (previous != next && controller.text != next) {
        controller.text = next;
      }
      onChanged?.call(previous, next);
    });

    // Initialize external controller if provided
    useEffect(() {
      if (textController != null && textController!.text.isEmpty) {
        textController!.text = initialValue;
      }
      return null;
    }, []);

    // Setup text listener
    useEffect(() {
      void listener() {
        final currentValue = ref.read(simpleUserFormProvider).phone;
        if (currentValue != controller.text) {
          ref
              .read(simpleUserFormProvider.notifier)
              .updatePhone(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = SimpleUserFormPhoneProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}

class SimpleUserFormCompanyProxyWidgetRef extends SimpleUserFormProxyWidgetRef {
  SimpleUserFormCompanyProxyWidgetRef(
    super._ref, {
    required this.textController,
  });

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get company => select((state) => state.company);

  /// Update the field value directly.
  void updateCompany(String newValue) => notifier.updateCompany(newValue);
}

class SimpleUserFormCompanyField extends HookConsumerWidget {
  const SimpleUserFormCompanyField({
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
    SimpleUserFormCompanyProxyWidgetRef ref,
  )
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleUserFormForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(simpleUserFormProvider).company;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(simpleUserFormProvider.select((value) => value.company), (
      previous,
      next,
    ) {
      if (previous != next && controller.text != next) {
        controller.text = next;
      }
      onChanged?.call(previous, next);
    });

    // Initialize external controller if provided
    useEffect(() {
      if (textController != null && textController!.text.isEmpty) {
        textController!.text = initialValue;
      }
      return null;
    }, []);

    // Setup text listener
    useEffect(() {
      void listener() {
        final currentValue = ref.read(simpleUserFormProvider).company;
        if (currentValue != controller.text) {
          ref
              .read(simpleUserFormProvider.notifier)
              .updateCompany(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = SimpleUserFormCompanyProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}

class SimpleUserFormJobTitleProxyWidgetRef
    extends SimpleUserFormProxyWidgetRef {
  SimpleUserFormJobTitleProxyWidgetRef(
    super._ref, {
    required this.textController,
  });

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get jobTitle => select((state) => state.jobTitle);

  /// Update the field value directly.
  void updateJobTitle(String newValue) => notifier.updateJobTitle(newValue);
}

class SimpleUserFormJobTitleField extends HookConsumerWidget {
  const SimpleUserFormJobTitleField({
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
    SimpleUserFormJobTitleProxyWidgetRef ref,
  )
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleUserFormForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(simpleUserFormProvider).jobTitle;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(simpleUserFormProvider.select((value) => value.jobTitle), (
      previous,
      next,
    ) {
      if (previous != next && controller.text != next) {
        controller.text = next;
      }
      onChanged?.call(previous, next);
    });

    // Initialize external controller if provided
    useEffect(() {
      if (textController != null && textController!.text.isEmpty) {
        textController!.text = initialValue;
      }
      return null;
    }, []);

    // Setup text listener
    useEffect(() {
      void listener() {
        final currentValue = ref.read(simpleUserFormProvider).jobTitle;
        if (currentValue != controller.text) {
          ref
              .read(simpleUserFormProvider.notifier)
              .updateJobTitle(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = SimpleUserFormJobTitleProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}

class SimpleUserFormIsActiveProxyWidgetRef
    extends SimpleUserFormProxyWidgetRef {
  SimpleUserFormIsActiveProxyWidgetRef(super._ref);

  /// Access the field value directly.
  bool get isActive => select((state) => state.isActive);

  /// Update the field value directly.
  void updateIsActive(bool newValue) => notifier.updateIsActive(newValue);
}

class SimpleUserFormIsActiveField extends ConsumerWidget {
  const SimpleUserFormIsActiveField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    SimpleUserFormIsActiveProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleUserFormForm(context);

    final proxy = SimpleUserFormIsActiveProxyWidgetRef(ref);
    return builder(context, proxy);
  }
}

class SimpleUserFormAcceptsMarketingProxyWidgetRef
    extends SimpleUserFormProxyWidgetRef {
  SimpleUserFormAcceptsMarketingProxyWidgetRef(super._ref);

  /// Access the field value directly.
  bool get acceptsMarketing => select((state) => state.acceptsMarketing);

  /// Update the field value directly.
  void updateAcceptsMarketing(bool newValue) =>
      notifier.updateAcceptsMarketing(newValue);
}

class SimpleUserFormAcceptsMarketingField extends ConsumerWidget {
  const SimpleUserFormAcceptsMarketingField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    SimpleUserFormAcceptsMarketingProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleUserFormForm(context);

    final proxy = SimpleUserFormAcceptsMarketingProxyWidgetRef(ref);
    return builder(context, proxy);
  }
}
