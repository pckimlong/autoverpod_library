// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StateWidgetGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=80

// **************************************************************************

// StateWidgetGenerator

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
// - AgeField: ref.updateAge(value)
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
    final params = (id: id);
    if (onStateChanged != null) {
      ref.listen(asyncUserProfileProvider(params.id), (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final asyncValue = ref.watch(asyncUserProfileProvider(params.id));
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
  AsyncUserProfileProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  AsyncUserProfile get notifier =>
      _ref.read(asyncUserProfileProvider(params!.id).notifier);

  /// Get params from scope (use within AsyncUserProfileScope).
  _AsyncUserProfileParamsInheritedWidget? get params =>
      _AsyncUserProfileParamsInheritedWidget.maybeOf(_ref.context);

  Selected select<Selected>(Selected Function(UserProfileState) selector) =>
      _ref.watch(
        asyncUserProfileProvider(
          params!.id,
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
      final isInNavigation = ModalRoute.of(context) != null;
      if (!isInNavigation) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No AsyncUserProfileScope found'),
          ErrorDescription(
            '${context.widget.runtimeType} widgets require a AsyncUserProfileScope widget ancestor '
            'or to be used in a navigation context with proper state management.',
          ),
        ]);
      }
      debugPrint(
        'Widget ${context.widget.runtimeType} used in navigation without direct AsyncUserProfileScope',
      );
    }
    return true;
  }());
  return true;
}

