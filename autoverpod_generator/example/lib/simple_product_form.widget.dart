// **************************************************************************
// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// ignore_for_file: type=lint, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unnecessary_import, unused_import
// coverage:ignore-file

import 'package:example/simple_product_form.dart';
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
// Source: simpleProductFormProvider → SimpleProductState
//
// Widgets: SimpleProductFormScope, SimpleProductFormState, SimpleProductFormStatus, SimpleProductFormSelect
//
// Fields:
// - NameField (String): ref.textController | ref.updateName(value)
// - DescriptionField (String): ref.textController | ref.updateDescription(value)
// - PriceField (double): ref.updatePrice(value)
// - CategoryField (String): ref.textController | ref.updateCategory(value)
// - SkuField (String): ref.textController | ref.updateSku(value)
// - StockQuantityField (int): ref.updateStockQuantity(value)
// - IsActiveField (bool): ref.updateIsActive(value)
// - IsFeaturedField (bool): ref.updateIsFeatured(value)
// - TagsField (List<String>): ref.updateTags(value)
//

/// Extension that adds field update methods to the form provider.
/// These methods allow updating individual fields that have copyWith support.
extension SimpleProductFormFieldUpdater on SimpleProductForm {
  /// Update the name field of SimpleProductState class.
  void updateName(String newValue) => state = state.copyWith(name: newValue);

  /// Update the description field of SimpleProductState class.
  void updateDescription(String newValue) =>
      state = state.copyWith(description: newValue);

  /// Update the price field of SimpleProductState class.
  void updatePrice(double newValue) => state = state.copyWith(price: newValue);

  /// Update the category field of SimpleProductState class.
  void updateCategory(String newValue) =>
      state = state.copyWith(category: newValue);

  /// Update the sku field of SimpleProductState class.
  void updateSku(String newValue) => state = state.copyWith(sku: newValue);

  /// Update the stockQuantity field of SimpleProductState class.
  void updateStockQuantity(int newValue) =>
      state = state.copyWith(stockQuantity: newValue);

  /// Update the isActive field of SimpleProductState class.
  void updateIsActive(bool newValue) =>
      state = state.copyWith(isActive: newValue);

  /// Update the isFeatured field of SimpleProductState class.
  void updateIsFeatured(bool newValue) =>
      state = state.copyWith(isFeatured: newValue);

  /// Update the tags field of SimpleProductState class.
  void updateTags(List<String> newValue) =>
      state = state.copyWith(tags: newValue);
}

class _SimpleProductFormFormInheritedWidget extends InheritedWidget {
  const _SimpleProductFormFormInheritedWidget({
    required this.formKey,
    required super.child,
  });

  final GlobalKey<FormState> formKey;

  static _SimpleProductFormFormInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
          _SimpleProductFormFormInheritedWidget
        >()!;
  }

  @override
  bool updateShouldNotify(
    covariant _SimpleProductFormFormInheritedWidget oldWidget,
  ) {
    return formKey != oldWidget.formKey;
  }
}

class SimpleProductFormProxyWidgetRef extends MutationTarget {
  SimpleProductFormProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  MutationState<String>? get status =>
      _ref.watch(simpleProductFormCallStatusProvider);

  GlobalKey<FormState> get formKey =>
      _SimpleProductFormFormInheritedWidget.of(context).formKey;

  SimpleProductForm get notifier =>
      _ref.read(simpleProductFormProvider.notifier);

