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
import 'package:autoverpod_example/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart'
    show ProviderListenable, ProviderOrFamily;
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    return context.dependOnInheritedWidgetOfExactType<_UserProfileParamsInheritedWidget>();
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

  UserProfile get notifier => _ref.read(userProfileProvider(params!.id).notifier);

  /// Get params from scope (use within UserProfileScope).
  _UserProfileParamsInheritedWidget? get params =>
      _UserProfileParamsInheritedWidget.maybeOf(_ref.context);

  Selected select<Selected>(Selected Function(UserProfileState) selector) => _ref.watch(
        userProfileProvider(params!.id).select((value) => selector(value)),
      );

  BuildContext get context => _ref.context;

  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);
  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);
  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);
}

/// Widget that rebuilds when any state changes.
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
  ) builder;
  final void Function(UserProfileState? previous, UserProfileState next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = (id: id ?? _UserProfileParamsInheritedWidget.of(context).id);
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
    this.id,
    required this.selector,
    required this.builder,
  });

  final int? id;
  final Selected Function(UserProfileState state) selector;
  final Widget Function(
    BuildContext context,
    UserProfileProxyWidgetRef ref,
    Selected value,
  ) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = (id: id ?? _UserProfileParamsInheritedWidget.of(context).id);
    final selected = ref.watch(
      userProfileProvider(params.id).select((value) => selector(value)),
    );
    return builder(context, UserProfileProxyWidgetRef(ref), selected);
  }
}

/// Widget for the name field with auto text controller sync.
class UserProfileNameField extends ConsumerWidget {
  const UserProfileNameField({
    super.key,
    this.id,
    this.controller,
    required this.builder,
  });

  final int? id;
  final TextEditingController? controller;
  final Widget Function(BuildContext context, StringFieldRef ref) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = (id: id ?? _UserProfileParamsInheritedWidget.of(context).id);
    final value = ref.watch(
      userProfileProvider(params.id).select((s) => s.name),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) => ref.read(userProfileProvider(params.id).notifier).updateName(v),
      builder: builder,
    );
  }
}

/// Widget for the email field with auto text controller sync.
class UserProfileEmailField extends ConsumerWidget {
  const UserProfileEmailField({
    super.key,
    this.id,
    this.controller,
    required this.builder,
  });

  final int? id;
  final TextEditingController? controller;
  final Widget Function(BuildContext context, StringFieldRef ref) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = (id: id ?? _UserProfileParamsInheritedWidget.of(context).id);
    final value = ref.watch(
      userProfileProvider(params.id).select((s) => s.email),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) => ref.read(userProfileProvider(params.id).notifier).updateEmail(v),
      builder: builder,
    );
  }
}

class UserProfileAgeProxyWidgetRef extends UserProfileProxyWidgetRef {
  UserProfileAgeProxyWidgetRef(super._ref);

  int get age => select((s) => s.age);
  void updateAge(int value) => notifier.updateAge(value);
}

class UserProfileAgeField extends ConsumerWidget {
  const UserProfileAgeField({super.key, this.id, required this.builder});

  final int? id;
  final Widget Function(BuildContext context, UserProfileAgeProxyWidgetRef ref) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return builder(context, UserProfileAgeProxyWidgetRef(ref));
  }
}

/// Widget for the bio field with auto text controller sync.
class UserProfileBioField extends ConsumerWidget {
  const UserProfileBioField({
    super.key,
    this.id,
    this.controller,
    required this.builder,
  });

  final int? id;
  final TextEditingController? controller;
  final Widget Function(BuildContext context, StringFieldRef ref) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = (id: id ?? _UserProfileParamsInheritedWidget.of(context).id);
    final value = ref.watch(
      userProfileProvider(params.id).select((s) => s.bio),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) => ref.read(userProfileProvider(params.id).notifier).updateBio(v),
      builder: builder,
    );
  }
}

/// Widget for the bio2 field with auto text controller sync.
class UserProfileBio2Field extends ConsumerWidget {
  const UserProfileBio2Field({
    super.key,
    this.id,
    this.controller,
    required this.builder,
  });

  final int? id;
  final TextEditingController? controller;
  final Widget Function(BuildContext context, StringFieldRef ref) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = (id: id ?? _UserProfileParamsInheritedWidget.of(context).id);
    final value = ref.watch(
      userProfileProvider(params.id).select((s) => s.bio2),
    );

    return StringField(
      value: value,
      controller: controller,
      onChanged: (v) => ref.read(userProfileProvider(params.id).notifier).updateBio2(v),
      builder: builder,
    );
  }
}