/// Widget that rebuilds when any state changes.
class AsyncUserProfileWidget extends ConsumerWidget {
  const AsyncUserProfileWidget({
    super.key,
    required this.builder,
    this.onStateChanged,
  });

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
    assert(_debugCheckHasAsyncUserProfileScope(context));
    final params = _AsyncUserProfileParamsInheritedWidget.of(context);
    if (onStateChanged != null) {
      ref.listen(asyncUserProfileProvider(params.id), (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final state = ref.watch(asyncUserProfileProvider(params.id));
    return builder(context, AsyncUserProfileProxyWidgetRef(ref), state);
  }
}

/// Widget that rebuilds only when selected value changes.
class AsyncUserProfileSelect<Selected> extends ConsumerWidget {
  const AsyncUserProfileSelect({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(UserProfileState state) selector;
  final Widget Function(
    BuildContext context,
    AsyncUserProfileProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasAsyncUserProfileScope(context));
    final params = _AsyncUserProfileParamsInheritedWidget.of(context);
    final selectedProvider = asyncUserProfileProvider(
      params.id,
    ).select((value) => selector(value.requireValue));
    if (onStateChanged != null) {
      ref.listen(selectedProvider, (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final selected = ref.watch(selectedProvider);
    return builder(context, AsyncUserProfileProxyWidgetRef(ref), selected);
  }
}

/// Proxy ref for the name string field with text controller access.
class AsyncUserProfileNameProxyWidgetRef
    extends AsyncUserProfileProxyWidgetRef {
  AsyncUserProfileNameProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String get name => select((s) => s.name);
  void updateName(String value) => notifier.updateName(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the name field with auto text controller sync.
class AsyncUserProfileNameField extends ConsumerWidget {
  const AsyncUserProfileNameField({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    AsyncUserProfileNameProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasAsyncUserProfileScope(context));
    final params = _AsyncUserProfileParamsInheritedWidget.of(context);
    final value = ref.watch(
      asyncUserProfileProvider(params.id).select((s) => s.requireValue.name),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(asyncUserProfileProvider(params.id).notifier).updateName(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          AsyncUserProfileNameProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}

/// Proxy ref for the email string field with text controller access.
class AsyncUserProfileEmailProxyWidgetRef
    extends AsyncUserProfileProxyWidgetRef {
  AsyncUserProfileEmailProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String get email => select((s) => s.email);
  void updateEmail(String value) => notifier.updateEmail(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the email field with auto text controller sync.
class AsyncUserProfileEmailField extends ConsumerWidget {
  const AsyncUserProfileEmailField({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    AsyncUserProfileEmailProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasAsyncUserProfileScope(context));
    final params = _AsyncUserProfileParamsInheritedWidget.of(context);
    final value = ref.watch(
      asyncUserProfileProvider(params.id).select((s) => s.requireValue.email),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(asyncUserProfileProvider(params.id).notifier).updateEmail(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          AsyncUserProfileEmailProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}

class AsyncUserProfileAgeProxyWidgetRef extends AsyncUserProfileProxyWidgetRef {
  AsyncUserProfileAgeProxyWidgetRef(super._ref);

  int get age => select((s) => s.age);
  void updateAge(int value) => notifier.updateAge(value);
}

class AsyncUserProfileAgeField extends ConsumerWidget {
  const AsyncUserProfileAgeField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    AsyncUserProfileAgeProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasAsyncUserProfileScope(context));
    return builder(context, AsyncUserProfileAgeProxyWidgetRef(ref));
  }
}

/// Proxy ref for the bio string field with text controller access.
class AsyncUserProfileBioProxyWidgetRef extends AsyncUserProfileProxyWidgetRef {
  AsyncUserProfileBioProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String? get bio => select((s) => s.bio);
  void updateBio(String? value) => notifier.updateBio(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the bio field with auto text controller sync.
class AsyncUserProfileBioField extends ConsumerWidget {
  const AsyncUserProfileBioField({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    AsyncUserProfileBioProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasAsyncUserProfileScope(context));
    final params = _AsyncUserProfileParamsInheritedWidget.of(context);
    final value = ref.watch(
      asyncUserProfileProvider(params.id).select((s) => s.requireValue.bio),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(asyncUserProfileProvider(params.id).notifier).updateBio(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          AsyncUserProfileBioProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}

/// Proxy ref for the bio2 string field with text controller access.
class AsyncUserProfileBio2ProxyWidgetRef
    extends AsyncUserProfileProxyWidgetRef {
  AsyncUserProfileBio2ProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String? get bio2 => select((s) => s.bio2);
  void updateBio2(String? value) => notifier.updateBio2(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the bio2 field with auto text controller sync.
class AsyncUserProfileBio2Field extends ConsumerWidget {
  const AsyncUserProfileBio2Field({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    AsyncUserProfileBio2ProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasAsyncUserProfileScope(context));
    final params = _AsyncUserProfileParamsInheritedWidget.of(context);
    final value = ref.watch(
      asyncUserProfileProvider(params.id).select((s) => s.requireValue.bio2),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(asyncUserProfileProvider(params.id).notifier).updateBio2(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          AsyncUserProfileBio2ProxyWidgetRef(ref, stringFieldRef),
        );
      },
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
// - AgeField: ref.updateAge(value)
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
  UserProfileProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  UserProfile get notifier =>
      _ref.read(userProfileProvider(params!.id).notifier);

  /// Get params from scope (use within UserProfileScope).
  _UserProfileParamsInheritedWidget? get params =>
      _UserProfileParamsInheritedWidget.maybeOf(_ref.context);

  Selected select<Selected>(Selected Function(UserProfileState) selector) =>
      _ref.watch(
        userProfileProvider(params!.id).select((value) => selector(value)),
      );

  BuildContext get context => _ref.context;

  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);
  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);
  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);
}

bool _debugCheckHasUserProfileScope(BuildContext context) {
  assert(() {
    if (_UserProfileParamsInheritedWidget.maybeOf(context) == null) {
      final isInNavigation = ModalRoute.of(context) != null;
      if (!isInNavigation) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No UserProfileScope found'),
          ErrorDescription(
            '${context.widget.runtimeType} widgets require a UserProfileScope widget ancestor '
            'or to be used in a navigation context with proper state management.',
          ),
        ]);
      }
      debugPrint(
        'Widget ${context.widget.runtimeType} used in navigation without direct UserProfileScope',
      );
    }
    return true;
  }());
  return true;
}

/// Widget that rebuilds when any state changes.
class UserProfileWidget extends ConsumerWidget {
  const UserProfileWidget({
    super.key,
    required this.builder,
    this.onStateChanged,
  });

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
    assert(_debugCheckHasUserProfileScope(context));
    final params = _UserProfileParamsInheritedWidget.of(context);
    if (onStateChanged != null) {
      ref.listen(userProfileProvider(params.id), (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final state = ref.watch(userProfileProvider(params.id));
    return builder(context, UserProfileProxyWidgetRef(ref), state);
  }
}

/// Widget that rebuilds only when selected value changes.
class UserProfileSelect<Selected> extends ConsumerWidget {
  const UserProfileSelect({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

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
    assert(_debugCheckHasUserProfileScope(context));
    final params = _UserProfileParamsInheritedWidget.of(context);
    final selectedProvider = userProfileProvider(
      params.id,
    ).select((value) => selector(value));
    if (onStateChanged != null) {
      ref.listen(selectedProvider, (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final selected = ref.watch(selectedProvider);
    return builder(context, UserProfileProxyWidgetRef(ref), selected);
  }
}

/// Proxy ref for the name string field with text controller access.
class UserProfileNameProxyWidgetRef extends UserProfileProxyWidgetRef {
  UserProfileNameProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String get name => select((s) => s.name);
  void updateName(String value) => notifier.updateName(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the name field with auto text controller sync.
class UserProfileNameField extends ConsumerWidget {
  const UserProfileNameField({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(BuildContext context, UserProfileNameProxyWidgetRef ref)
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasUserProfileScope(context));
    final params = _UserProfileParamsInheritedWidget.of(context);
    final value = ref.watch(
      userProfileProvider(params.id).select((s) => s.name),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(userProfileProvider(params.id).notifier).updateName(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          UserProfileNameProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}

/// Proxy ref for the email string field with text controller access.
class UserProfileEmailProxyWidgetRef extends UserProfileProxyWidgetRef {
  UserProfileEmailProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String get email => select((s) => s.email);
  void updateEmail(String value) => notifier.updateEmail(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the email field with auto text controller sync.
class UserProfileEmailField extends ConsumerWidget {
  const UserProfileEmailField({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(
    BuildContext context,
    UserProfileEmailProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasUserProfileScope(context));
    final params = _UserProfileParamsInheritedWidget.of(context);
    final value = ref.watch(
      userProfileProvider(params.id).select((s) => s.email),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(userProfileProvider(params.id).notifier).updateEmail(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          UserProfileEmailProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}

class UserProfileAgeProxyWidgetRef extends UserProfileProxyWidgetRef {
  UserProfileAgeProxyWidgetRef(super._ref);

  int get age => select((s) => s.age);
  void updateAge(int value) => notifier.updateAge(value);
}

class UserProfileAgeField extends ConsumerWidget {
  const UserProfileAgeField({super.key, required this.builder});

  final Widget Function(BuildContext context, UserProfileAgeProxyWidgetRef ref)
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasUserProfileScope(context));
    return builder(context, UserProfileAgeProxyWidgetRef(ref));
  }
}

/// Proxy ref for the bio string field with text controller access.
class UserProfileBioProxyWidgetRef extends UserProfileProxyWidgetRef {
  UserProfileBioProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String? get bio => select((s) => s.bio);
  void updateBio(String? value) => notifier.updateBio(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the bio field with auto text controller sync.
class UserProfileBioField extends ConsumerWidget {
  const UserProfileBioField({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(BuildContext context, UserProfileBioProxyWidgetRef ref)
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasUserProfileScope(context));
    final params = _UserProfileParamsInheritedWidget.of(context);
    final value = ref.watch(
      userProfileProvider(params.id).select((s) => s.bio),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(userProfileProvider(params.id).notifier).updateBio(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          UserProfileBioProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}

/// Proxy ref for the bio2 string field with text controller access.
class UserProfileBio2ProxyWidgetRef extends UserProfileProxyWidgetRef {
  UserProfileBio2ProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String? get bio2 => select((s) => s.bio2);
  void updateBio2(String? value) => notifier.updateBio2(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the bio2 field with auto text controller sync.
class UserProfileBio2Field extends ConsumerWidget {
  const UserProfileBio2Field({
    super.key,
    this.controller,
    required this.builder,
  });

  final TextEditingController? controller;
  final Widget Function(BuildContext context, UserProfileBio2ProxyWidgetRef ref)
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasUserProfileScope(context));
    final params = _UserProfileParamsInheritedWidget.of(context);
    final value = ref.watch(
      userProfileProvider(params.id).select((s) => s.bio2),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(userProfileProvider(params.id).notifier).updateBio2(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          UserProfileBio2ProxyWidgetRef(ref, stringFieldRef),
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
// - AgeField: ref.updateAge(value)
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
  const _SecondUserProfileParamsInheritedWidget({
    required this.id,
    required super.child,
  });

  final int id;

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
    return id != oldWidget.id;
  }
}

/// Scope widget to provide family parameters to child widgets.
class SecondUserProfileScope extends StatelessWidget {
  const SecondUserProfileScope({
    super.key,
    required this.id,
    required this.child,
  });

  final int id;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _SecondUserProfileParamsInheritedWidget(id: id, child: child);
  }
}

/// Proxy widget ref providing access to the provider.
class SecondUserProfileProxyWidgetRef {
  SecondUserProfileProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  SecondUserProfile get notifier =>
      _ref.read(secondUserProfileProvider(params!.id).notifier);

  /// Get params from scope (use within SecondUserProfileScope).
  _SecondUserProfileParamsInheritedWidget? get params =>
      _SecondUserProfileParamsInheritedWidget.maybeOf(_ref.context);

  Selected select<Selected>(Selected Function(UserProfileState) selector) =>
      _ref.watch(
        secondUserProfileProvider(
          params!.id,
        ).select((value) => selector(value)),
      );

  BuildContext get context => _ref.context;

  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);
  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);
  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);
}

bool _debugCheckHasSecondUserProfileScope(BuildContext context) {
  assert(() {
    if (_SecondUserProfileParamsInheritedWidget.maybeOf(context) == null) {
      final isInNavigation = ModalRoute.of(context) != null;
      if (!isInNavigation) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No SecondUserProfileScope found'),
          ErrorDescription(
            '${context.widget.runtimeType} widgets require a SecondUserProfileScope widget ancestor '
            'or to be used in a navigation context with proper state management.',
          ),
        ]);
      }
      debugPrint(
        'Widget ${context.widget.runtimeType} used in navigation without direct SecondUserProfileScope',
      );
    }
    return true;
  }());
  return true;
}

/// Widget that rebuilds when any state changes.
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
    assert(_debugCheckHasSecondUserProfileScope(context));
    final params = _SecondUserProfileParamsInheritedWidget.of(context);
    if (onStateChanged != null) {
      ref.listen(secondUserProfileProvider(params.id), (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final state = ref.watch(secondUserProfileProvider(params.id));
    return builder(context, SecondUserProfileProxyWidgetRef(ref), state);
  }
}

/// Widget that rebuilds only when selected value changes.
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
    assert(_debugCheckHasSecondUserProfileScope(context));
    final params = _SecondUserProfileParamsInheritedWidget.of(context);
    final selectedProvider = secondUserProfileProvider(
      params.id,
    ).select((value) => selector(value));
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
    assert(_debugCheckHasSecondUserProfileScope(context));
    final params = _SecondUserProfileParamsInheritedWidget.of(context);
    final value = ref.watch(
      secondUserProfileProvider(params.id).select((s) => s.name),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(secondUserProfileProvider(params.id).notifier).updateName(v),
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
    assert(_debugCheckHasSecondUserProfileScope(context));
    final params = _SecondUserProfileParamsInheritedWidget.of(context);
    final value = ref.watch(
      secondUserProfileProvider(params.id).select((s) => s.email),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) => ref
          .read(secondUserProfileProvider(params.id).notifier)
          .updateEmail(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          SecondUserProfileEmailProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}

class SecondUserProfileAgeProxyWidgetRef
    extends SecondUserProfileProxyWidgetRef {
  SecondUserProfileAgeProxyWidgetRef(super._ref);

  int get age => select((s) => s.age);
  void updateAge(int value) => notifier.updateAge(value);
}

class SecondUserProfileAgeField extends ConsumerWidget {
  const SecondUserProfileAgeField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    SecondUserProfileAgeProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(_debugCheckHasSecondUserProfileScope(context));
    return builder(context, SecondUserProfileAgeProxyWidgetRef(ref));
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
    assert(_debugCheckHasSecondUserProfileScope(context));
    final params = _SecondUserProfileParamsInheritedWidget.of(context);
    final value = ref.watch(
      secondUserProfileProvider(params.id).select((s) => s.bio),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(secondUserProfileProvider(params.id).notifier).updateBio(v),
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
    assert(_debugCheckHasSecondUserProfileScope(context));
    final params = _SecondUserProfileParamsInheritedWidget.of(context);
    final value = ref.watch(
      secondUserProfileProvider(params.id).select((s) => s.bio2),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) =>
          ref.read(secondUserProfileProvider(params.id).notifier).updateBio2(v),
      builder: (context, stringFieldRef) {
        return builder(
          context,
          SecondUserProfileBio2ProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}
