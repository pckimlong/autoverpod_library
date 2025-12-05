// **************************************************************************
// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// ignore_for_file: type=lint, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unnecessary_import, unused_import
// coverage:ignore-file

import 'package:example/main.dart';
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
// Source: shopCreateProvider → ShopCreateState
//
// Widgets: ShopCreateScope, ShopCreateState, ShopCreateStatus, ShopCreateSelect
//
// Fields:
// - NameField (String): ref.textController | ref.updateName(value)
// - PhoneField (String): ref.textController | ref.updatePhone(value)
//

/// Extension that adds field update methods to the form provider.
/// These methods allow updating individual fields that have copyWith support.
extension ShopCreateFieldUpdater on ShopCreate {
  /// Update the name field of ShopCreateState class.
  void updateName(String newValue) => state = state.copyWith(name: newValue);

  /// Update the phone field of ShopCreateState class.
  void updatePhone(String newValue) => state = state.copyWith(phone: newValue);
}

class _ShopCreateFormInheritedWidget extends InheritedWidget {
  const _ShopCreateFormInheritedWidget({
    required this.formKey,
    required super.child,
  });

  final GlobalKey<FormState> formKey;

  static _ShopCreateFormInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ShopCreateFormInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShopCreateFormInheritedWidget oldWidget) {
    return formKey != oldWidget.formKey;
  }
}

class ShopCreateProxyWidgetRef extends MutationTarget {
  ShopCreateProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  MutationState<int>? get status => _ref.watch(shopCreateCallStatusProvider);

  GlobalKey<FormState> get formKey =>
      _ShopCreateFormInheritedWidget.of(context).formKey;

  ShopCreate get notifier => _ref.read(shopCreateProvider.notifier);

  Selected select<Selected>(Selected Function(ShopCreateState) selector) =>
      _ref.watch(shopCreateProvider.select((value) => selector(value)));

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

class ShopCreateFormScope extends ConsumerStatefulWidget {
  const ShopCreateFormScope({
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
    ShopCreateProxyWidgetRef ref,
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
      _ShopCreateFormScopeState();
}

class _ShopCreateFormScopeState extends ConsumerState<ShopCreateFormScope> {
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
    ref.listen(shopCreateCallStatusProvider, (previous, next) {
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

    return _ShopCreateFormInheritedWidget(
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
                ShopCreateProxyWidgetRef(ref),
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

bool _debugCheckHasShopCreateForm(BuildContext context) {
  assert(() {
    if (context.widget is! ShopCreateFormScope &&
        context.findAncestorWidgetOfExactType<ShopCreateFormScope>() == null) {
      // Check if we're in a navigation context (dialog or pushed screen)
      final isInNavigation = ModalRoute.of(context) != null;

      if (!isInNavigation) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No ShopCreateFormScope found'),
          ErrorDescription(
            '${context.widget.runtimeType} widgets require a ShopCreateFormScope widget ancestor '
            'or to be used in a navigation context with proper state management.',
          ),
        ]);
      }
      // If in navigation context, we'll return true but log a warning
      debugPrint(
        'Widget ${context.widget.runtimeType} used in navigation without direct ShopCreateFormScope',
      );
    }
    return true;
  }());
  return true;
}

class ShopCreateFormSelect<Selected> extends ConsumerWidget {
  const ShopCreateFormSelect({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(ShopCreateState state) selector;
  final Widget Function(
    BuildContext context,
    ShopCreateProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasShopCreateForm(context);

    if (onStateChanged != null) {
      ref.listen(shopCreateProvider.select((value) => selector(value)), (
        pre,
        next,
      ) {
        if (pre != next) onStateChanged!(pre, next);
      });
    }
    final stateRef = ShopCreateProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.select(selector));
  }
}

class ShopCreateFormState extends ConsumerWidget {
  const ShopCreateFormState({
    super.key,
    required this.builder,
    this.child,
    this.onStateChanged,
  });

  /// The builder function that constructs the widget tree.
  /// Access the state directly via ref.state, which is equivalent to ref.watch(shopCreateProvider)
  ///
  /// For selecting specific fields, use ref.select() - e.g. ref.select((value) => value.someField)
  /// The ref parameter provides type-safe access to the provider state and notifier
  final Widget Function(
    BuildContext context,
    ShopCreateProxyWidgetRef ref,
    Widget? child,
  )
  builder;
  final Widget? child;
  final void Function(ShopCreateState? previous, ShopCreateState? next)?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasShopCreateForm(context);

    if (onStateChanged != null) {
      ref.listen(shopCreateProvider, (pre, next) {
        if (pre != next) onStateChanged!(pre, next);
      });
    }
    return builder(context, ShopCreateProxyWidgetRef(ref), child);
  }
}

class ShopCreateFormStatus extends ConsumerWidget {
  const ShopCreateFormStatus({
    super.key,
    required this.builder,
    this.onChanged,
  });

  final Widget Function(
    BuildContext context,
    ShopCreateProxyWidgetRef ref,
    MutationState<int>? status,
  )
  builder;
  final void Function(MutationState<int>? previous, MutationState<int>? next)?
  onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasShopCreateForm(context);

    if (onChanged != null) {
      ref.listen(shopCreateCallStatusProvider, (previous, next) {
        if (previous != next) {
          onChanged!(previous, next);
        }
      });
    }
    final stateRef = ShopCreateProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.status);
  }
}

class ShopCreateNameProxyWidgetRef extends ShopCreateProxyWidgetRef {
  ShopCreateNameProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get name => select((state) => state.name);

  /// Update the field value directly.
  void updateName(String newValue) => notifier.updateName(newValue);
}

class ShopCreateNameField extends HookConsumerWidget {
  const ShopCreateNameField({
    super.key,
    this.textController,
    this.onChanged,
    required this.builder,
  });

  /// Text controller for the field. If not provided, one will be created automatically.
  final TextEditingController? textController;

  /// Builder function that will be called with the context and ref.
  /// Field utilities are accessible via [ref]
  final Widget Function(BuildContext context, ShopCreateNameProxyWidgetRef ref)
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasShopCreateForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(shopCreateProvider).name;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(shopCreateProvider.select((value) => value.name), (
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
        final currentValue = ref.read(shopCreateProvider).name;
        if (currentValue != controller.text) {
          ref.read(shopCreateProvider.notifier).updateName(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = ShopCreateNameProxyWidgetRef(ref, textController: controller);

    return builder(context, proxy);
  }
}

class ShopCreatePhoneProxyWidgetRef extends ShopCreateProxyWidgetRef {
  ShopCreatePhoneProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get phone => select((state) => state.phone);

  /// Update the field value directly.
  void updatePhone(String newValue) => notifier.updatePhone(newValue);
}

class ShopCreatePhoneField extends HookConsumerWidget {
  const ShopCreatePhoneField({
    super.key,
    this.textController,
    this.onChanged,
    required this.builder,
  });

  /// Text controller for the field. If not provided, one will be created automatically.
  final TextEditingController? textController;

  /// Builder function that will be called with the context and ref.
  /// Field utilities are accessible via [ref]
  final Widget Function(BuildContext context, ShopCreatePhoneProxyWidgetRef ref)
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasShopCreateForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(shopCreateProvider).phone;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(shopCreateProvider.select((value) => value.phone), (
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
        final currentValue = ref.read(shopCreateProvider).phone;
        if (currentValue != controller.text) {
          ref.read(shopCreateProvider.notifier).updatePhone(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = ShopCreatePhoneProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}
