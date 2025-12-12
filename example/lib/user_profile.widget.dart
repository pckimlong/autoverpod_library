// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StateWidgetGenerator
// **************************************************************************

// ignore_for_file: type=lint, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unnecessary_import, unused_import

// coverage:ignore-file

import 'package:autoverpod/autoverpod.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart'
    show ProviderListenable, ProviderOrFamily;

import 'package:autoverpod_example/user_profile.dart';

// ============================================================================
// AUTOVERPOD - GENERATED CODE
// ============================================================================
//
// Source: asyncUserProfileProvider → UserProfileState
//
// Widgets: AsyncUserProfileWidget, AsyncUserProfileSelect
// Scope: AsyncUserProfileScope
//
// Fields:
// - NameField: ref.textController | ref.updateName(value)
// - EmailField: ref.textController | ref.updateEmail(value)
// - AgeField: ref.textController | ref.updateAge(value)
// - BioField: ref.textController | ref.updateBio(value)
// - Bio2Field: ref.textController | ref.updateBio2(value)
//

/// Extension that adds field update methods to the provider.
extension AsyncUserProfileFieldUpdater on AsyncUserProfile {
  /// Update the name field.
  void updateName(String newValue) =>
      state = state.whenData((s) => s.copyWith(name: newValue));

  /// Update the email field.
  void updateEmail(String newValue) =>
      state = state.whenData((s) => s.copyWith(email: newValue));

  /// Update the age field.
  void updateAge(int newValue) =>
      state = state.whenData((s) => s.copyWith(age: newValue));

  /// Update the bio field.
  void updateBio(String? newValue) =>
      state = state.whenData((s) => s.copyWith(bio: newValue));

  /// Update the bio2 field.
  void updateBio2(String? newValue) =>
      state = state.whenData((s) => s.copyWith(bio2: newValue));
}

class _AsyncUserProfileParamsInheritedWidget extends InheritedWidget {
  const _AsyncUserProfileParamsInheritedWidget({
    required this.id,
    required super.child,
  });

  final int id;

  static _AsyncUserProfileParamsInheritedWidget? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
          _AsyncUserProfileParamsInheritedWidget
        >();
  }

  static _AsyncUserProfileParamsInheritedWidget of(BuildContext context) {
    return maybeOf(context)!;
  }

  @override
  bool updateShouldNotify(
    covariant _AsyncUserProfileParamsInheritedWidget oldWidget,
  ) {
    return id != oldWidget.id;
  }
}

/// Scope widget to provide family parameters and handle async state.
///
/// **Usage:**
/// ```dart
/// AsyncUserProfileScope(
///   id: id,
///   loading: CircularProgressIndicator(),
///   error: (e, s) => Text(e.toString()),
///   child: // Your widget tree here,
/// )
/// ```
class AsyncUserProfileScope extends ConsumerWidget {
  const AsyncUserProfileScope({
    super.key,
    required this.id,
    required this.child,
    required this.loading,
    required this.error,
    this.builder,
    this.onStateChanged,
  }) : assert(builder != null || (loading != null && error != null));

  final int id;
  final Widget child;
  final Widget? loading;
  final Widget Function(Object error, StackTrace stackTrace)? error;
  final Widget Function(
    BuildContext context,
    AsyncValue<UserProfileState> asyncValue,
    Widget child,
  )?
  builder;
  final void Function(
    AsyncValue<UserProfileState>? previous,
    AsyncValue<UserProfileState> next,
  )?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = id;
    if (onStateChanged != null) {
      ref.listen(asyncUserProfileProvider(params), (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final asyncValue = ref.watch(asyncUserProfileProvider(params));
    final scopedChild = _AsyncUserProfileParamsInheritedWidget(
      id: id,
      child: child,
    );
    if (builder != null) {
      return builder!(context, asyncValue, scopedChild);
    }
    return asyncValue.when(
      data: (_) => scopedChild,
      loading: () => loading ?? const SizedBox.shrink(),
      error: (err, stack) => error?.call(err, stack) ?? const SizedBox.shrink(),
    );
  }
}

/// Proxy widget ref providing access to the provider.
class AsyncUserProfileProxyWidgetRef {
  AsyncUserProfileProxyWidgetRef(this._ref, {this.id});

  final WidgetRef _ref;

  final int? id;

  /// Resolved family parameters from direct values or scope.
  int get _params {
    final scope = _AsyncUserProfileParamsInheritedWidget.maybeOf(_ref.context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for AsyncUserProfileProvider');
    return idValue!;
  }

  AsyncUserProfile get notifier =>
      _ref.read(asyncUserProfileProvider(_params).notifier);

  /// Get params from scope (use within AsyncUserProfileScope).
  _AsyncUserProfileParamsInheritedWidget? get params =>
      _AsyncUserProfileParamsInheritedWidget.maybeOf(_ref.context);

  Selected select<Selected>(Selected Function(UserProfileState) selector) =>
      _ref.watch(
        asyncUserProfileProvider(
          _params,
        ).select((value) => selector(value.requireValue)),
      );

  BuildContext get context => _ref.context;

  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);
  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);
  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);
}

