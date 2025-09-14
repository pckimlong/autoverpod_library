// **************************************************************************
// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// ignore_for_file: type=lint, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unnecessary_import, unused_import
// coverage:ignore-file

import 'package:autoverpod_generator_example/state_widget_example.dart';
import 'package:autoverpod/autoverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp_utils/kimapp_utils.dart';

// ============================================================================
// AUTOVERPOD GENERATED STATE WIDGET - DO NOT MODIFY BY HAND
// ============================================================================
//
// Source: myNameAsyncProvider
//
// PUBLIC WIDGETS:
// - MyNameAsyncScope: Main scope widget for provider access
// - MyNameAsyncWidget: Consumer widget with automatic state access
// - MyNameAsyncSelect: Selector widget for optimized rebuilds
//

class _MyNameAsyncProxyWidgetRef extends WidgetRef {
  _MyNameAsyncProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  MyNameAsync get notifier => _ref.read(myNameAsyncProvider.notifier);

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

class MyNameAsyncProviderScope extends ConsumerWidget {
  const MyNameAsyncProviderScope({
    super.key,
    this.loading,
    this.error,
    this.data,
    this.skipLoadingOnReload = true,
    this.skipLoadingOnRefresh = true,
    this.builder,
    this.child,
    this.onStateChanged,
  });

  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget Function(String data)? data;
  final bool skipLoadingOnReload;
  final bool skipLoadingOnRefresh;
  final Widget Function(
    BuildContext context,
    _MyNameAsyncProxyWidgetRef ref,
    AsyncValue<String> asyncValue,
    Widget? child,
  )?
  builder;
  final Widget? child;
  final void Function(AsyncValue<String>? previous, AsyncValue<String> next)?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (onStateChanged != null) {
      ref.listen(myNameAsyncProvider, onStateChanged!);
    }

    return Consumer(
      child: child,
      builder: (context, ref, child) {
        final state = ref.watch(myNameAsyncProvider);

        if (builder != null) {
          return builder!(
            context,
            _MyNameAsyncProxyWidgetRef(ref),
            state,
            child,
          );
        }

        final themeExtension = Theme.of(
          context,
        ).extension<KimappThemeExtension>();
        return state.when(
          skipLoadingOnReload: skipLoadingOnReload,
          skipLoadingOnRefresh: skipLoadingOnRefresh,
          data: (data) {
            final result = this.data?.call(data) ?? child;
            if (result == null) {
              debugPrint(
                'No child provided for MyNameAsyncProviderScope. Empty SizedBox will be returned.',
              );
              return const SizedBox.shrink();
            }
            return result;
          },
          error: (error, stack) =>
              this.error?.call(error, stack) ??
              themeExtension?.defaultErrorStateWidget?.call(
                context,
                ref,
                error,
              ) ??
              const SizedBox.shrink(),
          loading: () =>
              loading?.call() ??
              themeExtension?.defaultLoadingStateWidget?.call(context, ref) ??
              const SizedBox.shrink(),
        );
      },
    );
  }
}

bool _debugCheckHasMyNameAsyncProviderScope(BuildContext context) {
  assert(() {
    if (context.widget is! MyNameAsyncProviderScope &&
        context.findAncestorWidgetOfExactType<MyNameAsyncProviderScope>() ==
            null) {
      // Check if we're in a navigation context (dialog or pushed screen)
      final isInNavigation = ModalRoute.of(context) != null;

      if (!isInNavigation) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No MyNameAsyncProviderScope found'),
          ErrorDescription(
            '${context.widget.runtimeType} widgets require a MyNameAsyncProviderScope widget ancestor '
            'or to be used in a navigation context with proper state management.',
          ),
        ]);
      }
      // If in navigation context, we'll return true but log a warning
      debugPrint(
        'Widget ${context.widget.runtimeType} used in navigation without direct MyNameAsyncProviderScope',
      );
    }
    return true;
  }());
  return true;
}

class _MyNameAsyncStateProxyWidgetRef extends _MyNameAsyncProxyWidgetRef {
  _MyNameAsyncStateProxyWidgetRef(super._ref);

  Selected select<Selected>(Selected Function(String) selector) => _ref.watch(
    myNameAsyncProvider.select((value) => selector(value.requireValue)),
  );
}

class MyNameAsyncStateWidget extends ConsumerWidget {
  const MyNameAsyncStateWidget({
    super.key,
    required this.builder,
    this.child,
    this.onStateChanged,
  });

  /// The builder function that constructs the widget tree.
  /// Access the state directly via ref.state, which is equivalent to ref.watch(myNameAsyncProvider)
  ///
  /// For selecting specific fields, use ref.select() - e.g. ref.select((value) => value.someField)
  /// The ref parameter provides type-safe access to the provider state and notifier
  final Widget Function(
    BuildContext context,
    _MyNameAsyncStateProxyWidgetRef ref,
    Widget? child,
  )
  builder;
  final Widget? child;
  final void Function(String? previous, String? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasMyNameAsyncProviderScope(context);

    if (onStateChanged != null) {
      ref.listen(myNameAsyncProvider, (pre, next) {
        if (pre != next) onStateChanged!(pre?.valueOrNull, next.valueOrNull);
      });
    }
    return builder(context, _MyNameAsyncStateProxyWidgetRef(ref), child);
  }
}

