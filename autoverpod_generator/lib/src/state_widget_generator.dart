import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:autoverpod_annotation/autoverpod_annotation.dart';
import 'package:lean_builder/builder.dart';
import 'package:lean_builder/element.dart';
import 'package:recase/recase.dart';

import 'models/field_definition.dart';
import 'models/provider_definition.dart';

/// Main generator for @stateWidget annotation using lean_builder
@LeanGenerator({'.widget.dart'})
class StateWidgetGenerator extends GeneratorForAnnotatedClass<StateWidget> {
  @override
  FutureOr<Iterable<String>> generateForClass(
    BuildStep buildStep,
    ClassElement element,
    ElementAnnotation annotation,
  ) {
    final provider = ProviderDefinition.parse(element);

    final pieces = <String>[
      '// GENERATED CODE - DO NOT MODIFY BY HAND',
      '// dart format width=80',
      '',
      '// **************************************************************************',
      '// StateWidgetGenerator',
      '// **************************************************************************',
      '',
      '// ignore_for_file: type=lint, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unnecessary_import, unused_import',
      '// coverage:ignore-file',
      '',
      // Collect imports
      ..._collectLibraryImports(element),
      ..._getDefaultImports(),
      _getSourceFileImport(element),
      ..._collectFieldTypeImports(provider),
      '',
      // Generate widgets
      _generateHeaderComment(provider),
      '',
      _generateFieldUpdaterExtension(provider),
    ];

    // Scope widget (InheritedWidget for params)
    // Always generate scope widget even for non-family providers to future-proof
    // when the provider is later changed to a family provider
    pieces.add(_generateScopeWidget(provider));

    // Base proxy widget ref
    pieces.add(_generateProxyWidgetRef(provider));

    // Debug check helper for family scope usage
    if (provider.hasFamily) {
      pieces.add(_generateDebugCheckHasScope(provider));
    }

    // State widget
    pieces.add(_generateStateWidget(provider));

    // Select widget
    pieces.add(_generateSelectWidget(provider));

    // Field widgets
    for (final field in provider.fields) {
      pieces.add(_generateFieldWidget(provider, field));
    }

    return pieces;
  }

  /// Collect imports from the source file's AST
  Iterable<String> _collectLibraryImports(ClassElement element) sync* {
    final unit = element.library.compilationUnit;
    final shortUrl = element.librarySrc.shortUri;
    final baseName = shortUrl.pathSegments.last.split('.').first;
    final generatedSuffix = '$baseName.widget.dart';

    for (final directive in unit.directives.whereType<ImportDirective>()) {
      final uri = directive.uri.stringValue;
      if (uri == null) continue;
      // Skip the generated file itself
      if (uri.endsWith(generatedSuffix)) continue;
      // Skip generated files
      if (uri.endsWith('.g.dart') || uri.endsWith('.freezed.dart')) continue;
      yield directive.toSource();
    }
  }

  /// Get default imports required by generated widgets
  Iterable<String> _getDefaultImports() sync* {
    yield "import 'package:flutter/widgets.dart';";
    yield "import 'package:flutter/material.dart';";
    yield "import 'package:flutter_riverpod/flutter_riverpod.dart';";
    yield "import 'package:riverpod_annotation/riverpod_annotation.dart' show ProviderListenable, ProviderOrFamily;";
    yield "import 'package:autoverpod/autoverpod.dart';";
  }

  /// Import the source file itself
  String _getSourceFileImport(ClassElement element) {
    final shortUrl = element.librarySrc.shortUri;
    return "import '$shortUrl';";
  }

  /// Collect imports from field types
  Iterable<String> _collectFieldTypeImports(ProviderDefinition provider) sync* {
    final collected = <String>{};

    for (final field in provider.fields) {
      if (field.importPath != null) {
        final uri = field.importPath!;
        // Skip dart core and already collected
        if (uri.startsWith('dart:') ||
            uri.contains('/sky_engine/') ||
            collected.contains(uri)) {
          continue;
        }
        collected.add(uri);
        yield "import '$uri';";
      }
    }

    for (final param in provider.familyParameters) {
      if (param.importPath != null) {
        final uri = param.importPath!;
        if (uri.startsWith('dart:') ||
            uri.contains('/sky_engine/') ||
            collected.contains(uri)) {
          continue;
        }
        collected.add(uri);
        yield "import '$uri';";
      }
    }
  }

