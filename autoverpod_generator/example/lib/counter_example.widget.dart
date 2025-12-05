// **************************************************************************
// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// ignore_for_file: type=lint, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unnecessary_import, unused_import
// coverage:ignore-file

import 'package:example/counter_example.dart';
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
// Source: counterFormProvider → CounterState
//
// Widgets: CounterFormScope, CounterFormState, CounterFormStatus, CounterFormSelect
//
// Fields:
// - CountField (int): ref.updateCount(value)
// - NameField (String): ref.textController | ref.updateName(value)
//

/// Extension that adds field update methods to the form provider.
/// These methods allow updating individual fields that have copyWith support.
extension CounterFormFieldUpdater on CounterForm {
  /// Update the count field of CounterState class.
  void updateCount(int newValue) => state = state.copyWith(count: newValue);

  /// Update the name field of CounterState class.
  void updateName(String newValue) => state = state.copyWith(name: newValue);
}

class _CounterFormFormInheritedWidget extends InheritedWidget {
  const _CounterFormFormInheritedWidget({
    required this.formKey,
    required super.child,
  });

  final GlobalKey<FormState> formKey;

  static _CounterFormFormInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_CounterFormFormInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(covariant _CounterFormFormInheritedWidget oldWidget) {
    return formKey != oldWidget.formKey;
  }
}

class CounterFormProxyWidgetRef extends MutationTarget {
  CounterFormProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  MutationState<String>? get status =>
      _ref.watch(counterFormCallStatusProvider);

  GlobalKey<FormState> get formKey =>
      _CounterFormFormInheritedWidget.of(context).formKey;

  CounterForm get notifier => _ref.read(counterFormProvider.notifier);

  Selected select<Selected>(Selected Function(CounterState) selector) =>
      _ref.watch(counterFormProvider.select((value) => selector(value)));

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

class CounterFormFormScope extends ConsumerStatefulWidget {
  const CounterFormFormScope({
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
    CounterFormProxyWidgetRef ref,
    Widget? child,
  )?
  builder;
  final Widget? child;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;
  final void Function(bool, Object?)? onPopInvokedWithResult;
  final void Function(BuildContext context, String value)? onSucceed;
  final void Function(
    MutationState<String>? previous,
    MutationState<String>? next,
  )?
  onStatusChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CounterFormFormScopeState();
}

class _CounterFormFormScopeState extends ConsumerState<CounterFormFormScope> {
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
    ref.listen(counterFormCallStatusProvider, (previous, next) {
      if (widget.onStatusChanged != null) {
        if (previous != next) {
          widget.onStatusChanged!(previous, next);
        }
      }
      if (widget.onSucceed != null) {
        if ((previous?.isSuccess ?? false) == false &&
            (next.isSuccess) == true) {
          widget.onSucceed!(context, (next as MutationSuccess<String>).value);
        }
      }
    });

    return _CounterFormFormInheritedWidget(
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
                CounterFormProxyWidgetRef(ref),
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

bool _debugCheckHasCounterFormForm(BuildContext context) {
  assert(() {
    if (context.widget is! CounterFormFormScope &&
        context.findAncestorWidgetOfExactType<CounterFormFormScope>() == null) {
      // Check if we're in a navigation context (dialog or pushed screen)
      final isInNavigation = ModalRoute.of(context) != null;

      if (!isInNavigation) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No CounterFormFormScope found'),
          ErrorDescription(
            '${context.widget.runtimeType} widgets require a CounterFormFormScope widget ancestor '
            'or to be used in a navigation context with proper state management.',
          ),
        ]);
      }
      // If in navigation context, we'll return true but log a warning
      debugPrint(
        'Widget ${context.widget.runtimeType} used in navigation without direct CounterFormFormScope',
      );
    }
    return true;
  }());
  return true;
}

class CounterFormFormSelect<Selected> extends ConsumerWidget {
  const CounterFormFormSelect({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(CounterState state) selector;
  final Widget Function(
    BuildContext context,
    CounterFormProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasCounterFormForm(context);

    if (onStateChanged != null) {
      ref.listen(counterFormProvider.select((value) => selector(value)), (
        pre,
        next,
      ) {
        if (pre != next) onStateChanged!(pre, next);
      });
    }
    final stateRef = CounterFormProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.select(selector));
  }
}

class CounterFormFormState extends ConsumerWidget {
  const CounterFormFormState({
    super.key,
    required this.builder,
    this.child,
    this.onStateChanged,
  });

  /// The builder function that constructs the widget tree.
  /// Access the state directly via ref.state, which is equivalent to ref.watch(counterFormProvider)
  ///
  /// For selecting specific fields, use ref.select() - e.g. ref.select((value) => value.someField)
  /// The ref parameter provides type-safe access to the provider state and notifier
  final Widget Function(
    BuildContext context,
    CounterFormProxyWidgetRef ref,
    Widget? child,
  )
  builder;
  final Widget? child;
  final void Function(CounterState? previous, CounterState? next)?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasCounterFormForm(context);

    if (onStateChanged != null) {
      ref.listen(counterFormProvider, (pre, next) {
        if (pre != next) onStateChanged!(pre, next);
      });
    }
    return builder(context, CounterFormProxyWidgetRef(ref), child);
  }
}

class CounterFormFormStatus extends ConsumerWidget {
  const CounterFormFormStatus({
    super.key,
    required this.builder,
    this.onChanged,
  });

  final Widget Function(
    BuildContext context,
    CounterFormProxyWidgetRef ref,
    MutationState<String>? status,
  )
  builder;
  final void Function(
    MutationState<String>? previous,
    MutationState<String>? next,
  )?
  onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasCounterFormForm(context);

    if (onChanged != null) {
      ref.listen(counterFormCallStatusProvider, (previous, next) {
        if (previous != next) {
          onChanged!(previous, next);
        }
      });
    }
    final stateRef = CounterFormProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.status);
  }
}

class CounterFormCountProxyWidgetRef extends CounterFormProxyWidgetRef {
  CounterFormCountProxyWidgetRef(super._ref);

  /// Access the field value directly.
  int get count => select((state) => state.count);

  /// Update the field value directly.
  void updateCount(int newValue) => notifier.updateCount(newValue);
}

class CounterFormCountField extends ConsumerWidget {
  const CounterFormCountField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    CounterFormCountProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasCounterFormForm(context);

    final proxy = CounterFormCountProxyWidgetRef(ref);
    return builder(context, proxy);
  }
}

class CounterFormNameProxyWidgetRef extends CounterFormProxyWidgetRef {
  CounterFormNameProxyWidgetRef(super._ref, {required this.textController});

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get name => select((state) => state.name);

  /// Update the field value directly.
  void updateName(String newValue) => notifier.updateName(newValue);
}

class CounterFormNameField extends HookConsumerWidget {
  const CounterFormNameField({
    super.key,
    this.textController,
    this.onChanged,
    required this.builder,
  });

  /// Text controller for the field. If not provided, one will be created automatically.
  final TextEditingController? textController;

  /// Builder function that will be called with the context and ref.
  /// Field utilities are accessible via [ref]
  final Widget Function(BuildContext context, CounterFormNameProxyWidgetRef ref)
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasCounterFormForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(counterFormProvider).name;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(counterFormProvider.select((value) => value.name), (
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
        final currentValue = ref.read(counterFormProvider).name;
        if (currentValue != controller.text) {
          ref.read(counterFormProvider.notifier).updateName(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = CounterFormNameProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}
