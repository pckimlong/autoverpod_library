// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StateWidgetGenerator
// **************************************************************************

// ignore_for_file: type=lint, unused_element, unused_element_parameter, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unnecessary_import, unused_import

// coverage:ignore-file

import 'package:autoverpod/autoverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'import_resolution_models.dart';

import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart'
    show ProviderListenable, ProviderOrFamily;

import 'package:autoverpod_example/import_resolution_provider.dart';

import 'package:autoverpod_example/import_resolution_types.dart';

// ============================================================================
// AUTOVERPOD - GENERATED CODE
// ============================================================================
//
// Source: importResolutionProvider → ImportResolutionState
//
// Widgets: ImportResolutionWidget, ImportResolutionSelect
// Scope: ImportResolutionScope
//
// Fields:
// - OrgIdField: ref.updateOrgId(value)
// - CustomerIdField: ref.updateCustomerId(value)
// - ChannelField: ref.updateChannel(value)
// - NoteField: ref.textController | ref.updateNote(value)
//

/// Extension that adds field update methods to the provider.
extension ImportResolutionFieldUpdater on ImportResolution {
  /// Update the orgId field.
  void updateOrgId(OrgId newValue) => state = state.copyWith(orgId: newValue);

  /// Update the customerId field.
  void updateCustomerId(CustomerId newValue) =>
      state = state.copyWith(customerId: newValue);

  /// Update the channel field.
  void updateChannel(PaymentChannel newValue) =>
      state = state.copyWith(channel: newValue);

  /// Update the note field.
  void updateNote(String newValue) => state = state.copyWith(note: newValue);
}

class _ImportResolutionParamsInheritedWidget extends InheritedWidget {
  const _ImportResolutionParamsInheritedWidget({
    this.skipLoadingOnRefresh = true,
    this.skipLoadingOnReload = true,
    this.skipError = false,
    required super.child,
  });

  final bool skipLoadingOnRefresh;
  final bool skipLoadingOnReload;
  final bool skipError;

  static _ImportResolutionParamsInheritedWidget? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
          _ImportResolutionParamsInheritedWidget
        >();
  }

  static _ImportResolutionParamsInheritedWidget of(BuildContext context) {
    return maybeOf(context)!;
  }

  @override
  bool updateShouldNotify(
    covariant _ImportResolutionParamsInheritedWidget oldWidget,
  ) {
    return skipLoadingOnRefresh != oldWidget.skipLoadingOnRefresh ||
        skipLoadingOnReload != oldWidget.skipLoadingOnReload ||
        skipError != oldWidget.skipError;
  }
}

/// Scope widget placeholder for future family parameters.
/// Wrap your widget tree with this to future-proof for family provider migration.
class ImportResolutionScope extends StatelessWidget {
  const ImportResolutionScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _ImportResolutionParamsInheritedWidget(child: child);
  }
}

/// Proxy widget ref providing access to the provider.
class ImportResolutionProxyWidgetRef {
  ImportResolutionProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  ImportResolution get notifier => _ref.read(importResolutionProvider.notifier);

  /// Get params from scope (use within ImportResolutionScope).
  _ImportResolutionParamsInheritedWidget? get params =>
      _ImportResolutionParamsInheritedWidget.maybeOf(_ref.context);

  Selected select<Selected>(
    Selected Function(ImportResolutionState) selector,
  ) => _ref.watch(importResolutionProvider.select((value) => selector(value)));

  WidgetRef get widgetRef => _ref;

  BuildContext get context => _ref.context;

  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);
  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);
  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);
}

/// Widget that rebuilds when any state changes.
///
/// **Usage:**
/// ```dart
/// ImportResolutionWidget(
///   builder: (context, ref, state) {
///     return Text(state.toString());
///   },
/// )
/// ```
class ImportResolutionWidget extends ConsumerWidget {
  const ImportResolutionWidget({
    super.key,
    required this.builder,
    this.onStateChanged,
  });