bool _debugCheckHasAsyncUserProfileScope(BuildContext context) {
  assert(() {
    if (_AsyncUserProfileParamsInheritedWidget.maybeOf(context) == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No AsyncUserProfileScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a AsyncUserProfileScope widget ancestor '
          'or to be provided the family parameters directly.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

/// Widget that rebuilds when any state changes.
///
/// **Usage:**
/// ```dart
/// AsyncUserProfileWidget(
///   id: id,
///   builder: (context, ref, state) {
///     return state.when(
///       data: (data) => Text(data.toString()),
///       loading: () => CircularProgressIndicator(),
///       error: (e, s) => Text(e.toString()),
///     );
///   },
/// )
/// ```
class AsyncUserProfileWidget extends ConsumerWidget {
  const AsyncUserProfileWidget({
    super.key,
    this.id,
    required this.builder,
    this.onStateChanged,
  });

  final int? id;

  final Widget Function(
    BuildContext context,
    AsyncUserProfileProxyWidgetRef ref,
    AsyncValue<UserProfileState> state,
  )
  builder;
  final void Function(
    AsyncValue<UserProfileState>? previous,
    AsyncValue<UserProfileState> next,
  )?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasAsyncUserProfileScope(context));
    final scope = _AsyncUserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for AsyncUserProfileProvider');
    final params = idValue!;
    if (onStateChanged != null) {
      ref.listen(asyncUserProfileProvider(params), (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final state = ref.watch(asyncUserProfileProvider(params));
    return builder(context, AsyncUserProfileProxyWidgetRef(ref, id: id), state);
  }
}

/// Widget that rebuilds only when selected value changes.
///
/// **Usage:**
/// ```dart
/// AsyncUserProfileSelect<String>(
///   id: id,
///   selector: (state) => state.name,
///   builder: (context, ref, selectedValue) {
///     return Text(selectedValue);
///   },
/// )
/// ```
class AsyncUserProfileSelect<Selected> extends ConsumerWidget {
  const AsyncUserProfileSelect({
    super.key,
    this.id,
    required this.selector,
    required this.builder,
    this.loading,
    this.error,
    this.onStateChanged,
  });

  final int? id;

  final Selected Function(UserProfileState state) selector;
  final Widget Function(
    BuildContext context,
    AsyncUserProfileProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final Widget? loading;
  final Widget Function(Object error, StackTrace stackTrace)? error;
  final void Function(Selected? previous, Selected next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasAsyncUserProfileScope(context));
    final scope = _AsyncUserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for AsyncUserProfileProvider');
    final params = idValue!;
    final asyncValue = ref.watch(asyncUserProfileProvider(params));
    if (onStateChanged != null) {
      ref.listen(asyncUserProfileProvider(params), (prev, next) {
        final prevData = prev?.value;
        final nextData = next.value;
        if (prevData != null && nextData != null) {
          final prevSelected = selector(prevData);
          final nextSelected = selector(nextData);
          if (prevSelected != nextSelected)
            onStateChanged!(prevSelected, nextSelected);
        }
      });
    }
    return asyncValue.when(
      data: (data) {
        final selected = selector(data);
        return builder(
          context,
          AsyncUserProfileProxyWidgetRef(ref, id: id),
          selected,
        );
      },
      loading: () => loading ?? const SizedBox.shrink(),
      error: (err, stack) => error?.call(err, stack) ?? const SizedBox.shrink(),
    );
  }
}

/// Widget that provides family parameters from scope with full provider access.
/// Use this to access params passed down through AsyncUserProfileScope.
///
/// **Usage:**
/// ```dart
/// AsyncUserProfileScope(
///   id: id,
///   child: AsyncUserProfileParamsBuilder(
///     builder: (context, ref, params) {
///       // params is int
///       return Text(ref.select((s) => s.name));
///     },
///   ),
/// )
/// ```
class AsyncUserProfileParamsBuilder extends ConsumerWidget {
  const AsyncUserProfileParamsBuilder({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    AsyncUserProfileProxyWidgetRef ref,
    int params,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasAsyncUserProfileScope(context));
    final scope = _AsyncUserProfileParamsInheritedWidget.of(context);
    final params = scope.id;
    return builder(context, AsyncUserProfileProxyWidgetRef(ref), params);
  }
}

/// Proxy ref for the name string field with text controller access.
class AsyncUserProfileNameProxyWidgetRef
    extends AsyncUserProfileProxyWidgetRef {
  AsyncUserProfileNameProxyWidgetRef(
    super._ref,
    this._stringFieldRef, {
    super.id,
  });

  final StringFieldRef _stringFieldRef;

  String get name => select((s) => s.name);
  void updateName(String value) => notifier.updateName(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the name field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// AsyncUserProfileNameField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class AsyncUserProfileNameField extends ConsumerWidget {
  const AsyncUserProfileNameField({
    super.key,
    this.id,
    this.controller,
    required this.builder,
    this.loading,
    this.error,
  });

  final int? id;

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    AsyncUserProfileNameProxyWidgetRef ref,
  )
  builder;
  final Widget? loading;
  final Widget Function(Object error, StackTrace stackTrace)? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasAsyncUserProfileScope(context));
    final scope = _AsyncUserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for AsyncUserProfileProvider');
    final params = idValue!;
    final asyncValue = ref.watch(asyncUserProfileProvider(params));
    return asyncValue.when(
      data: (data) {
        final value = data.name;
        return StringField(
          value: value,
          controller: controller,
          onChanged: (v) =>
              ref.read(asyncUserProfileProvider(params).notifier).updateName(v),
          builder: (context, stringFieldRef) {
            return builder(
              context,
              AsyncUserProfileNameProxyWidgetRef(ref, stringFieldRef, id: id),
            );
          },
        );
      },
      loading: () => loading ?? const SizedBox.shrink(),
      error: (err, stack) => error?.call(err, stack) ?? const SizedBox.shrink(),
    );
  }
}

/// Proxy ref for the email string field with text controller access.
class AsyncUserProfileEmailProxyWidgetRef
    extends AsyncUserProfileProxyWidgetRef {
  AsyncUserProfileEmailProxyWidgetRef(
    super._ref,
    this._stringFieldRef, {
    super.id,
  });

  final StringFieldRef _stringFieldRef;

  String get email => select((s) => s.email);
  void updateEmail(String value) => notifier.updateEmail(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the email field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// AsyncUserProfileEmailField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class AsyncUserProfileEmailField extends ConsumerWidget {
  const AsyncUserProfileEmailField({
    super.key,
    this.id,
    this.controller,
    required this.builder,
    this.loading,
    this.error,
  });

  final int? id;

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    AsyncUserProfileEmailProxyWidgetRef ref,
  )
  builder;
  final Widget? loading;
  final Widget Function(Object error, StackTrace stackTrace)? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasAsyncUserProfileScope(context));
    final scope = _AsyncUserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for AsyncUserProfileProvider');
    final params = idValue!;
    final asyncValue = ref.watch(asyncUserProfileProvider(params));
    return asyncValue.when(
      data: (data) {
        final value = data.email;
        return StringField(
          value: value,
          controller: controller,
          onChanged: (v) => ref
              .read(asyncUserProfileProvider(params).notifier)
              .updateEmail(v),
          builder: (context, stringFieldRef) {
            return builder(
              context,
              AsyncUserProfileEmailProxyWidgetRef(ref, stringFieldRef, id: id),
            );
          },
        );
      },
      loading: () => loading ?? const SizedBox.shrink(),
      error: (err, stack) => error?.call(err, stack) ?? const SizedBox.shrink(),
    );
  }
}

/// Proxy ref for the age number field with text controller access.
class AsyncUserProfileAgeProxyWidgetRef extends AsyncUserProfileProxyWidgetRef {
  AsyncUserProfileAgeProxyWidgetRef(
    super._ref,
    this._numberFieldRef, {
    super.id,
  });

  final NumberFieldRef<int> _numberFieldRef;

  int get age => select((s) => s.age);
  void updateAge(int value) => notifier.updateAge(value);
  TextEditingController get textController => _numberFieldRef.controller;
}

/// Widget for the age field with auto number controller sync.
///
/// **Usage:**
/// ```dart
/// AsyncUserProfileAgeField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class AsyncUserProfileAgeField extends ConsumerWidget {
  const AsyncUserProfileAgeField({
    super.key,
    this.id,
    this.controller,
    required this.builder,
    this.loading,
    this.error,
  });

  final int? id;

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    AsyncUserProfileAgeProxyWidgetRef ref,
  )
  builder;
  final Widget? loading;
  final Widget Function(Object error, StackTrace stackTrace)? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasAsyncUserProfileScope(context));
    final scope = _AsyncUserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for AsyncUserProfileProvider');
    final params = idValue!;
    final asyncValue = ref.watch(asyncUserProfileProvider(params));
    return asyncValue.when(
      data: (data) {
        final value = data.age;
        return NumberField<int>(
          value: value,
          controller: controller,
          onChanged: (v) {
            if (v != null)
              ref.read(asyncUserProfileProvider(params).notifier).updateAge(v);
          },
          builder: (context, numberFieldRef) {
            return builder(
              context,
              AsyncUserProfileAgeProxyWidgetRef(ref, numberFieldRef, id: id),
            );
          },
        );
      },
      loading: () => loading ?? const SizedBox.shrink(),
      error: (err, stack) => error?.call(err, stack) ?? const SizedBox.shrink(),
    );
  }
}