  String _generateHeaderComment(ProviderDefinition provider) {
    final buffer = StringBuffer();
    buffer.writeln(
      '// ============================================================================',
    );
    buffer.writeln('// AUTOVERPOD - GENERATED CODE');
    buffer.writeln(
      '// ============================================================================',
    );
    buffer.writeln('//');
    buffer
        .writeln('// Source: ${provider.providerName} → ${provider.baseType}');
    buffer.writeln('//');
    buffer.writeln(
        '// Widgets: ${provider.baseName}Widget, ${provider.baseName}Select');
    buffer.writeln('// Scope: ${provider.baseName}Scope');
    buffer.writeln('//');
    buffer.writeln('// Fields:');
    for (final field in provider.fields) {
      final hasController = field.isTextField ? 'ref.textController | ' : '';
      buffer.writeln(
        '// - ${field.name.pascalCase}Field: ${hasController}ref.update${field.name.pascalCase}(value)',
      );
    }
    buffer.writeln('//');
    return buffer.toString();
  }

  String _generateFieldUpdaterExtension(ProviderDefinition provider) {
    final buffer = StringBuffer();
    buffer.writeln(
        '/// Extension that adds field update methods to the provider.');
    buffer.writeln(
        'extension ${provider.baseName}FieldUpdater on ${provider.baseName} {');

    for (final field in provider.fields) {
      final updateStatement = provider.isAsyncValue
          ? 'state.whenData((s) => s.copyWith(${field.name}: newValue))'
          : 'state.copyWith(${field.name}: newValue)';

      buffer.writeln('  /// Update the ${field.name} field.');
      buffer.writeln(
          '  void update${field.name.pascalCase}(${field.type} newValue) =>');
      buffer.writeln('      state = $updateStatement;');
      buffer.writeln();
    }

    buffer.writeln('}');
    return buffer.toString();
  }