  final Widget Function(
    BuildContext context,
    ImportResolutionProxyWidgetRef ref,
    ImportResolutionState state,
  )
  builder;
  final void Function(
    ImportResolutionState? previous,
    ImportResolutionState next,
  )?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (onStateChanged != null) {
      ref.listen(importResolutionProvider, (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final state = ref.watch(importResolutionProvider);
    return builder(context, ImportResolutionProxyWidgetRef(ref), state);
  }
}

/// Widget that rebuilds only when selected value changes.
///
/// **Usage:**
/// ```dart
/// ImportResolutionSelect<String>(
///   selector: (state) => state.orgId,
///   builder: (context, ref, selectedValue) {
///     return Text(selectedValue);
///   },
/// )
/// ```
class ImportResolutionSelect<Selected> extends ConsumerWidget {
  const ImportResolutionSelect({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(ImportResolutionState state) selector;
  final Widget Function(
    BuildContext context,
    ImportResolutionProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProvider = importResolutionProvider.select(
      (value) => selector(value),
    );
    if (onStateChanged != null) {
      ref.listen(selectedProvider, (prev, next) {
        if (prev != next) onStateChanged!(prev, next);
      });
    }
    final selected = ref.watch(selectedProvider);
    return builder(context, ImportResolutionProxyWidgetRef(ref), selected);
  }
}

class ImportResolutionOrgIdProxyWidgetRef
    extends ImportResolutionProxyWidgetRef {
  ImportResolutionOrgIdProxyWidgetRef(super._ref);

  OrgId get orgId => select((s) => s.orgId);
  void updateOrgId(OrgId value) => notifier.updateOrgId(value);
}

class ImportResolutionOrgIdField extends ConsumerWidget {
  const ImportResolutionOrgIdField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    ImportResolutionOrgIdProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return builder(context, ImportResolutionOrgIdProxyWidgetRef(ref));
  }
}

class ImportResolutionCustomerIdProxyWidgetRef
    extends ImportResolutionProxyWidgetRef {
  ImportResolutionCustomerIdProxyWidgetRef(super._ref);

  CustomerId get customerId => select((s) => s.customerId);
  void updateCustomerId(CustomerId value) => notifier.updateCustomerId(value);
}

class ImportResolutionCustomerIdField extends ConsumerWidget {
  const ImportResolutionCustomerIdField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    ImportResolutionCustomerIdProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return builder(context, ImportResolutionCustomerIdProxyWidgetRef(ref));
  }
}

class ImportResolutionChannelProxyWidgetRef
    extends ImportResolutionProxyWidgetRef {
  ImportResolutionChannelProxyWidgetRef(super._ref);

  PaymentChannel get channel => select((s) => s.channel);
  void updateChannel(PaymentChannel value) => notifier.updateChannel(value);
}

class ImportResolutionChannelField extends ConsumerWidget {
  const ImportResolutionChannelField({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    ImportResolutionChannelProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return builder(context, ImportResolutionChannelProxyWidgetRef(ref));
  }
}

/// Proxy ref for the note string field with text controller access.
class ImportResolutionNoteProxyWidgetRef
    extends ImportResolutionProxyWidgetRef {
  ImportResolutionNoteProxyWidgetRef(super._ref, this._stringFieldRef);

  final StringFieldRef _stringFieldRef;

  String get note => select((s) => s.note);
  void updateNote(String value) => notifier.updateNote(value);
  TextEditingController get textController => _stringFieldRef.controller;
}

/// Widget for the note field with auto text controller sync.
///
/// **Usage:**
/// ```dart
/// ImportResolutionNoteField(
///   builder: (context, ref) {
///     return TextField(controller: ref.textController);
///   },
/// )
/// ```
class ImportResolutionNoteField extends ConsumerWidget {
  const ImportResolutionNoteField({
    super.key,
    this.controller,
    this.debounceDuration,
    required this.builder,
  });

  final TextEditingController? controller;
  final Duration? debounceDuration;
  final Widget Function(
    BuildContext context,
    ImportResolutionNoteProxyWidgetRef ref,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(importResolutionProvider.select((s) => s.note));

    return StringField(
      value: value,
      controller: controller,
      debounceDuration: debounceDuration,
      onChanged: (v) {
        if (v != null)
          ref.read(importResolutionProvider.notifier).updateNote(v);
      },
      builder: (context, stringFieldRef) {
        return builder(
          context,
          ImportResolutionNoteProxyWidgetRef(ref, stringFieldRef),
        );
      },
    );
  }
}