/// Proxy ref for the bio string field with text controller access.
class AsyncUserProfileBioProxyWidgetRef extends AsyncUserProfileProxyWidgetRef {
  AsyncUserProfileBioProxyWidgetRef(
    super._ref,
    this._stringFieldRef, {
    super.id,
  });

  final StringFieldRef _stringFieldRef;

  String? get bio => select((s) => s.bio);
  void updateBio(String? value) => notifier.updateBio(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the bio field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// AsyncUserProfileBioField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class AsyncUserProfileBioField extends ConsumerWidget {
  const AsyncUserProfileBioField({
    super.key,
    this.id,
    this.controller,
    required this.builder,
    this.loading,
    this.error,
  });

  final int? id;

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    AsyncUserProfileBioProxyWidgetRef ref,
  )
  builder;
  final Widget? loading;
  final Widget Function(Object error, StackTrace stackTrace)? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasAsyncUserProfileScope(context));
    final scope = _AsyncUserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for AsyncUserProfileProvider');
    final params = idValue!;
    final asyncValue = ref.watch(asyncUserProfileProvider(params));
    return asyncValue.when(
      data: (data) {
        final value = data.bio;
        return StringField(
          value: value,
          controller: controller,
          onChanged: (v) =>
              ref.read(asyncUserProfileProvider(params).notifier).updateBio(v),
          builder: (context, stringFieldRef) {
            return builder(
              context,
              AsyncUserProfileBioProxyWidgetRef(ref, stringFieldRef, id: id),
            );
          },
        );
      },
      loading: () => loading ?? const SizedBox.shrink(),
      error: (err, stack) => error?.call(err, stack) ?? const SizedBox.shrink(),
    );
  }
}