  String _generateScopeWidget(ProviderDefinition provider) {
    final buffer = StringBuffer();

    // InheritedWidget for family params (or empty placeholder for non-family)
    buffer.writeln(
        'class _${provider.baseName}ParamsInheritedWidget extends InheritedWidget {');
    buffer.writeln('  const _${provider.baseName}ParamsInheritedWidget({');
    for (final param in provider.familyParameters) {
      buffer.writeln('    required this.${param.name},');
    }
    buffer.writeln('    required super.child,');
    buffer.writeln('  });');
    buffer.writeln();
    for (final param in provider.familyParameters) {
      buffer.writeln('  final ${param.type} ${param.name};');
    }
    buffer.writeln();
    buffer.writeln(
      '  static _${provider.baseName}ParamsInheritedWidget? maybeOf(BuildContext context) {',
    );
    buffer.writeln(
      '    return context.dependOnInheritedWidgetOfExactType<_${provider.baseName}ParamsInheritedWidget>();',
    );
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln(
      '  static _${provider.baseName}ParamsInheritedWidget of(BuildContext context) {',
    );
    buffer.writeln('    return maybeOf(context)!;');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln(
      '  bool updateShouldNotify(covariant _${provider.baseName}ParamsInheritedWidget oldWidget) {',
    );
    if (provider.hasFamily) {
      final conditions = provider.familyParameters
          .map((p) => '${p.name} != oldWidget.${p.name}')
          .join(' || ');
      buffer.writeln('    return $conditions;');
    } else {
      buffer.writeln('    return false;');
    }
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    // Scope widget
    if (provider.isAsyncValue) {
      buffer.writeln(
        '/// Scope widget to provide family parameters and handle async state.',
      );
      buffer.writeln(
          'class ${provider.baseName}Scope extends ConsumerWidget {');
      buffer.writeln('  const ${provider.baseName}Scope({');
      buffer.writeln('    super.key,');
      for (final param in provider.familyParameters) {
        buffer.writeln('    required this.${param.name},');
      }
      buffer.writeln('    required this.child,');
      buffer.writeln('    required this.loading,');
      buffer.writeln('    required this.error,');
      buffer.writeln('    this.builder,');
      buffer.writeln('    this.onStateChanged,');
      buffer.writeln(
        '  }) : assert(builder != null || (loading != null && error != null));',
      );
      buffer.writeln();
      for (final param in provider.familyParameters) {
        buffer.writeln('  final ${param.type} ${param.name};');
      }
      buffer.writeln('  final Widget child;');
      buffer.writeln('  final Widget? loading;');
      buffer.writeln(
          '  final Widget Function(Object error, StackTrace stackTrace)? error;');
      buffer.writeln(
        '  final Widget Function(BuildContext context, AsyncValue<${provider.baseType}> asyncValue, Widget child)? builder;',
      );
      buffer.writeln(
        '  final void Function(AsyncValue<${provider.baseType}>? previous, AsyncValue<${provider.baseType}> next)? onStateChanged;',
      );
      buffer.writeln();
      buffer.writeln('  @override');
      buffer.writeln('  Widget build(BuildContext context, WidgetRef ref) {');
      if (provider.hasFamily) {
        buffer.writeln('    final params = (');
        for (final param in provider.familyParameters) {
          buffer.writeln('      ${param.name}: ${param.name},');
        }
        buffer.writeln('    );');
      }
      buffer.writeln('    if (onStateChanged != null) {');
      buffer.writeln(
        '      ref.listen(${provider.providerNameWithFamily(prefix: 'params')}, (prev, next) {',
      );
      buffer.writeln('        if (prev != next) onStateChanged!(prev, next);');
      buffer.writeln('      });');
      buffer.writeln('    }');
      buffer.writeln(
        '    final asyncValue = ref.watch(${provider.providerNameWithFamily(prefix: 'params')});',
      );
      buffer.writeln(
        '    final scopedChild = _${provider.baseName}ParamsInheritedWidget(',
      );
      for (final param in provider.familyParameters) {
        buffer.writeln('          ${param.name}: ${param.name},');
      }
      buffer.writeln('          child: child,');
      buffer.writeln('        );');
      buffer.writeln('    if (builder != null) {');
      buffer.writeln(
          '      return builder!(context, asyncValue, scopedChild);');
      buffer.writeln('    }');
      buffer.writeln('    return asyncValue.when(');
      buffer.writeln('      data: (_) => scopedChild,');
      buffer.writeln(
        '      loading: () => loading ?? const SizedBox.shrink(),',
      );
      buffer.writeln(
        '      error: (err, stack) => error?.call(err, stack) ?? const SizedBox.shrink(),',
      );
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln('}');
    } else {
      if (provider.hasFamily) {
        buffer.writeln(
            '/// Scope widget to provide family parameters to child widgets.');
      } else {
        buffer.writeln(
            '/// Scope widget placeholder for future family parameters.');
        buffer.writeln(
          '/// Wrap your widget tree with this to future-proof for family provider migration.',
        );
      }
      buffer.writeln(
          'class ${provider.baseName}Scope extends StatelessWidget {');
      buffer.writeln('  const ${provider.baseName}Scope({');
      buffer.writeln('    super.key,');
      for (final param in provider.familyParameters) {
        buffer.writeln('    required this.${param.name},');
      }
      buffer.writeln('    required this.child,');
      buffer.writeln('  });');
      buffer.writeln();
      for (final param in provider.familyParameters) {
        buffer.writeln('  final ${param.type} ${param.name};');
      }
      buffer.writeln('  final Widget child;');
      buffer.writeln();
      buffer.writeln('  @override');
      buffer.writeln('  Widget build(BuildContext context) {');
      buffer.writeln('    return _${provider.baseName}ParamsInheritedWidget(');
      for (final param in provider.familyParameters) {
        buffer.writeln('      ${param.name}: ${param.name},');
      }
      buffer.writeln('      child: child,');
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln('}');
    }

    return buffer.toString();
  }