  Selected select<Selected>(Selected Function(SimpleProductState) selector) =>
      _ref.watch(simpleProductFormProvider.select((value) => selector(value)));

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

class SimpleProductFormFormScope extends ConsumerStatefulWidget {
  const SimpleProductFormFormScope({
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
    SimpleProductFormProxyWidgetRef ref,
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
      _SimpleProductFormFormScopeState();
}

class _SimpleProductFormFormScopeState
    extends ConsumerState<SimpleProductFormFormScope> {
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
    ref.listen(simpleProductFormCallStatusProvider, (previous, next) {
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

    return _SimpleProductFormFormInheritedWidget(
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
                SimpleProductFormProxyWidgetRef(ref),
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

bool _debugCheckHasSimpleProductFormForm(BuildContext context) {
  assert(() {
    if (context.widget is! SimpleProductFormFormScope &&
        context.findAncestorWidgetOfExactType<SimpleProductFormFormScope>() ==
            null) {
      // Check if we're in a navigation context (dialog or pushed screen)
      final isInNavigation = ModalRoute.of(context) != null;

      if (!isInNavigation) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No SimpleProductFormFormScope found'),
          ErrorDescription(
            '${context.widget.runtimeType} widgets require a SimpleProductFormFormScope widget ancestor '
            'or to be used in a navigation context with proper state management.',
          ),
        ]);
      }
      // If in navigation context, we'll return true but log a warning
      debugPrint(
        'Widget ${context.widget.runtimeType} used in navigation without direct SimpleProductFormFormScope',
      );
    }
    return true;
  }());
  return true;
}

class SimpleProductFormFormSelect<Selected> extends ConsumerWidget {
  const SimpleProductFormFormSelect({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(SimpleProductState state) selector;
  final Widget Function(
    BuildContext context,
    SimpleProductFormProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleProductFormForm(context);

    if (onStateChanged != null) {
      ref.listen(simpleProductFormProvider.select((value) => selector(value)), (
        pre,
        next,
      ) {
        if (pre != next) onStateChanged!(pre, next);
      });
    }
    final stateRef = SimpleProductFormProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.select(selector));
  }
}

class SimpleProductFormFormState extends ConsumerWidget {
  const SimpleProductFormFormState({
    super.key,
    required this.builder,
    this.child,
    this.onStateChanged,
  });

  /// The builder function that constructs the widget tree.
  /// Access the state directly via ref.state, which is equivalent to ref.watch(simpleProductFormProvider)
  ///
  /// For selecting specific fields, use ref.select() - e.g. ref.select((value) => value.someField)
  /// The ref parameter provides type-safe access to the provider state and notifier
  final Widget Function(
    BuildContext context,
    SimpleProductFormProxyWidgetRef ref,
    Widget? child,
  )
  builder;
  final Widget? child;
  final void Function(SimpleProductState? previous, SimpleProductState? next)?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleProductFormForm(context);

    if (onStateChanged != null) {
      ref.listen(simpleProductFormProvider, (pre, next) {
        if (pre != next) onStateChanged!(pre, next);
      });
    }
    return builder(context, SimpleProductFormProxyWidgetRef(ref), child);
  }
}

class SimpleProductFormFormStatus extends ConsumerWidget {
  const SimpleProductFormFormStatus({
    super.key,
    required this.builder,
    this.onChanged,
  });

  final Widget Function(
    BuildContext context,
    SimpleProductFormProxyWidgetRef ref,
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
    _debugCheckHasSimpleProductFormForm(context);

    if (onChanged != null) {
      ref.listen(simpleProductFormCallStatusProvider, (previous, next) {
        if (previous != next) {
          onChanged!(previous, next);
        }
      });
    }
    final stateRef = SimpleProductFormProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.status);
  }
}

class SimpleProductFormNameProxyWidgetRef
    extends SimpleProductFormProxyWidgetRef {
  SimpleProductFormNameProxyWidgetRef(
    super._ref, {
    required this.textController,
  });

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get name => select((state) => state.name);

  /// Update the field value directly.
  void updateName(String newValue) => notifier.updateName(newValue);
}

class SimpleProductFormNameField extends HookConsumerWidget {
  const SimpleProductFormNameField({
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
    SimpleProductFormNameProxyWidgetRef ref,
  )
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleProductFormForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(simpleProductFormProvider).name;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(simpleProductFormProvider.select((value) => value.name), (
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
        final currentValue = ref.read(simpleProductFormProvider).name;
        if (currentValue != controller.text) {
          ref
              .read(simpleProductFormProvider.notifier)
              .updateName(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = SimpleProductFormNameProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}

class SimpleProductFormDescriptionProxyWidgetRef
    extends SimpleProductFormProxyWidgetRef {
  SimpleProductFormDescriptionProxyWidgetRef(
    super._ref, {
    required this.textController,
  });

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get description => select((state) => state.description);

  /// Update the field value directly.
  void updateDescription(String newValue) =>
      notifier.updateDescription(newValue);
}

class SimpleProductFormDescriptionField extends HookConsumerWidget {
  const SimpleProductFormDescriptionField({
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
    SimpleProductFormDescriptionProxyWidgetRef ref,
  )
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleProductFormForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(simpleProductFormProvider).description;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(simpleProductFormProvider.select((value) => value.description), (
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
        final currentValue = ref.read(simpleProductFormProvider).description;
        if (currentValue != controller.text) {
          ref
              .read(simpleProductFormProvider.notifier)
              .updateDescription(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = SimpleProductFormDescriptionProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}

class SimpleProductFormPriceProxyWidgetRef
    extends SimpleProductFormProxyWidgetRef {
  SimpleProductFormPriceProxyWidgetRef(super._ref);

  /// Access the field value directly.
  double get price => select((state) => state.price);

  /// Update the field value directly.
  void updatePrice(double newValue) => notifier.updatePrice(newValue);
}

class SimpleProductFormPriceField extends ConsumerWidget {
  const SimpleProductFormPriceField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    SimpleProductFormPriceProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleProductFormForm(context);

    final proxy = SimpleProductFormPriceProxyWidgetRef(ref);
    return builder(context, proxy);
  }
}

class SimpleProductFormCategoryProxyWidgetRef
    extends SimpleProductFormProxyWidgetRef {
  SimpleProductFormCategoryProxyWidgetRef(
    super._ref, {
    required this.textController,
  });

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get category => select((state) => state.category);

  /// Update the field value directly.
  void updateCategory(String newValue) => notifier.updateCategory(newValue);
}

class SimpleProductFormCategoryField extends HookConsumerWidget {
  const SimpleProductFormCategoryField({
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
    SimpleProductFormCategoryProxyWidgetRef ref,
  )
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleProductFormForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(simpleProductFormProvider).category;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(simpleProductFormProvider.select((value) => value.category), (
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
        final currentValue = ref.read(simpleProductFormProvider).category;
        if (currentValue != controller.text) {
          ref
              .read(simpleProductFormProvider.notifier)
              .updateCategory(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = SimpleProductFormCategoryProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}

class SimpleProductFormSkuProxyWidgetRef
    extends SimpleProductFormProxyWidgetRef {
  SimpleProductFormSkuProxyWidgetRef(
    super._ref, {
    required this.textController,
  });

  /// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.
  final TextEditingController textController;

  /// Access the field value directly.
  String get sku => select((state) => state.sku);

  /// Update the field value directly.
  void updateSku(String newValue) => notifier.updateSku(newValue);
}

class SimpleProductFormSkuField extends HookConsumerWidget {
  const SimpleProductFormSkuField({
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
    SimpleProductFormSkuProxyWidgetRef ref,
  )
  builder;

  /// Optional callback that will be called when the field value changes
  final void Function(String? previous, String next)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleProductFormForm(context);

    // Using ref.read to get the initial value to avoid rebuilding the widget when the provider value changes
    final initialValue = ref.read(simpleProductFormProvider).sku;

    final controller =
        textController ?? useTextEditingController(text: initialValue);

    // Listen for provider changes
    ref.listen(simpleProductFormProvider.select((value) => value.sku), (
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
        final currentValue = ref.read(simpleProductFormProvider).sku;
        if (currentValue != controller.text) {
          ref
              .read(simpleProductFormProvider.notifier)
              .updateSku(controller.text);
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final proxy = SimpleProductFormSkuProxyWidgetRef(
      ref,
      textController: controller,
    );

    return builder(context, proxy);
  }
}

class SimpleProductFormStockQuantityProxyWidgetRef
    extends SimpleProductFormProxyWidgetRef {
  SimpleProductFormStockQuantityProxyWidgetRef(super._ref);

  /// Access the field value directly.
  int get stockQuantity => select((state) => state.stockQuantity);

  /// Update the field value directly.
  void updateStockQuantity(int newValue) =>
      notifier.updateStockQuantity(newValue);
}

class SimpleProductFormStockQuantityField extends ConsumerWidget {
  const SimpleProductFormStockQuantityField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    SimpleProductFormStockQuantityProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleProductFormForm(context);

    final proxy = SimpleProductFormStockQuantityProxyWidgetRef(ref);
    return builder(context, proxy);
  }
}

class SimpleProductFormIsActiveProxyWidgetRef
    extends SimpleProductFormProxyWidgetRef {
  SimpleProductFormIsActiveProxyWidgetRef(super._ref);

  /// Access the field value directly.
  bool get isActive => select((state) => state.isActive);

  /// Update the field value directly.
  void updateIsActive(bool newValue) => notifier.updateIsActive(newValue);
}

class SimpleProductFormIsActiveField extends ConsumerWidget {
  const SimpleProductFormIsActiveField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    SimpleProductFormIsActiveProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleProductFormForm(context);

    final proxy = SimpleProductFormIsActiveProxyWidgetRef(ref);
    return builder(context, proxy);
  }
}

class SimpleProductFormIsFeaturedProxyWidgetRef
    extends SimpleProductFormProxyWidgetRef {
  SimpleProductFormIsFeaturedProxyWidgetRef(super._ref);

  /// Access the field value directly.
  bool get isFeatured => select((state) => state.isFeatured);

  /// Update the field value directly.
  void updateIsFeatured(bool newValue) => notifier.updateIsFeatured(newValue);
}

class SimpleProductFormIsFeaturedField extends ConsumerWidget {
  const SimpleProductFormIsFeaturedField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    SimpleProductFormIsFeaturedProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleProductFormForm(context);

    final proxy = SimpleProductFormIsFeaturedProxyWidgetRef(ref);
    return builder(context, proxy);
  }
}

class SimpleProductFormTagsProxyWidgetRef
    extends SimpleProductFormProxyWidgetRef {
  SimpleProductFormTagsProxyWidgetRef(super._ref);

  /// Access the field value directly.
  List<String> get tags => select((state) => state.tags);

  /// Update the field value directly.
  void updateTags(List<String> newValue) => notifier.updateTags(newValue);
}

class SimpleProductFormTagsField extends ConsumerWidget {
  const SimpleProductFormTagsField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    SimpleProductFormTagsProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasSimpleProductFormForm(context);

    final proxy = SimpleProductFormTagsProxyWidgetRef(ref);
    return builder(context, proxy);
  }
}