/// Proxy ref for the bio2 string field with text controller access.
class AsyncUserProfileBio2ProxyWidgetRef
    extends AsyncUserProfileProxyWidgetRef {
  AsyncUserProfileBio2ProxyWidgetRef(
    super._ref,
    this._stringFieldRef, {
    super.id,
  });

  final StringFieldRef _stringFieldRef;

  String? get bio2 => select((s) => s.bio2);
  void updateBio2(String? value) => notifier.updateBio2(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the bio2 field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// AsyncUserProfileBio2Field(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class AsyncUserProfileBio2Field extends ConsumerWidget {
  const AsyncUserProfileBio2Field({
    super.key,
    this.id,
    this.controller,
    required this.builder,
    this.loading,
    this.error,
  });

  final int? id;

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    AsyncUserProfileBio2ProxyWidgetRef ref,
  )
  builder;
  final Widget? loading;
  final Widget Function(Object error, StackTrace stackTrace)? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasAsyncUserProfileScope(context));
    final scope = _AsyncUserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for AsyncUserProfileProvider');
    final params = idValue!;
    final asyncValue = ref.watch(asyncUserProfileProvider(params));
    return asyncValue.when(
      data: (data) {
        final value = data.bio2;
        return StringField(
          value: value,
          controller: controller,
          onChanged: (v) =>
              ref.read(asyncUserProfileProvider(params).notifier).updateBio2(v),
          builder: (context, stringFieldRef) {
            return builder(
              context,
              AsyncUserProfileBio2ProxyWidgetRef(ref, stringFieldRef, id: id),
            );
          },
        );
      },
      loading: () => loading ?? const SizedBox.shrink(),
      error: (err, stack) => error?.call(err, stack) ?? const SizedBox.shrink(),
    );
  }
}

// ============================================================================
// AUTOVERPOD - GENERATED CODE
// ============================================================================
//
// Source: userProfileProvider → UserProfileState
//
// Widgets: UserProfileWidget, UserProfileSelect
// Scope: UserProfileScope
//
// Fields:
// - NameField: ref.textController | ref.updateName(value)
// - EmailField: ref.textController | ref.updateEmail(value)
// - AgeField: ref.textController | ref.updateAge(value)
// - BioField: ref.textController | ref.updateBio(value)
// - Bio2Field: ref.textController | ref.updateBio2(value)
//

/// Extension that adds field update methods to the provider.
extension UserProfileFieldUpdater on UserProfile {
  /// Update the name field.
  void updateName(String newValue) => state = state.copyWith(name: newValue);

  /// Update the email field.
  void updateEmail(String newValue) => state = state.copyWith(email: newValue);

  /// Update the age field.
  void updateAge(int newValue) => state = state.copyWith(age: newValue);

  /// Update the bio field.
  void updateBio(String? newValue) => state = state.copyWith(bio: newValue);