  String _generateProxyWidgetRef(ProviderDefinition provider) {
    final buffer = StringBuffer();

    buffer.writeln('/// Proxy widget ref providing access to the provider.');
    buffer.writeln('class ${provider.baseName}ProxyWidgetRef {');
    buffer.writeln('  ${provider.baseName}ProxyWidgetRef(this._ref);');
    buffer.writeln();
    buffer.writeln('  final WidgetRef _ref;');
    buffer.writeln();

    // Generate notifier getter - use params! for family or direct access for non-family
    if (provider.hasFamily) {
      buffer.writeln(
        '  ${provider.baseName} get notifier => _ref.read(${provider.providerNameWithFamily(prefix: 'params!')}.notifier);',
      );
    } else {
      buffer.writeln(
        '  ${provider.baseName} get notifier => _ref.read(${provider.providerName}.notifier);',
      );
    }
    buffer.writeln();

    // Always provide params getter for future-proofing
    buffer.writeln(
        '  /// Get params from scope (use within ${provider.baseName}Scope).');
    buffer
        .writeln('  _${provider.baseName}ParamsInheritedWidget? get params =>');
    buffer.writeln(
        '      _${provider.baseName}ParamsInheritedWidget.maybeOf(_ref.context);');
    buffer.writeln();

    // Generate select method - use params! for family or direct access for non-family
    buffer.writeln(
      '  Selected select<Selected>(Selected Function(${provider.baseType}) selector) =>',
    );
    if (provider.hasFamily) {
      buffer.writeln(
        '      _ref.watch(${provider.providerNameWithFamily(prefix: 'params!')}.select((value) => selector(value${provider.isAsyncValue ? '.requireValue' : ''})));',
      );
    } else {
      buffer.writeln(
        '      _ref.watch(${provider.providerName}.select((value) => selector(value${provider.isAsyncValue ? '.requireValue' : ''})));',
      );
    }
    buffer.writeln();
    buffer.writeln('  BuildContext get context => _ref.context;');
    buffer.writeln();
    buffer.writeln(
        '  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);');
    buffer.writeln(
        '  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);');
    buffer.writeln(
        '  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);');
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateDebugCheckHasScope(ProviderDefinition provider) {
    final buffer = StringBuffer();
    buffer.writeln(
        'bool _debugCheckHas${provider.baseName}Scope(BuildContext context) {');
    buffer.writeln('  assert(() {');
    buffer.writeln(
        '    if (_${provider.baseName}ParamsInheritedWidget.maybeOf(context) == null) {');
    buffer.writeln(
        '      final isInNavigation = ModalRoute.of(context) != null;');
    buffer.writeln('      if (!isInNavigation) {');
    buffer.writeln('        throw FlutterError.fromParts(<DiagnosticsNode>[');
    buffer.writeln(
        "          ErrorSummary('No ${provider.baseName}Scope found'),");
    buffer.writeln('          ErrorDescription(');
    buffer.writeln(
        "            '\${context.widget.runtimeType} widgets require a ${provider.baseName}Scope widget ancestor '");
    buffer.writeln(
        "            'or to be used in a navigation context with proper state management.',");
    buffer.writeln('          ),');
    buffer.writeln('        ]);');
    buffer.writeln('      }');
    buffer.writeln(
        "      debugPrint('Widget \${context.widget.runtimeType} used in navigation without direct ${provider.baseName}Scope');");
    buffer.writeln('    }');
    buffer.writeln('    return true;');
    buffer.writeln('  }());');
    buffer.writeln('  return true;');
    buffer.writeln('}');
    return buffer.toString();
  }

  String _generateStateWidget(ProviderDefinition provider) {
    final buffer = StringBuffer();
    final stateType = provider.isAsyncValue
        ? 'AsyncValue<${provider.baseType}>'
        : provider.baseType;

    buffer.writeln('/// Widget that rebuilds when any state changes.');
    buffer.writeln('class ${provider.baseName}Widget extends ConsumerWidget {');
    buffer.writeln('  const ${provider.baseName}Widget({');
    buffer.writeln('    super.key,');
    buffer.writeln('    required this.builder,');
    buffer.writeln('    this.onStateChanged,');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln(
      '  final Widget Function(BuildContext context, ${provider.baseName}ProxyWidgetRef ref, $stateType state) builder;',
    );
    buffer.writeln(
        '  final void Function($stateType? previous, $stateType next)? onStateChanged;');
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context, WidgetRef ref) {');

    if (provider.hasFamily) {
      buffer.writeln(
          '    assert(_debugCheckHas${provider.baseName}Scope(context));');
      buffer.writeln(
          '    final params = _${provider.baseName}ParamsInheritedWidget.of(context);');
    }

    buffer.writeln('    if (onStateChanged != null) {');
    buffer.writeln(
      '      ref.listen(${provider.providerNameWithFamily(prefix: 'params')}, (prev, next) {',
    );
    buffer.writeln('        if (prev != next) onStateChanged!(prev, next);');
    buffer.writeln('      });');
    buffer.writeln('    }');
    buffer.writeln(
      '    final state = ref.watch(${provider.providerNameWithFamily(prefix: 'params')});',
    );
    buffer.writeln(
        '    return builder(context, ${provider.baseName}ProxyWidgetRef(ref), state);');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateSelectWidget(ProviderDefinition provider) {
    final buffer = StringBuffer();

    buffer
        .writeln('/// Widget that rebuilds only when selected value changes.');
    buffer.writeln(
        'class ${provider.baseName}Select<Selected> extends ConsumerWidget {');
    buffer.writeln('  const ${provider.baseName}Select({');
    buffer.writeln('    super.key,');
    buffer.writeln('    required this.selector,');
    buffer.writeln('    required this.builder,');
    buffer.writeln('    this.onStateChanged,');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln(
        '  final Selected Function(${provider.baseType} state) selector;');
    buffer.writeln(
      '  final Widget Function(BuildContext context, ${provider.baseName}ProxyWidgetRef ref, Selected value) builder;',
    );
    buffer.writeln(
        '  final void Function(Selected? previous, Selected next)? onStateChanged;');
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context, WidgetRef ref) {');

    if (provider.hasFamily) {
      buffer.writeln(
          '    assert(_debugCheckHas${provider.baseName}Scope(context));');
      buffer.writeln(
          '    final params = _${provider.baseName}ParamsInheritedWidget.of(context);');
    }

    final valueSelector =
        provider.isAsyncValue ? 'value.requireValue' : 'value';
    buffer.writeln(
      '    final selectedProvider = ${provider.providerNameWithFamily(prefix: 'params')}.select((value) => selector($valueSelector));',
    );
    buffer.writeln('    if (onStateChanged != null) {');
    buffer.writeln('      ref.listen(selectedProvider, (prev, next) {');
    buffer.writeln('        if (prev != next) onStateChanged!(prev, next);');
    buffer.writeln('      });');
    buffer.writeln('    }');
    buffer.writeln('    final selected = ref.watch(selectedProvider);');
    buffer.writeln(
      '    return builder(context, ${provider.baseName}ProxyWidgetRef(ref), selected);',
    );
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateFieldWidget(
      ProviderDefinition provider, FieldDefinition field) {
    final buffer = StringBuffer();
    final widgetName = '${provider.baseName}${field.name.pascalCase}Field';

    // For String fields, use the simplified StringField helper
    if (field.isTextField) {
      return _generateStringFieldWidget(provider, field, widgetName);
    }

    // For non-String fields, generate a simple ConsumerWidget
    final proxyName =
        '${provider.baseName}${field.name.pascalCase}ProxyWidgetRef';

    // Field-specific proxy
    buffer.writeln(
        'class $proxyName extends ${provider.baseName}ProxyWidgetRef {');
    buffer.writeln('  $proxyName(super._ref);');
    buffer.writeln();
    buffer.writeln(
        '  ${field.type} get ${field.name} => select((s) => s.${field.name});');
    buffer.writeln(
      '  void update${field.name.pascalCase}(${field.type} value) => notifier.update${field.name.pascalCase}(value);',
    );
    buffer.writeln('}');
    buffer.writeln();

    // Simple ConsumerWidget for non-String fields
    buffer.writeln('class $widgetName extends ConsumerWidget {');
    buffer.writeln('  const $widgetName({');
    buffer.writeln('    super.key,');
    buffer.writeln('    required this.builder,');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln(
        '  final Widget Function(BuildContext context, $proxyName ref) builder;');
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context, WidgetRef ref) {');
    if (provider.hasFamily) {
      buffer.writeln(
          '    assert(_debugCheckHas${provider.baseName}Scope(context));');
    }

    // Note: We don't need params here because the ProxyWidgetRef handles it internally
    // The ProxyWidgetRef uses select() which already accesses the correct provider

    buffer.writeln('    return builder(context, $proxyName(ref));');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  /// Generate a String field widget using the StringField helper.
  /// This generates a ProxyWidgetRef for string fields with textController access.
  String _generateStringFieldWidget(
    ProviderDefinition provider,
    FieldDefinition field,
    String widgetName,
  ) {
    final buffer = StringBuffer();
    final valueAccess = provider.isAsyncValue ? '.requireValue' : '';
    final proxyName =
        '${provider.baseName}${field.name.pascalCase}ProxyWidgetRef';

    // Field-specific proxy for string fields (with textController)
    buffer.writeln(
        '/// Proxy ref for the ${field.name} string field with text controller access.');
    buffer.writeln(
        'class $proxyName extends ${provider.baseName}ProxyWidgetRef {');
    buffer.writeln('  $proxyName(super._ref, this._stringFieldRef);');
    buffer.writeln();
    buffer.writeln('  final StringFieldRef _stringFieldRef;');
    buffer.writeln();
    buffer.writeln(
        '  ${field.type} get ${field.name} => select((s) => s.${field.name});');
    buffer.writeln(
      '  void update${field.name.pascalCase}(${field.type} value) => notifier.update${field.name.pascalCase}(value);',
    );
    buffer.writeln(
        '  TextEditingController get textController => _stringFieldRef.controller;');
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln(
        '/// Widget for the ${field.name} field with auto text controller sync.');
    buffer.writeln('class $widgetName extends ConsumerWidget {');
    buffer.writeln('  const $widgetName({');
    buffer.writeln('    super.key,');
    buffer.writeln('    this.controller,');
    buffer.writeln('    required this.builder,');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln('  final TextEditingController? controller;');
    buffer.writeln(
        '  final Widget Function(BuildContext context, $proxyName ref) builder;');
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context, WidgetRef ref) {');

    if (provider.hasFamily) {
      buffer.writeln(
          '    assert(_debugCheckHas${provider.baseName}Scope(context));');
      buffer.writeln(
          '    final params = _${provider.baseName}ParamsInheritedWidget.of(context);');
    }

    buffer.writeln('    final value = ref.watch(');
    buffer.writeln(
      '      ${provider.providerNameWithFamily(prefix: 'params')}.select((s) => s$valueAccess.${field.name}),',
    );
    buffer.writeln('    );');
    buffer.writeln();
    buffer.writeln('    return StringField(');
    buffer.writeln('      value: value,');
    buffer.writeln('      controller: controller,');
    buffer.writeln(
      '      onChanged: (v) => ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier).update${field.name.pascalCase}(v),',
    );
    buffer.writeln('      builder: (context, stringFieldRef) {');
    buffer.writeln(
        '        return builder(context, $proxyName(ref, stringFieldRef));');
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }
}