class MyNameAsyncSelectWidget<Selected> extends ConsumerWidget {
  const MyNameAsyncSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(String state) selector;
  final Widget Function(
    BuildContext context,
    _MyNameAsyncStateProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasMyNameAsyncProviderScope(context);

    if (onStateChanged != null) {
      ref.listen(
        myNameAsyncProvider.select((value) => selector(value.requireValue)),
        (pre, next) {
          if (pre != next) onStateChanged!(pre, next);
        },
      );
    }
    final stateRef = _MyNameAsyncStateProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.select(selector));
  }
}

// ============================================================================
// AUTOVERPOD GENERATED STATE WIDGET - DO NOT MODIFY BY HAND
// ============================================================================
//
// Source: myNameProvider
//
// PUBLIC WIDGETS:
// - MyNameScope: Main scope widget for provider access
// - MyNameWidget: Consumer widget with automatic state access
// - MyNameSelect: Selector widget for optimized rebuilds
//

class _MyNameProxyWidgetRef extends WidgetRef {
  _MyNameProxyWidgetRef(this._ref);

  final WidgetRef _ref;

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

class MyNameProviderScope extends ConsumerWidget {
  const MyNameProviderScope({
    super.key,
    this.builder,
    this.child,
    this.onStateChanged,
  });

  final Widget Function(
    BuildContext context,
    _MyNameProxyWidgetRef ref,
    String state,
    Widget? child,
  )?
  builder;
  final Widget? child;
  final void Function(String? previous, String next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (onStateChanged != null) {
      ref.listen(myNameProvider, onStateChanged!);
    }

    return Consumer(
      child: child,
      builder: (context, ref, child) {
        final state = ref.watch(myNameProvider);

        if (builder != null) {
          return builder!(context, _MyNameProxyWidgetRef(ref), state, child);
        }

        return child ?? const SizedBox.shrink();
      },
    );
  }
}

bool _debugCheckHasMyNameProviderScope(BuildContext context) {
  assert(() {
    if (context.widget is! MyNameProviderScope &&
        context.findAncestorWidgetOfExactType<MyNameProviderScope>() == null) {
      // Check if we're in a navigation context (dialog or pushed screen)
      final isInNavigation = ModalRoute.of(context) != null;

      if (!isInNavigation) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No MyNameProviderScope found'),
          ErrorDescription(
            '${context.widget.runtimeType} widgets require a MyNameProviderScope widget ancestor '
            'or to be used in a navigation context with proper state management.',
          ),
        ]);
      }
      // If in navigation context, we'll return true but log a warning
      debugPrint(
        'Widget ${context.widget.runtimeType} used in navigation without direct MyNameProviderScope',
      );
    }
    return true;
  }());
  return true;
}

class _MyNameStateProxyWidgetRef extends _MyNameProxyWidgetRef {
  _MyNameStateProxyWidgetRef(super._ref);

  Selected select<Selected>(Selected Function(String) selector) =>
      _ref.watch(myNameProvider.select((value) => selector(value)));
}

class MyNameStateWidget extends ConsumerWidget {
  const MyNameStateWidget({
    super.key,
    required this.builder,
    this.child,
    this.onStateChanged,
  });

  /// The builder function that constructs the widget tree.
  /// Access the state directly via ref.state, which is equivalent to ref.watch(myNameProvider)
  ///
  /// For selecting specific fields, use ref.select() - e.g. ref.select((value) => value.someField)
  /// The ref parameter provides type-safe access to the provider state and notifier
  final Widget Function(
    BuildContext context,
    _MyNameStateProxyWidgetRef ref,
    Widget? child,
  )
  builder;
  final Widget? child;
  final void Function(String? previous, String? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasMyNameProviderScope(context);

    if (onStateChanged != null) {
      ref.listen(myNameProvider, (pre, next) {
        if (pre != next) onStateChanged!(pre, next);
      });
    }
    return builder(context, _MyNameStateProxyWidgetRef(ref), child);
  }
}

class MyNameSelectWidget<Selected> extends ConsumerWidget {
  const MyNameSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(String state) selector;
  final Widget Function(
    BuildContext context,
    _MyNameStateProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasMyNameProviderScope(context);

    if (onStateChanged != null) {
      ref.listen(myNameProvider.select((value) => selector(value)), (
        pre,
        next,
      ) {
        if (pre != next) onStateChanged!(pre, next);
      });
    }
    final stateRef = _MyNameStateProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.select(selector));
  }
}