  /// Update the bio2 field.
  void updateBio2(String? newValue) => state = state.copyWith(bio2: newValue);
}

class _UserProfileParamsInheritedWidget extends InheritedWidget {
  const _UserProfileParamsInheritedWidget({
    required this.id,
    required super.child,
  });

  final int id;

  static _UserProfileParamsInheritedWidget? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
          _UserProfileParamsInheritedWidget
        >();
  }

  static _UserProfileParamsInheritedWidget of(BuildContext context) {
    return maybeOf(context)!;
  }

  @override
  bool updateShouldNotify(
    covariant _UserProfileParamsInheritedWidget oldWidget,
  ) {
    return id != oldWidget.id;
  }
}

/// Scope widget to provide family parameters to child widgets.
///
/// **Usage:**
/// ```dart
/// UserProfileScope(
///   id: id,
///   child: // Your widget tree here,
/// )
/// ```
class UserProfileScope extends StatelessWidget {
  const UserProfileScope({super.key, required this.id, required this.child});

  final int id;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _UserProfileParamsInheritedWidget(id: id, child: child);
  }
}

/// Proxy widget ref providing access to the provider.
class UserProfileProxyWidgetRef {
  UserProfileProxyWidgetRef(this._ref, {this.id});

  final WidgetRef _ref;

  final int? id;

  /// Resolved family parameters from direct values or scope.
  int get _params {
    final scope = _UserProfileParamsInheritedWidget.maybeOf(_ref.context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for UserProfileProvider');
    return idValue!;
  }

  UserProfile get notifier => _ref.read(userProfileProvider(_params).notifier);

  /// Get params from scope (use within UserProfileScope).
  _UserProfileParamsInheritedWidget? get params =>
      _UserProfileParamsInheritedWidget.maybeOf(_ref.context);

  Selected select<Selected>(Selected Function(UserProfileState) selector) =>
      _ref.watch(
        userProfileProvider(_params).select((value) => selector(value)),
      );

  BuildContext get context => _ref.context;

  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);
  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);
  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);
}

bool _debugCheckHasUserProfileScope(BuildContext context) {
  assert(() {
    if (_UserProfileParamsInheritedWidget.maybeOf(context) == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No UserProfileScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a UserProfileScope widget ancestor '
          'or to be provided the family parameters directly.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

/// Widget that rebuilds when any state changes.
///
/// **Usage:**
/// ```dart
/// UserProfileWidget(
///   id: id,
///   builder: (context, ref, state) {
///     return Text(state.toString());
///   },
/// )
/// ```
class UserProfileWidget extends ConsumerWidget {
  const UserProfileWidget({
    super.key,
    this.id,
    required this.builder,
    this.onStateChanged,
  });

  final int? id;

  final Widget Function(
    BuildContext context,
    UserProfileProxyWidgetRef ref,
    UserProfileState state,
  )
  builder;
  final void Function(UserProfileState? previous, UserProfileState next)?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasUserProfileScope(context));
    final scope = _UserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for UserProfileProvider');
    final params = idValue!;
    if (onStateChanged != null) {
      ref.listen(userProfileProvider(params), (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final state = ref.watch(userProfileProvider(params));
    return builder(context, UserProfileProxyWidgetRef(ref, id: id), state);
  }
}

/// Widget that rebuilds only when selected value changes.
///
/// **Usage:**
/// ```dart
/// UserProfileSelect<String>(
///   id: id,
///   selector: (state) => state.name,
///   builder: (context, ref, selectedValue) {
///     return Text(selectedValue);
///   },
/// )
/// ```
class UserProfileSelect<Selected> extends ConsumerWidget {
  const UserProfileSelect({
    super.key,
    this.id,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final int? id;

  final Selected Function(UserProfileState state) selector;
  final Widget Function(
    BuildContext context,
    UserProfileProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasUserProfileScope(context));
    final scope = _UserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for UserProfileProvider');
    final params = idValue!;
    final selectedProvider = userProfileProvider(
      params,
    ).select((value) => selector(value));
    if (onStateChanged != null) {
      ref.listen(selectedProvider, (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final selected = ref.watch(selectedProvider);
    return builder(context, UserProfileProxyWidgetRef(ref, id: id), selected);
  }
}

/// Widget that provides family parameters from scope with full provider access.
/// Use this to access params passed down through UserProfileScope.
///
/// **Usage:**
/// ```dart
/// UserProfileScope(
///   id: id,
///   child: UserProfileParamsBuilder(
///     builder: (context, ref, params) {
///       // params is int
///       return Text(ref.select((s) => s.name));
///     },
///   ),
/// )
/// ```
class UserProfileParamsBuilder extends ConsumerWidget {
  const UserProfileParamsBuilder({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    UserProfileProxyWidgetRef ref,
    int params,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasUserProfileScope(context));
    final scope = _UserProfileParamsInheritedWidget.of(context);
    final params = scope.id;
    return builder(context, UserProfileProxyWidgetRef(ref), params);
  }
}

/// Proxy ref for the name string field with text controller access.
class UserProfileNameProxyWidgetRef extends UserProfileProxyWidgetRef {
  UserProfileNameProxyWidgetRef(super._ref, this._stringFieldRef, {super.id});

  final StringFieldRef _stringFieldRef;

  String get name => select((s) => s.name);
  void updateName(String value) => notifier.updateName(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the name field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// UserProfileNameField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class UserProfileNameField extends ConsumerWidget {
  const UserProfileNameField({
    super.key,
    this.id,
    this.controller,
    required this.builder,
  });

  final int? id;

  final TextEditingController? controller;
  final Widget Function(BuildContext context, UserProfileNameProxyWidgetRef ref)
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasUserProfileScope(context));
    final scope = _UserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for UserProfileProvider');
    final params = idValue!;
    final value = ref.watch(userProfileProvider(params).select((s) => s.name));

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(userProfileProvider(params).notifier).updateName(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          UserProfileNameProxyWidgetRef(ref, stringFieldRef, id: id),
        );
      },
    );
  }
}

/// Proxy ref for the email string field with text controller access.
class UserProfileEmailProxyWidgetRef extends UserProfileProxyWidgetRef {
  UserProfileEmailProxyWidgetRef(super._ref, this._stringFieldRef, {super.id});

  final StringFieldRef _stringFieldRef;

  String get email => select((s) => s.email);
  void updateEmail(String value) => notifier.updateEmail(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the email field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// UserProfileEmailField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class UserProfileEmailField extends ConsumerWidget {
  const UserProfileEmailField({
    super.key,
    this.id,
    this.controller,
    required this.builder,
  });

  final int? id;

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    UserProfileEmailProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasUserProfileScope(context));
    final scope = _UserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for UserProfileProvider');
    final params = idValue!;
    final value = ref.watch(userProfileProvider(params).select((s) => s.email));

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(userProfileProvider(params).notifier).updateEmail(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          UserProfileEmailProxyWidgetRef(ref, stringFieldRef, id: id),
        );
      },
    );
  }
}

/// Proxy ref for the age number field with text controller access.
class UserProfileAgeProxyWidgetRef extends UserProfileProxyWidgetRef {
  UserProfileAgeProxyWidgetRef(super._ref, this._numberFieldRef, {super.id});

  final NumberFieldRef<int> _numberFieldRef;

  int get age => select((s) => s.age);
  void updateAge(int value) => notifier.updateAge(value);
  TextEditingController get textController => _numberFieldRef.controller;
}

/// Widget for the age field with auto number controller sync.
///
/// **Usage:**
/// ```dart
/// UserProfileAgeField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class UserProfileAgeField extends ConsumerWidget {
  const UserProfileAgeField({
    super.key,
    this.id,
    this.controller,
    required this.builder,
  });

  final int? id;

  final TextEditingController? controller;
  final Widget Function(BuildContext context, UserProfileAgeProxyWidgetRef ref)
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasUserProfileScope(context));
    final scope = _UserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for UserProfileProvider');
    final params = idValue!;
    final value = ref.watch(userProfileProvider(params).select((s) => s.age));

    return NumberField<int>(
      value: value,
      controller: controller,
      onChanged: (v) {
        if (v != null)
          ref.read(userProfileProvider(params).notifier).updateAge(v);
      },
      builder: (context, numberFieldRef) {
        return builder(
          context,
          UserProfileAgeProxyWidgetRef(ref, numberFieldRef, id: id),
        );
      },
    );
  }
}

/// Proxy ref for the bio string field with text controller access.
class UserProfileBioProxyWidgetRef extends UserProfileProxyWidgetRef {
  UserProfileBioProxyWidgetRef(super._ref, this._stringFieldRef, {super.id});

  final StringFieldRef _stringFieldRef;

  String? get bio => select((s) => s.bio);
  void updateBio(String? value) => notifier.updateBio(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the bio field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// UserProfileBioField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class UserProfileBioField extends ConsumerWidget {
  const UserProfileBioField({
    super.key,
    this.id,
    this.controller,
    required this.builder,
  });

  final int? id;

  final TextEditingController? controller;
  final Widget Function(BuildContext context, UserProfileBioProxyWidgetRef ref)
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasUserProfileScope(context));
    final scope = _UserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for UserProfileProvider');
    final params = idValue!;
    final value = ref.watch(userProfileProvider(params).select((s) => s.bio));

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(userProfileProvider(params).notifier).updateBio(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          UserProfileBioProxyWidgetRef(ref, stringFieldRef, id: id),
        );
      },
    );
  }
}

/// Proxy ref for the bio2 string field with text controller access.
class UserProfileBio2ProxyWidgetRef extends UserProfileProxyWidgetRef {
  UserProfileBio2ProxyWidgetRef(super._ref, this._stringFieldRef, {super.id});

  final StringFieldRef _stringFieldRef;

  String? get bio2 => select((s) => s.bio2);
  void updateBio2(String? value) => notifier.updateBio2(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the bio2 field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// UserProfileBio2Field(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class UserProfileBio2Field extends ConsumerWidget {
  const UserProfileBio2Field({
    super.key,
    this.id,
    this.controller,
    required this.builder,
  });

  final int? id;

  final TextEditingController? controller;
  final Widget Function(BuildContext context, UserProfileBio2ProxyWidgetRef ref)
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsScope = id == null;
    if (needsScope) assert(_debugCheckHasUserProfileScope(context));
    final scope = _UserProfileParamsInheritedWidget.maybeOf(context);
    final idValue = id ?? scope?.id;
    assert(idValue != null, 'No id provided for UserProfileProvider');
    final params = idValue!;
    final value = ref.watch(userProfileProvider(params).select((s) => s.bio2));

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(userProfileProvider(params).notifier).updateBio2(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          UserProfileBio2ProxyWidgetRef(ref, stringFieldRef, id: id),
        );
      },
    );
  }
}

// ============================================================================
// AUTOVERPOD - GENERATED CODE
// ============================================================================
//
// Source: secondUserProfileProvider → UserProfileState
//
// Widgets: SecondUserProfileWidget, SecondUserProfileSelect
// Scope: SecondUserProfileScope
//
// Fields:
// - NameField: ref.textController | ref.updateName(value)
// - EmailField: ref.textController | ref.updateEmail(value)
// - AgeField: ref.textController | ref.updateAge(value)
// - BioField: ref.textController | ref.updateBio(value)
// - Bio2Field: ref.textController | ref.updateBio2(value)
//

/// Extension that adds field update methods to the provider.
extension SecondUserProfileFieldUpdater on SecondUserProfile {
  /// Update the name field.
  void updateName(String newValue) => state = state.copyWith(name: newValue);

  /// Update the email field.
  void updateEmail(String newValue) => state = state.copyWith(email: newValue);

  /// Update the age field.
  void updateAge(int newValue) => state = state.copyWith(age: newValue);

  /// Update the bio field.
  void updateBio(String? newValue) => state = state.copyWith(bio: newValue);

  /// Update the bio2 field.
  void updateBio2(String? newValue) => state = state.copyWith(bio2: newValue);
}

class _SecondUserProfileParamsInheritedWidget extends InheritedWidget {
  const _SecondUserProfileParamsInheritedWidget({required super.child});

  static _SecondUserProfileParamsInheritedWidget? maybeOf(
    BuildContext context,
  ) {
    return context
        .dependOnInheritedWidgetOfExactType<
          _SecondUserProfileParamsInheritedWidget
        >();
  }

  static _SecondUserProfileParamsInheritedWidget of(BuildContext context) {
    return maybeOf(context)!;
  }

  @override
  bool updateShouldNotify(
    covariant _SecondUserProfileParamsInheritedWidget oldWidget,
  ) {
    return false;
  }
}

/// Scope widget placeholder for future family parameters.
/// Wrap your widget tree with this to future-proof for family provider migration.
class SecondUserProfileScope extends StatelessWidget {
  const SecondUserProfileScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _SecondUserProfileParamsInheritedWidget(child: child);
  }
}

/// Proxy widget ref providing access to the provider.
class SecondUserProfileProxyWidgetRef {
  SecondUserProfileProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  SecondUserProfile get notifier =>
      _ref.read(secondUserProfileProvider.notifier);

  /// Get params from scope (use within SecondUserProfileScope).
  _SecondUserProfileParamsInheritedWidget? get params =>
      _SecondUserProfileParamsInheritedWidget.maybeOf(_ref.context);

  Selected select<Selected>(Selected Function(UserProfileState) selector) =>
      _ref.watch(secondUserProfileProvider.select((value) => selector(value)));

  BuildContext get context => _ref.context;

  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);
  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);
  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);
}

/// Widget that rebuilds when any state changes.
///
/// **Usage:**
/// ```dart
/// SecondUserProfileWidget(
///   builder: (context, ref, state) {
///     return Text(state.toString());
///   },
/// )
/// ```
class SecondUserProfileWidget extends ConsumerWidget {
  const SecondUserProfileWidget({
    super.key,
    required this.builder,
    this.onStateChanged,
  });

  final Widget Function(
    BuildContext context,
    SecondUserProfileProxyWidgetRef ref,
    UserProfileState state,
  )
  builder;
  final void Function(UserProfileState? previous, UserProfileState next)?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (onStateChanged != null) {
      ref.listen(secondUserProfileProvider, (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final state = ref.watch(secondUserProfileProvider);
    return builder(context, SecondUserProfileProxyWidgetRef(ref), state);
  }
}

/// Widget that rebuilds only when selected value changes.
///
/// **Usage:**
/// ```dart
/// SecondUserProfileSelect<String>(
///   selector: (state) => state.name,
///   builder: (context, ref, selectedValue) {
///     return Text(selectedValue);
///   },
/// )
/// ```
class SecondUserProfileSelect<Selected> extends ConsumerWidget {
  const SecondUserProfileSelect({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(UserProfileState state) selector;
  final Widget Function(
    BuildContext context,
    SecondUserProfileProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProvider = secondUserProfileProvider.select(
      (value) => selector(value),
    );
    if (onStateChanged != null) {
      ref.listen(selectedProvider, (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final selected = ref.watch(selectedProvider);
    return builder(context, SecondUserProfileProxyWidgetRef(ref), selected);
  }
}

/// Proxy ref for the name string field with text controller access.
class SecondUserProfileNameProxyWidgetRef
    extends SecondUserProfileProxyWidgetRef {
  SecondUserProfileNameProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String get name => select((s) => s.name);
  void updateName(String value) => notifier.updateName(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the name field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// SecondUserProfileNameField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class SecondUserProfileNameField extends ConsumerWidget {
  const SecondUserProfileNameField({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    SecondUserProfileNameProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(secondUserProfileProvider.select((s) => s.name));

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(secondUserProfileProvider.notifier).updateName(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          SecondUserProfileNameProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}

/// Proxy ref for the email string field with text controller access.
class SecondUserProfileEmailProxyWidgetRef
    extends SecondUserProfileProxyWidgetRef {
  SecondUserProfileEmailProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String get email => select((s) => s.email);
  void updateEmail(String value) => notifier.updateEmail(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the email field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// SecondUserProfileEmailField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class SecondUserProfileEmailField extends ConsumerWidget {
  const SecondUserProfileEmailField({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    SecondUserProfileEmailProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(secondUserProfileProvider.select((s) => s.email));

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(secondUserProfileProvider.notifier).updateEmail(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          SecondUserProfileEmailProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}

/// Proxy ref for the age number field with text controller access.
class SecondUserProfileAgeProxyWidgetRef
    extends SecondUserProfileProxyWidgetRef {
  SecondUserProfileAgeProxyWidgetRef(super._ref, this._numberFieldRef);

  final NumberFieldRef<int> _numberFieldRef;

  int get age => select((s) => s.age);
  void updateAge(int value) => notifier.updateAge(value);
  TextEditingController get textController => _numberFieldRef.controller;
}

/// Widget for the age field with auto number controller sync.
///
/// **Usage:**
/// ```dart
/// SecondUserProfileAgeField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class SecondUserProfileAgeField extends ConsumerWidget {
  const SecondUserProfileAgeField({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    SecondUserProfileAgeProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(secondUserProfileProvider.select((s) => s.age));

    return NumberField<int>(
      value: value,
      controller: controller,
      onChanged: (v) {
        if (v != null)
          ref.read(secondUserProfileProvider.notifier).updateAge(v);
      },
      builder: (context, numberFieldRef) {
        return builder(
          context,
          SecondUserProfileAgeProxyWidgetRef(ref, numberFieldRef),
        );
      },
    );
  }
}

/// Proxy ref for the bio string field with text controller access.
class SecondUserProfileBioProxyWidgetRef
    extends SecondUserProfileProxyWidgetRef {
  SecondUserProfileBioProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String? get bio => select((s) => s.bio);
  void updateBio(String? value) => notifier.updateBio(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the bio field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// SecondUserProfileBioField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class SecondUserProfileBioField extends ConsumerWidget {
  const SecondUserProfileBioField({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    SecondUserProfileBioProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(secondUserProfileProvider.select((s) => s.bio));

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(secondUserProfileProvider.notifier).updateBio(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          SecondUserProfileBioProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}

/// Proxy ref for the bio2 string field with text controller access.
class SecondUserProfileBio2ProxyWidgetRef
    extends SecondUserProfileProxyWidgetRef {
  SecondUserProfileBio2ProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String? get bio2 => select((s) => s.bio2);
  void updateBio2(String? value) => notifier.updateBio2(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the bio2 field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// SecondUserProfileBio2Field(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class SecondUserProfileBio2Field extends ConsumerWidget {
  const SecondUserProfileBio2Field({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    SecondUserProfileBio2ProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(secondUserProfileProvider.select((s) => s.bio2));

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(secondUserProfileProvider.notifier).updateBio2(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          SecondUserProfileBio2ProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}
