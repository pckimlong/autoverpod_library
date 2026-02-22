import 'dart:async';
import 'dart:collection';
import 'dart:io';

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
  // Instance caches used during a single generation run.
  final Map<String, String?> _typeImportCache = <String, String?>{};
  final Map<String, Map<String, String>> _localTypeIndexCache =
      <String, Map<String, String>>{};

  @override
  FutureOr<Iterable<String>> generateForClass(
    BuildStep buildStep,
    ClassElement element,
    ElementAnnotation annotation,
  ) {
    _typeImportCache.clear();
    _localTypeIndexCache.clear();

    final provider = ProviderDefinition.parse(element);
    final sourceImportUris = _collectSourceImportUris(element);
    final directlyAvailableSourceImports =
        _collectDirectlyAvailableSourceImports(element);

    final pieces = <String>[
      '// ignore_for_file: type=lint, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unnecessary_import, unused_import',
      '// coverage:ignore-file',
      '',
      // Collect imports
      ..._collectLibraryImports(element),
      ..._getDefaultImports(),
      _getSourceFileImport(element),
      ..._collectFieldTypeImports(
        provider,
        element,
        sourceImportUris,
        directlyAvailableSourceImports,
      ),
      '',
      // Generate widgets
      _generateHeaderComment(provider),
    ];

    if (provider.hasCopyWith) {
      pieces.add('');
      pieces.add(_generateFieldUpdaterExtension(provider));
    }

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

    // Params builder widget (only for family providers)
    if (provider.hasFamily) {
      pieces.add(_generateParamsBuilder(provider));
    }

    // Field widgets
    for (final field in provider.fields) {
      pieces.add(_generateFieldWidget(provider, field));
    }

    return pieces;
  }

  List<String> _collectSourceImportUris(ClassElement element) {
    final unit = element.library.compilationUnit;
    final shortUrl = element.librarySrc.shortUri;
    final baseName = shortUrl.pathSegments.last.split('.').first;
    final generatedSuffix = '$baseName.widget.dart';
    final uris = <String>[];

    for (final directive in unit.directives.whereType<ImportDirective>()) {
      final uri = directive.uri.stringValue;
      if (uri == null) continue;
      if (uri.endsWith(generatedSuffix)) continue;
      if (uri.endsWith('.g.dart') || uri.endsWith('.freezed.dart')) continue;
      uris.add(uri);
    }

    return uris;
  }

  Set<String> _collectDirectlyAvailableSourceImports(ClassElement element) {
    final unit = element.library.compilationUnit;
    final shortUrl = element.librarySrc.shortUri;
    final baseName = shortUrl.pathSegments.last.split('.').first;
    final generatedSuffix = '$baseName.widget.dart';
    final uris = <String>{};

    for (final directive in unit.directives.whereType<ImportDirective>()) {
      final uri = directive.uri.stringValue;
      if (uri == null) continue;
      if (uri.endsWith(generatedSuffix)) continue;
      if (uri.endsWith('.g.dart') || uri.endsWith('.freezed.dart')) continue;

      final hasPrefix = directive.prefix != null;
      final hasCombinators = directive.combinators.isNotEmpty;
      if (!hasPrefix && !hasCombinators) {
        uris.add(uri);
      }
    }

    return uris;
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
  Iterable<String> _collectFieldTypeImports(
    ProviderDefinition provider,
    ClassElement element,
    List<String> sourceImportUris,
    Set<String> directlyAvailableSourceImports,
  ) sync* {
    final collected = <String>{};
    final packageName = _packageNameFor(element.librarySrc.shortUri.toString());
    final sourceFilePath = packageName != null
        ? _packageUriToFilePath(
            element.librarySrc.shortUri.toString(),
            packageName,
          )
        : null;
    final knownFiles = <String>{};
    if (sourceFilePath != null && packageName != null) {
      for (final uri in directlyAvailableSourceImports) {
        final filePath = _resolveImportToFilePath(
          uri: uri,
          currentFilePath: sourceFilePath,
          packageName: packageName,
        );
        if (filePath != null) {
          knownFiles.add(filePath);
        }
      }
    }

    for (final field in provider.fields) {
      if (field.importPath != null) {
        final uri = field.importPath!;
        if (uri.startsWith('dart:') ||
            uri.contains('/sky_engine/') ||
            collected.contains(uri) ||
            directlyAvailableSourceImports.contains(uri)) {
          continue;
        }
        if (sourceFilePath != null && packageName != null) {
          final filePath = _resolveImportToFilePath(
            uri: uri,
            currentFilePath: sourceFilePath,
            packageName: packageName,
          );
          if (filePath != null && knownFiles.contains(filePath)) {
            continue;
          }
          if (filePath != null) {
            knownFiles.add(filePath);
          }
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
            collected.contains(uri) ||
            directlyAvailableSourceImports.contains(uri)) {
          continue;
        }
        if (sourceFilePath != null && packageName != null) {
          final filePath = _resolveImportToFilePath(
            uri: uri,
            currentFilePath: sourceFilePath,
            packageName: packageName,
          );
          if (filePath != null && knownFiles.contains(filePath)) {
            continue;
          }
          if (filePath != null) {
            knownFiles.add(filePath);
          }
        }
        collected.add(uri);
        yield "import '$uri';";
      }
    }

    final unresolvedTypes = <String>{};
    for (final field in provider.fields) {
      if (field.importPath != null) continue;
      unresolvedTypes.addAll(_extractTypeNames(field.type));
    }
    for (final param in provider.familyParameters) {
      if (param.importPath != null) continue;
      unresolvedTypes.addAll(_extractTypeNames(param.type));
    }

    if (sourceFilePath == null ||
        packageName == null ||
        unresolvedTypes.isEmpty) {
      return;
    }

    for (final typeName in unresolvedTypes) {
      final uri = _resolveImportUriForType(
        typeName: typeName,
        sourceFilePath: sourceFilePath,
        sourceImportUris: sourceImportUris,
        packageName: packageName,
      );
      if (uri == null ||
          uri.startsWith('dart:') ||
          uri.contains('/sky_engine/') ||
          collected.contains(uri) ||
          directlyAvailableSourceImports.contains(uri)) {
        continue;
      }

      final filePath = _resolveImportToFilePath(
        uri: uri,
        currentFilePath: sourceFilePath,
        packageName: packageName,
      );
      if (filePath != null && knownFiles.contains(filePath)) {
        continue;
      }
      if (filePath != null) {
        knownFiles.add(filePath);
      }

      collected.add(uri);
      yield "import '$uri';";
    }
  }

  Iterable<String> _extractTypeNames(String type) sync* {
    final matches = RegExp(r'[A-Za-z_][A-Za-z0-9_]*').allMatches(type);
    for (final match in matches) {
      final token = match.group(0);
      if (token == null) continue;
      if (_isResolvableTypeToken(token)) {
        yield token;
      }
    }
  }

  bool _isResolvableTypeToken(String token) {
    if (token.isEmpty) return false;
    if (!RegExp(r'^[A-Z]').hasMatch(token)) return false;
    const builtins = <String>{
      'Object',
      'String',
      'num',
      'int',
      'double',
      'bool',
      'Null',
      'Never',
      'Type',
      'Future',
      'FutureOr',
      'Stream',
      'Iterable',
      'Iterator',
      'List',
      'Map',
      'Set',
      'Record',
      'DateTime',
      'Duration',
      'Uri',
      'RegExp',
      'Pattern',
      'Symbol',
      'Function',
      'Widget',
      'BuildContext',
      'Key',
      'Color',
      'TextStyle',
      'IconData',
      'ImageProvider',
      'ChangeNotifier',
      'ValueNotifier',
    };
    return !builtins.contains(token);
  }

  String? _packageNameFor(String libraryUri) {
    final parsed = Uri.parse(libraryUri);
    if (parsed.scheme == 'package' && parsed.pathSegments.isNotEmpty) {
      return parsed.pathSegments.first;
    }
    return null;
  }

  String? _packageUriToFilePath(String uri, String packageName) {
    if (!uri.startsWith('package:$packageName/')) return null;
    final relativePath = uri.substring('package:$packageName/'.length);
    // Use path.join for cross-platform compatibility
    final path = [
      Directory.current.path,
      'lib',
      ...relativePath.split('/'),
    ].join(Platform.pathSeparator);
    final file = File(path);
    return file.existsSync() ? file.path : null;
  }

  String? _resolveImportToFilePath({
    required String uri,
    required String currentFilePath,
    required String packageName,
  }) {
    if (uri.startsWith('dart:')) return null;
    if (uri.startsWith('package:')) {
      return _packageUriToFilePath(uri, packageName);
    }

    final resolved = Uri.file(currentFilePath).resolve(uri).toFilePath();
    final file = File(resolved);
    return file.existsSync() ? file.path : null;
  }

  String? _filePathToPackageUri(String filePath, String packageName) {
    final libDir = [Directory.current.path, 'lib'].join(Platform.pathSeparator);
    // Normalize both paths for comparison
    final normalizedFilePath = filePath.replaceAll('\\', '/');
    final normalizedLibDir = libDir.replaceAll('\\', '/');
    if (!normalizedFilePath.startsWith(normalizedLibDir)) return null;
    final relative = normalizedFilePath.substring(normalizedLibDir.length + 1);
    return 'package:$packageName/$relative';
  }

  Iterable<String> _parseImportUris(String source) sync* {
    final regex = RegExp(r'''^\s*import\s+['"]([^'"]+)['"]''', multiLine: true);
    for (final match in regex.allMatches(source)) {
      final uri = match.group(1);
      if (uri == null || uri.isEmpty) continue;
      if (uri.endsWith('.g.dart') ||
          uri.endsWith('.freezed.dart') ||
          uri.endsWith('.widget.dart')) {
        continue;
      }
      yield uri;
    }
  }

  bool _declaresType(String source, String typeName) {
    final escaped = RegExp.escape(typeName);
    final patterns = <RegExp>[
      RegExp('\\bclass\\s+$escaped\\b'),
      RegExp('\\benum\\s+$escaped\\b'),
      RegExp('\\bmixin\\s+$escaped\\b'),
      RegExp('\\btypedef\\s+$escaped\\b'),
      RegExp('\\bextension\\s+type\\s+$escaped(?:\\b|\\.)'),
      RegExp('\\bextension\\s+$escaped\\b'),
    ];

    for (final pattern in patterns) {
      if (pattern.hasMatch(source)) return true;
    }
    return false;
  }

  String? _resolveImportUriForType({
    required String typeName,
    required String sourceFilePath,
    required List<String> sourceImportUris,
    required String packageName,
  }) {
    final cacheKey = '$sourceFilePath::$typeName';
    if (_typeImportCache.containsKey(cacheKey)) {
      return _typeImportCache[cacheKey];
    }

    final indexedUri = _lookupLocalTypeImport(typeName, packageName);
    if (indexedUri != null) {
      _typeImportCache[cacheKey] = indexedUri;
      return indexedUri;
    }

    final queue = Queue<({String uri, String filePath, int depth})>();
    final visited = <String>{};

    for (final uri in sourceImportUris) {
      final filePath = _resolveImportToFilePath(
        uri: uri,
        currentFilePath: sourceFilePath,
        packageName: packageName,
      );
      if (filePath == null) continue;
      final canonical = _filePathToPackageUri(filePath, packageName);
      if (canonical == null) continue;
      queue.add((uri: canonical, filePath: filePath, depth: 0));
    }

    while (queue.isNotEmpty) {
      final node = queue.removeFirst();
      if (!visited.add(node.filePath)) continue;

      final source = File(node.filePath).readAsStringSync();
      if (_declaresType(source, typeName)) {
        _typeImportCache[cacheKey] = node.uri;
        return node.uri;
      }

      if (node.depth >= 2) continue;

      for (final importUri in _parseImportUris(source)) {
        final childPath = _resolveImportToFilePath(
          uri: importUri,
          currentFilePath: node.filePath,
          packageName: packageName,
        );
        if (childPath == null || visited.contains(childPath)) continue;
        final canonical = _filePathToPackageUri(childPath, packageName);
        if (canonical == null) continue;
        queue.add((uri: canonical, filePath: childPath, depth: node.depth + 1));
      }
    }

    _typeImportCache[cacheKey] = null;
    return null;
  }

  String? _lookupLocalTypeImport(String typeName, String packageName) {
    final index = _localTypeIndexCache.putIfAbsent(
      packageName,
      () => _buildLocalTypeIndex(packageName),
    );
    return index[typeName];
  }

  Map<String, String> _buildLocalTypeIndex(String packageName) {
    final result = <String, String>{};
    final libDir = Directory('${Directory.current.path}/lib');
    if (!libDir.existsSync()) return result;

    final classRegex = RegExp(r'\bclass\s+([A-Za-z_][A-Za-z0-9_]*)\b');
    final enumRegex = RegExp(r'\benum\s+([A-Za-z_][A-Za-z0-9_]*)\b');
    final mixinRegex = RegExp(r'\bmixin\s+([A-Za-z_][A-Za-z0-9_]*)\b');
    final typedefRegex = RegExp(r'\btypedef\s+([A-Za-z_][A-Za-z0-9_]*)\b');
    final extensionTypeRegex = RegExp(
      r'\bextension\s+type\s+([A-Za-z_][A-Za-z0-9_]*)',
    );

    for (final entity in libDir.listSync(recursive: true)) {
      if (entity is! File) continue;
      if (!entity.path.endsWith('.dart')) continue;
      if (entity.path.endsWith('.g.dart') ||
          entity.path.endsWith('.freezed.dart') ||
          entity.path.endsWith('.widget.dart')) {
        continue;
      }

      final relativePath =
          entity.path.substring('${libDir.path}/'.length).replaceAll('\\', '/');
      final uri = 'package:$packageName/$relativePath';

      final source = entity.readAsStringSync();
      for (final regex in [
        classRegex,
        enumRegex,
        mixinRegex,
        typedefRegex,
        extensionTypeRegex,
      ]) {
        for (final match in regex.allMatches(source)) {
          final name = match.group(1);
          if (name == null || name.isEmpty) continue;
          result.putIfAbsent(name, () => uri);
        }
      }
    }

    return result;
  }

  /// Helper to generate params assignment for family providers
  /// For single param: `final params = paramValue;`
  /// For multiple params: `final params = (param1: param1Value, param2: param2Value);`
  void _writeParamsAssignment(
    StringBuffer buffer,
    ProviderDefinition provider, {
    bool useValueSuffix = false,
  }) {
    if (!provider.hasFamily) return;

    if (provider.familyParameters.length == 1) {
      final param = provider.familyParameters.first;
      final bang = param.isNullable ? '' : '!';
      final valueName = useValueSuffix ? '${param.name}Value$bang' : param.name;
      buffer.writeln('    final params = $valueName;');
    } else {
      buffer.writeln('    final params = (');
      for (final param in provider.familyParameters) {
        final bang = param.isNullable ? '' : '!';
        final valueName =
            useValueSuffix ? '${param.name}Value$bang' : param.name;
        buffer.writeln('      ${param.name}: $valueName,');
      }
      buffer.writeln('    );');
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
      '// Widgets: ${provider.baseName}Widget, ${provider.baseName}Select',
    );
    buffer.writeln('// Scope: ${provider.baseName}Scope');
    buffer.writeln('//');
    buffer.writeln('// Fields:');
    for (final field in provider.fields) {
      final hasController = (field.isTextField || field.isNumberField)
          ? 'ref.textController | '
          : '';
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
      '/// Extension that adds field update methods to the provider.',
    );
    buffer.writeln(
      'extension ${provider.baseName}FieldUpdater on ${provider.baseName} {',
    );

    for (final field in provider.fields) {
      final updateStatement = provider.isAsyncValue
          ? 'state.whenData((s) => s.copyWith(${field.name}: newValue))'
          : 'state.copyWith(${field.name}: newValue)';

      buffer.writeln('  /// Update the ${field.name} field.');
      buffer.writeln(
        '  void update${field.name.pascalCase}(${field.type} newValue) =>',
      );
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
      'class _${provider.baseName}ParamsInheritedWidget extends InheritedWidget {',
    );
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
      buffer.writeln('///');
      buffer.writeln('/// **Usage:**');
      buffer.writeln('/// ```dart');
      buffer.writeln('/// ${provider.baseName}Scope(');
      for (final param in provider.familyParameters) {
        buffer.writeln('///   ${param.name}: ${param.name},');
      }
      buffer.writeln('///   loading: CircularProgressIndicator(),');
      buffer.writeln('///   error: (e, s) => Text(e.toString()),');
      buffer.writeln('///   child: // Your widget tree here,');
      buffer.writeln('/// )');
      buffer.writeln('/// ```');
      buffer.writeln(
        'class ${provider.baseName}Scope extends ConsumerWidget {',
      );
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
        '  final Widget Function(Object error, StackTrace stackTrace)? error;',
      );
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
        _writeParamsAssignment(buffer, provider);
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
        '      return builder!(context, asyncValue, scopedChild);',
      );
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
          '/// Scope widget to provide family parameters to child widgets.',
        );
        buffer.writeln('///');
        buffer.writeln('/// **Usage:**');
        buffer.writeln('/// ```dart');
        buffer.writeln('/// ${provider.baseName}Scope(');
        for (final param in provider.familyParameters) {
          buffer.writeln('///   ${param.name}: ${param.name},');
        }
        buffer.writeln('///   child: // Your widget tree here,');
        buffer.writeln('/// )');
        buffer.writeln('/// ```');
      } else {
        buffer.writeln(
          '/// Scope widget placeholder for future family parameters.',
        );
        buffer.writeln(
          '/// Wrap your widget tree with this to future-proof for family provider migration.',
        );
      }
      buffer.writeln(
        'class ${provider.baseName}Scope extends StatelessWidget {',
      );
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
    if (provider.hasFamily) {
      buffer.writeln('  ${provider.baseName}ProxyWidgetRef(this._ref, {');
      for (final param in provider.familyParameters) {
        buffer.writeln('    this.${param.name},');
      }
      buffer.writeln('  });');
      buffer.writeln();
      buffer.writeln('  final WidgetRef _ref;');
      buffer.writeln();
      for (final param in provider.familyParameters) {
        final overrideType = param.isNullable ? param.type : '${param.type}?';
        buffer.writeln('  final $overrideType ${param.name};');
      }
      buffer.writeln();
      buffer.writeln(
        '  /// Resolved family parameters from direct values or scope.',
      );
      // For single param, use simple type; for multiple, use record
      if (provider.familyParameters.length == 1) {
        final param = provider.familyParameters.first;
        buffer.writeln('  ${param.type} get _params {');
        buffer.writeln(
          '    final scope = _${provider.baseName}ParamsInheritedWidget.maybeOf(_ref.context);',
        );
        buffer.writeln(
          '    final ${param.name}Value = ${param.name} ?? scope?.${param.name};',
        );
        if (!param.isNullable) {
          buffer.writeln(
            "    assert(${param.name}Value != null, 'No ${param.name} provided for ${provider.baseName}Provider');",
          );
        }
        final bang = param.isNullable ? '' : '!';
        buffer.writeln('    return ${param.name}Value$bang;');
        buffer.writeln('  }');
      } else {
        buffer.writeln(
          '  ({${provider.familyParameters.map((p) => '${p.type} ${p.name}').join(', ')}}) get _params {',
        );
        buffer.writeln(
          '    final scope = _${provider.baseName}ParamsInheritedWidget.maybeOf(_ref.context);',
        );
        for (final param in provider.familyParameters) {
          buffer.writeln(
            '    final ${param.name}Value = ${param.name} ?? scope?.${param.name};',
          );
          if (!param.isNullable) {
            buffer.writeln(
              "    assert(${param.name}Value != null, 'No ${param.name} provided for ${provider.baseName}Provider');",
            );
          }
        }
        buffer.writeln('    return (');
        for (final param in provider.familyParameters) {
          final bang = param.isNullable ? '' : '!';
          buffer.writeln(
            '      ${param.name}: ${param.name}Value$bang,',
          );
        }
        buffer.writeln('    );');
        buffer.writeln('  }');
      }
      buffer.writeln();
      buffer.writeln(
        "  ${provider.baseName} get notifier => _ref.read(${provider.providerNameWithFamily(prefix: '_params')}.notifier);",
      );
      buffer.writeln();
      buffer.writeln(
        '  /// Get params from scope (use within ${provider.baseName}Scope).',
      );
      buffer.writeln(
        '  _${provider.baseName}ParamsInheritedWidget? get params =>',
      );
      buffer.writeln(
        '      _${provider.baseName}ParamsInheritedWidget.maybeOf(_ref.context);',
      );
      buffer.writeln();
      buffer.writeln(
        '  Selected select<Selected>(Selected Function(${provider.baseType}) selector) =>',
      );
      buffer.writeln(
        "      _ref.watch(${provider.providerNameWithFamily(prefix: '_params')}.select((value) => selector(value${provider.isAsyncValue ? '.requireValue' : ''})));",
      );
    } else {
      buffer.writeln('  ${provider.baseName}ProxyWidgetRef(this._ref);');
      buffer.writeln();
      buffer.writeln('  final WidgetRef _ref;');
      buffer.writeln();
      buffer.writeln(
        '  ${provider.baseName} get notifier => _ref.read(${provider.providerName}.notifier);',
      );
      buffer.writeln();
      buffer.writeln(
        '  /// Get params from scope (use within ${provider.baseName}Scope).',
      );
      buffer.writeln(
        '  _${provider.baseName}ParamsInheritedWidget? get params =>',
      );
      buffer.writeln(
        '      _${provider.baseName}ParamsInheritedWidget.maybeOf(_ref.context);',
      );
      buffer.writeln();
      buffer.writeln(
        '  Selected select<Selected>(Selected Function(${provider.baseType}) selector) =>',
      );
      buffer.writeln(
        '      _ref.watch(${provider.providerName}.select((value) => selector(value${provider.isAsyncValue ? '.requireValue' : ''})));',
      );
    }
    buffer.writeln();
    buffer.writeln('  BuildContext get context => _ref.context;');
    buffer.writeln();
    buffer.writeln(
      '  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);',
    );
    buffer.writeln(
      '  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);',
    );
    buffer.writeln(
      '  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);',
    );
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateDebugCheckHasScope(ProviderDefinition provider) {
    final buffer = StringBuffer();
    buffer.writeln(
      'bool _debugCheckHas${provider.baseName}Scope(BuildContext context) {',
    );
    buffer.writeln('  assert(() {');
    buffer.writeln(
      '    if (_${provider.baseName}ParamsInheritedWidget.maybeOf(context) == null) {',
    );
    buffer.writeln('      throw FlutterError.fromParts(<DiagnosticsNode>[');
    buffer.writeln(
      "        ErrorSummary('No ${provider.baseName}Scope found'),",
    );
    buffer.writeln('        ErrorDescription(');
    buffer.writeln(
      "          '\${context.widget.runtimeType} widgets require a ${provider.baseName}Scope widget ancestor '",
    );
    buffer.writeln(
      "          'or to be provided the family parameters directly.',",
    );
    buffer.writeln('        ),');
    buffer.writeln('      ]);');
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
    final proxyArgs = provider.hasFamily
        ? ', ${provider.familyParameters.map((p) => '${p.name}: ${p.name}').join(', ')}'
        : '';

    buffer.writeln('/// Widget that rebuilds when any state changes.');
    buffer.writeln('///');
    buffer.writeln('/// **Usage:**');
    buffer.writeln('/// ```dart');
    if (provider.hasFamily) {
      final paramArgs = provider.familyParameters
          .map((p) => '${p.name}: ${p.name}')
          .join(', ');
      buffer.writeln('/// ${provider.baseName}Widget(');
      buffer.writeln('///   $paramArgs,');
      buffer.writeln('///   builder: (context, ref, state) {');
    } else {
      buffer.writeln('/// ${provider.baseName}Widget(');
      buffer.writeln('///   builder: (context, ref, state) {');
    }
    if (provider.isAsyncValue) {
      buffer.writeln('///     return state.when(');
      buffer.writeln('///       data: (data) => Text(data.toString()),');
      buffer.writeln('///       loading: () => CircularProgressIndicator(),');
      buffer.writeln('///       error: (e, s) => Text(e.toString()),');
      buffer.writeln('///     );');
    } else {
      buffer.writeln('///     return Text(state.toString());');
    }
    buffer.writeln('///   },');
    buffer.writeln('/// )');
    buffer.writeln('/// ```');
    buffer.writeln('class ${provider.baseName}Widget extends ConsumerWidget {');
    buffer.writeln('  const ${provider.baseName}Widget({');
    buffer.writeln('    super.key,');
    if (provider.hasFamily) {
      for (final param in provider.familyParameters) {
        buffer.writeln('    this.${param.name},');
      }
    }
    buffer.writeln('    required this.builder,');
    buffer.writeln('    this.onStateChanged,');
    buffer.writeln('  });');
    buffer.writeln();
    if (provider.hasFamily) {
      for (final param in provider.familyParameters) {
        final overrideType = param.isNullable ? param.type : '${param.type}?';
        buffer.writeln('  final $overrideType ${param.name};');
      }
      buffer.writeln();
    }
    buffer.writeln(
      '  final Widget Function(BuildContext context, ${provider.baseName}ProxyWidgetRef ref, $stateType state) builder;',
    );
    buffer.writeln(
      '  final void Function($stateType? previous, $stateType next)? onStateChanged;',
    );
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context, WidgetRef ref) {');

    if (provider.hasFamily) {
      final nonNullableParams =
          provider.familyParameters.where((p) => !p.isNullable).toList();
      if (nonNullableParams.isNotEmpty) {
        final needsScopeConditions =
            nonNullableParams.map((p) => '${p.name} == null').join(' || ');
        buffer.writeln('    final needsScope = $needsScopeConditions;');
        buffer.writeln(
          '    if (needsScope) assert(_debugCheckHas${provider.baseName}Scope(context));',
        );
      }
      buffer.writeln(
        '    final scope = _${provider.baseName}ParamsInheritedWidget.maybeOf(context);',
      );
      for (final param in provider.familyParameters) {
        buffer.writeln(
          '    final ${param.name}Value = ${param.name} ?? scope?.${param.name};',
        );
        if (!param.isNullable) {
          buffer.writeln(
            "    assert(${param.name}Value != null, 'No ${param.name} provided for ${provider.baseName}Provider');",
          );
        }
      }
      _writeParamsAssignment(buffer, provider, useValueSuffix: true);
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
      '    return builder(context, ${provider.baseName}ProxyWidgetRef(ref$proxyArgs), state);',
    );
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateSelectWidget(ProviderDefinition provider) {
    final buffer = StringBuffer();
    final proxyArgs = provider.hasFamily
        ? ', ${provider.familyParameters.map((p) => '${p.name}: ${p.name}').join(', ')}'
        : '';

    buffer
        .writeln('/// Widget that rebuilds only when selected value changes.');
    buffer.writeln('///');
    buffer.writeln('/// **Usage:**');
    buffer.writeln('/// ```dart');
    if (provider.hasFamily) {
      final paramArgs = provider.familyParameters
          .map((p) => '${p.name}: ${p.name}')
          .join(', ');
      buffer.writeln('/// ${provider.baseName}Select<String>(');
      buffer.writeln('///   $paramArgs,');
    } else {
      buffer.writeln('/// ${provider.baseName}Select<String>(');
    }
    buffer.writeln(
      '///   selector: (state) => state.${provider.fields.isNotEmpty ? provider.fields.first.name : 'fieldName'},',
    );
    buffer.writeln('///   builder: (context, ref, selectedValue) {');
    buffer.writeln('///     return Text(selectedValue);');
    buffer.writeln('///   },');
    buffer.writeln('/// )');
    buffer.writeln('/// ```');
    buffer.writeln(
      'class ${provider.baseName}Select<Selected> extends ConsumerWidget {',
    );
    buffer.writeln('  const ${provider.baseName}Select({');
    buffer.writeln('    super.key,');
    if (provider.hasFamily) {
      for (final param in provider.familyParameters) {
        buffer.writeln('    this.${param.name},');
      }
    }
    buffer.writeln('    required this.selector,');
    buffer.writeln('    required this.builder,');
    if (provider.isAsyncValue) {
      buffer.writeln('    this.loading,');
      buffer.writeln('    this.error,');
    }
    buffer.writeln('    this.onStateChanged,');
    buffer.writeln('  });');
    buffer.writeln();
    if (provider.hasFamily) {
      for (final param in provider.familyParameters) {
        final overrideType = param.isNullable ? param.type : '${param.type}?';
        buffer.writeln('  final $overrideType ${param.name};');
      }
      buffer.writeln();
    }
    buffer.writeln(
      '  final Selected Function(${provider.baseType} state) selector;',
    );
    buffer.writeln(
      '  final Widget Function(BuildContext context, ${provider.baseName}ProxyWidgetRef ref, Selected value) builder;',
    );
    if (provider.isAsyncValue) {
      buffer.writeln('  final Widget? loading;');
      buffer.writeln(
        '  final Widget Function(Object error, StackTrace stackTrace)? error;',
      );
    }
    buffer.writeln(
      '  final void Function(Selected? previous, Selected next)? onStateChanged;',
    );
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context, WidgetRef ref) {');

    if (provider.hasFamily) {
      final nonNullableParams =
          provider.familyParameters.where((p) => !p.isNullable).toList();
      if (nonNullableParams.isNotEmpty) {
        final needsScopeConditions =
            nonNullableParams.map((p) => '${p.name} == null').join(' || ');
        buffer.writeln('    final needsScope = $needsScopeConditions;');
        buffer.writeln(
          '    if (needsScope) assert(_debugCheckHas${provider.baseName}Scope(context));',
        );
      }
      buffer.writeln(
        '    final scope = _${provider.baseName}ParamsInheritedWidget.maybeOf(context);',
      );
      for (final param in provider.familyParameters) {
        buffer.writeln(
          '    final ${param.name}Value = ${param.name} ?? scope?.${param.name};',
        );
        if (!param.isNullable) {
          buffer.writeln(
            "    assert(${param.name}Value != null, 'No ${param.name} provided for ${provider.baseName}Provider');",
          );
        }
      }
      _writeParamsAssignment(buffer, provider, useValueSuffix: true);
    }

    if (provider.isAsyncValue) {
      buffer.writeln(
        '    final asyncValue = ref.watch(${provider.providerNameWithFamily(prefix: 'params')});',
      );
      buffer.writeln('    if (onStateChanged != null) {');
      buffer.writeln(
        '      ref.listen(${provider.providerNameWithFamily(prefix: 'params')}, (prev, next) {',
      );
      buffer.writeln('        final prevData = prev?.value;');
      buffer.writeln('        final nextData = next.value;');
      buffer.writeln('        if (prevData != null && nextData != null) {');
      buffer.writeln('          final prevSelected = selector(prevData);');
      buffer.writeln('          final nextSelected = selector(nextData);');
      buffer.writeln(
        '          if (prevSelected != nextSelected) onStateChanged!(prevSelected, nextSelected);',
      );
      buffer.writeln('        }');
      buffer.writeln('      });');
      buffer.writeln('    }');
      buffer.writeln('    return asyncValue.when(');
      buffer.writeln('      data: (data) {');
      buffer.writeln('        final selected = selector(data);');
      buffer.writeln(
        '        return builder(context, ${provider.baseName}ProxyWidgetRef(ref$proxyArgs), selected);',
      );
      buffer.writeln('      },');
      buffer.writeln(
        '      loading: () => loading ?? const SizedBox.shrink(),',
      );
      buffer.writeln(
        '      error: (err, stack) => error?.call(err, stack) ?? const SizedBox.shrink(),',
      );
      buffer.writeln('    );');
    } else {
      buffer.writeln(
        '    final selectedProvider = ${provider.providerNameWithFamily(prefix: 'params')}.select((value) => selector(value));',
      );
      buffer.writeln('    if (onStateChanged != null) {');
      buffer.writeln('      ref.listen(selectedProvider, (prev, next) {');
      buffer.writeln(
        '        if (prev != next) onStateChanged!(prev, next);',
      );
      buffer.writeln('      });');
      buffer.writeln('    }');
      buffer.writeln('    final selected = ref.watch(selectedProvider);');
      buffer.writeln(
        '    return builder(context, ${provider.baseName}ProxyWidgetRef(ref$proxyArgs), selected);',
      );
    }
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  /// Generate a ParamsBuilder widget for family providers.
  /// This exposes the family params in a builder with full access to select/notifier.
  String _generateParamsBuilder(ProviderDefinition provider) {
    final buffer = StringBuffer();

    // Generate params type string
    final paramsType = provider.familyParameters.length == 1
        ? provider.familyParameters.first.type
        : '({${provider.familyParameters.map((p) => '${p.type} ${p.name}').join(', ')}})';

    buffer.writeln(
      '/// Widget that provides family parameters from scope with full provider access.',
    );
    buffer.writeln(
      '/// Use this to access params passed down through ${provider.baseName}Scope.',
    );
    buffer.writeln('///');
    buffer.writeln('/// **Usage:**');
    buffer.writeln('/// ```dart');
    buffer.writeln('/// ${provider.baseName}Scope(');
    for (final param in provider.familyParameters) {
      buffer.writeln('///   ${param.name}: ${param.name},');
    }
    buffer.writeln('///   child: ${provider.baseName}ParamsBuilder(');
    buffer.writeln('///     builder: (context, ref, params) {');
    if (provider.familyParameters.length == 1) {
      buffer.writeln(
        '///       // params is ${provider.familyParameters.first.type}',
      );
    } else {
      buffer.writeln(
        '///       // params is (${provider.familyParameters.map((p) => '${p.name}: ${p.type}').join(', ')})',
      );
    }
    buffer.writeln(
      '///       return Text(ref.select((s) => s.${provider.fields.isNotEmpty ? provider.fields.first.name : 'fieldName'}));',
    );
    buffer.writeln('///     },');
    buffer.writeln('///   ),');
    buffer.writeln('/// )');
    buffer.writeln('/// ```');
    buffer.writeln(
      'class ${provider.baseName}ParamsBuilder extends ConsumerWidget {',
    );
    buffer.writeln('  const ${provider.baseName}ParamsBuilder({');
    buffer.writeln('    super.key,');
    buffer.writeln('    required this.builder,');
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln(
      '  final Widget Function(BuildContext context, ${provider.baseName}ProxyWidgetRef ref, $paramsType params) builder;',
    );
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context, WidgetRef ref) {');
    buffer.writeln(
      '    assert(_debugCheckHas${provider.baseName}Scope(context));',
    );
    buffer.writeln(
      '    final scope = _${provider.baseName}ParamsInheritedWidget.of(context);',
    );

    // Build params value based on single vs multiple params
    if (provider.familyParameters.length == 1) {
      final param = provider.familyParameters.first;
      buffer.writeln('    final params = scope.${param.name};');
    } else {
      buffer.writeln('    final params = (');
      for (final param in provider.familyParameters) {
        buffer.writeln('      ${param.name}: scope.${param.name},');
      }
      buffer.writeln('    );');
    }

    buffer.writeln(
      '    return builder(context, ${provider.baseName}ProxyWidgetRef(ref), params);',
    );
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateFieldWidget(
    ProviderDefinition provider,
    FieldDefinition field,
  ) {
    final buffer = StringBuffer();
    final widgetName = '${provider.baseName}${field.name.pascalCase}Field';

    // For String fields, use the simplified StringField helper
    if (field.isTextField) {
      return _generateStringFieldWidget(provider, field, widgetName);
    }

    // For numeric fields, use NumberField helper
    if (field.isNumberField) {
      return _generateNumberFieldWidget(provider, field, widgetName);
    }

    // For other non-String fields, generate a simple ConsumerWidget
    final proxyName =
        '${provider.baseName}${field.name.pascalCase}ProxyWidgetRef';
    final proxyArgs = provider.hasFamily
        ? ', ${provider.familyParameters.map((p) => '${p.name}: ${p.name}').join(', ')}'
        : '';
    final superArgs = provider.hasFamily
        ? ', {${provider.familyParameters.map((p) => 'super.${p.name}').join(', ')}}'
        : '';
    final manualUpdateArg = provider.hasCopyWith ? '' : ', onChanged';

    // Field-specific proxy
    buffer.writeln(
      'class $proxyName extends ${provider.baseName}ProxyWidgetRef {',
    );
    if (provider.hasCopyWith) {
      buffer.writeln('  $proxyName(super._ref$superArgs);');
    } else {
      buffer.writeln('  $proxyName(super._ref, this._manualUpdate$superArgs);');
    }
    buffer.writeln();
    if (!provider.hasCopyWith) {
      buffer.writeln(
        '  final void Function(${provider.baseName} notifier, ${field.type} value) _manualUpdate;',
      );
      buffer.writeln();
    }
    buffer.writeln(
      '  ${field.type} get ${field.name} => select((s) => s.${field.name});',
    );
    buffer.writeln(
      provider.hasCopyWith
          ? '  void update${field.name.pascalCase}(${field.type} value) => notifier.update${field.name.pascalCase}(value);'
          : '  void update${field.name.pascalCase}(${field.type} value) => _manualUpdate(notifier, value);',
    );
    buffer.writeln('}');
    buffer.writeln();

    // Simple ConsumerWidget for non-String fields
    buffer.writeln('class $widgetName extends ConsumerWidget {');
    buffer.writeln('  const $widgetName({');
    buffer.writeln('    super.key,');
    if (provider.hasFamily) {
      for (final param in provider.familyParameters) {
        buffer.writeln('    this.${param.name},');
      }
    }
    if (!provider.hasCopyWith) {
      buffer.writeln('    required this.onChanged,');
    }
    buffer.writeln('    required this.builder,');
    if (provider.isAsyncValue) {
      buffer.writeln('    this.loading,');
      buffer.writeln('    this.error,');
    }
    buffer.writeln('  });');
    buffer.writeln();
    if (provider.hasFamily) {
      for (final param in provider.familyParameters) {
        final overrideType = param.isNullable ? param.type : '${param.type}?';
        buffer.writeln('  final $overrideType ${param.name};');
      }
      buffer.writeln();
    }
    if (!provider.hasCopyWith) {
      buffer.writeln(
        '  final void Function(${provider.baseName} notifier, ${field.type} value) onChanged;',
      );
      buffer.writeln();
    }
    buffer.writeln(
      '  final Widget Function(BuildContext context, $proxyName ref) builder;',
    );
    if (provider.isAsyncValue) {
      buffer.writeln('  final Widget? loading;');
      buffer.writeln(
        '  final Widget Function(Object error, StackTrace stackTrace)? error;',
      );
    }
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context, WidgetRef ref) {');
    if (provider.hasFamily) {
      final nonNullableParams =
          provider.familyParameters.where((p) => !p.isNullable).toList();
      if (nonNullableParams.isNotEmpty) {
        final needsScopeConditions =
            nonNullableParams.map((p) => '${p.name} == null').join(' || ');
        buffer.writeln('    final needsScope = $needsScopeConditions;');
        buffer.writeln(
          '    if (needsScope) assert(_debugCheckHas${provider.baseName}Scope(context));',
        );
      }
      buffer.writeln(
        '    final scope = _${provider.baseName}ParamsInheritedWidget.maybeOf(context);',
      );
      for (final param in provider.familyParameters) {
        buffer.writeln(
          '    final ${param.name}Value = ${param.name} ?? scope?.${param.name};',
        );
        if (!param.isNullable) {
          buffer.writeln(
            "    assert(${param.name}Value != null, 'No ${param.name} provided for ${provider.baseName}Provider');",
          );
        }
      }
      _writeParamsAssignment(buffer, provider, useValueSuffix: true);
    }

    if (provider.isAsyncValue) {
      buffer.writeln(
        '    final asyncValue = ref.watch(${provider.providerNameWithFamily(prefix: 'params')});',
      );
      buffer.writeln('    return asyncValue.when(');
      buffer.writeln(
        '      data: (_) => builder(context, $proxyName(ref$manualUpdateArg$proxyArgs)),',
      );
      buffer.writeln(
        '      loading: () => loading ?? const SizedBox.shrink(),',
      );
      buffer.writeln(
        '      error: (err, stack) => error?.call(err, stack) ?? const SizedBox.shrink(),',
      );
      buffer.writeln('    );');
    } else {
      buffer.writeln(
        '    return builder(context, $proxyName(ref$manualUpdateArg$proxyArgs));',
      );
    }
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
    final proxyName =
        '${provider.baseName}${field.name.pascalCase}ProxyWidgetRef';
    final proxyArgs = provider.hasFamily
        ? ', ${provider.familyParameters.map((p) => '${p.name}: ${p.name}').join(', ')}'
        : '';
    final superArgs = provider.hasFamily
        ? ', {${provider.familyParameters.map((p) => 'super.${p.name}').join(', ')}}'
        : '';
    final manualUpdateArg = provider.hasCopyWith ? '' : ', onChanged';

    // Field-specific proxy for string fields (with textController)
    buffer.writeln(
      '/// Proxy ref for the ${field.name} string field with text controller access.',
    );
    buffer.writeln(
      'class $proxyName extends ${provider.baseName}ProxyWidgetRef {',
    );
    if (provider.hasCopyWith) {
      buffer
          .writeln('  $proxyName(super._ref, this._stringFieldRef$superArgs);');
    } else {
      buffer.writeln(
        '  $proxyName(super._ref, this._stringFieldRef, this._manualUpdate$superArgs);',
      );
    }
    buffer.writeln();
    buffer.writeln('  final StringFieldRef _stringFieldRef;');
    buffer.writeln();
    if (!provider.hasCopyWith) {
      buffer.writeln(
        '  final void Function(${provider.baseName} notifier, ${field.type} value) _manualUpdate;',
      );
      buffer.writeln();
    }
    buffer.writeln(
      '  ${field.type} get ${field.name} => select((s) => s.${field.name});',
    );
    buffer.writeln(
      provider.hasCopyWith
          ? '  void update${field.name.pascalCase}(${field.type} value) => notifier.update${field.name.pascalCase}(value);'
          : '  void update${field.name.pascalCase}(${field.type} value) => _manualUpdate(notifier, value);',
    );
    buffer.writeln(
      '  TextEditingController get textController => _stringFieldRef.controller;',
    );
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln(
      '/// Widget for the ${field.name} field with auto text controller sync.',
    );
    buffer.writeln('///');
    buffer.writeln('/// **Usage:**');
    buffer.writeln('/// ```dart');
    buffer.writeln('/// $widgetName(');
    buffer.writeln('///   builder: (context, ref) {');
    buffer.writeln('///     return TextField(controller: ref.textController);');
    buffer.writeln('///   },');
    buffer.writeln('/// )');
    buffer.writeln('/// ```');
    buffer.writeln('class $widgetName extends ConsumerWidget {');
    buffer.writeln('  const $widgetName({');
    buffer.writeln('    super.key,');
    if (provider.hasFamily) {
      for (final param in provider.familyParameters) {
        buffer.writeln('    this.${param.name},');
      }
    }
    buffer.writeln('    this.controller,');
    buffer.writeln('    this.debounceDuration,');
    if (!provider.hasCopyWith) {
      buffer.writeln('    required this.onChanged,');
    }
    buffer.writeln('    required this.builder,');
    if (provider.isAsyncValue) {
      buffer.writeln('    this.loading,');
      buffer.writeln('    this.error,');
    }
    buffer.writeln('  });');
    buffer.writeln();
    if (provider.hasFamily) {
      for (final param in provider.familyParameters) {
        final overrideType = param.isNullable ? param.type : '${param.type}?';
        buffer.writeln('  final $overrideType ${param.name};');
      }
      buffer.writeln();
    }
    buffer.writeln('  final TextEditingController? controller;');
    buffer.writeln('  final Duration? debounceDuration;');
    if (!provider.hasCopyWith) {
      buffer.writeln(
        '  final void Function(${provider.baseName} notifier, ${field.type} value) onChanged;',
      );
    }
    buffer.writeln(
      '  final Widget Function(BuildContext context, $proxyName ref) builder;',
    );
    if (provider.isAsyncValue) {
      buffer.writeln('  final Widget? loading;');
      buffer.writeln(
        '  final Widget Function(Object error, StackTrace stackTrace)? error;',
      );
    }
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context, WidgetRef ref) {');

    if (provider.hasFamily) {
      final nonNullableParams =
          provider.familyParameters.where((p) => !p.isNullable).toList();
      if (nonNullableParams.isNotEmpty) {
        final needsScopeConditions =
            nonNullableParams.map((p) => '${p.name} == null').join(' || ');
        buffer.writeln('    final needsScope = $needsScopeConditions;');
        buffer.writeln(
          '    if (needsScope) assert(_debugCheckHas${provider.baseName}Scope(context));',
        );
      }
      buffer.writeln(
        '    final scope = _${provider.baseName}ParamsInheritedWidget.maybeOf(context);',
      );
      for (final param in provider.familyParameters) {
        buffer.writeln(
          '    final ${param.name}Value = ${param.name} ?? scope?.${param.name};',
        );
        if (!param.isNullable) {
          buffer.writeln(
            "    assert(${param.name}Value != null, 'No ${param.name} provided for ${provider.baseName}Provider');",
          );
        }
      }
      _writeParamsAssignment(buffer, provider, useValueSuffix: true);
    }

    if (provider.isAsyncValue) {
      buffer.writeln(
        '    final asyncValue = ref.watch(${provider.providerNameWithFamily(prefix: 'params')});',
      );
      buffer.writeln('    return asyncValue.when(');
      buffer.writeln('      data: (data) {');
      buffer.writeln('        final value = data.${field.name};');
      buffer.writeln('        return StringField(');
      buffer.writeln('          value: value,');
      buffer.writeln('          controller: controller,');
      if (field.isNullable) {
        buffer.writeln('          emptyAsNull: true,');
      }
      buffer.writeln('          debounceDuration: debounceDuration,');
      if (provider.hasCopyWith) {
        if (field.isNullable) {
          buffer.writeln(
            '          onChanged: (v) => ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier).update${field.name.pascalCase}(v),',
          );
        } else {
          buffer.writeln(
            '          onChanged: (v) { if (v != null) ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier).update${field.name.pascalCase}(v); },',
          );
        }
      } else {
        if (field.isNullable) {
          buffer.writeln(
            '          onChanged: (v) => onChanged(ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier), v),',
          );
        } else {
          buffer.writeln(
            '          onChanged: (v) { if (v != null) onChanged(ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier), v); },',
          );
        }
      }
      buffer.writeln('          builder: (context, stringFieldRef) {');
      buffer.writeln(
        '            return builder(context, $proxyName(ref, stringFieldRef$manualUpdateArg$proxyArgs));',
      );
      buffer.writeln('          },');
      buffer.writeln('        );');
      buffer.writeln('      },');
      buffer.writeln(
        '      loading: () => loading ?? const SizedBox.shrink(),',
      );
      buffer.writeln(
        '      error: (err, stack) => error?.call(err, stack) ?? const SizedBox.shrink(),',
      );
      buffer.writeln('    );');
    } else {
      buffer.writeln('    final value = ref.watch(');
      buffer.writeln(
        '      ${provider.providerNameWithFamily(prefix: 'params')}.select((s) => s.${field.name}),',
      );
      buffer.writeln('    );');
      buffer.writeln();
      buffer.writeln('    return StringField(');
      buffer.writeln('      value: value,');
      buffer.writeln('      controller: controller,');
      if (field.isNullable) {
        buffer.writeln('      emptyAsNull: true,');
      }
      buffer.writeln('      debounceDuration: debounceDuration,');
      if (provider.hasCopyWith) {
        if (field.isNullable) {
          buffer.writeln(
            '      onChanged: (v) => ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier).update${field.name.pascalCase}(v),',
          );
        } else {
          buffer.writeln(
            '      onChanged: (v) { if (v != null) ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier).update${field.name.pascalCase}(v); },',
          );
        }
      } else {
        if (field.isNullable) {
          buffer.writeln(
            '      onChanged: (v) => onChanged(ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier), v),',
          );
        } else {
          buffer.writeln(
            '      onChanged: (v) { if (v != null) onChanged(ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier), v); },',
          );
        }
      }
      buffer.writeln('      builder: (context, stringFieldRef) {');
      buffer.writeln(
        '        return builder(context, $proxyName(ref, stringFieldRef$manualUpdateArg$proxyArgs));',
      );
      buffer.writeln('      },');
      buffer.writeln('    );');
    }
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  /// Generate a numeric field widget using the NumberField helper.
  /// This generates a ProxyWidgetRef for numeric fields with textController access.
  String _generateNumberFieldWidget(
    ProviderDefinition provider,
    FieldDefinition field,
    String widgetName,
  ) {
    final buffer = StringBuffer();
    final proxyName =
        '${provider.baseName}${field.name.pascalCase}ProxyWidgetRef';
    final baseNumberType = field.typeWithoutNullable;
    final proxyArgs = provider.hasFamily
        ? ', ${provider.familyParameters.map((p) => '${p.name}: ${p.name}').join(', ')}'
        : '';
    final superArgs = provider.hasFamily
        ? ', {${provider.familyParameters.map((p) => 'super.${p.name}').join(', ')}}'
        : '';
    final manualUpdateArg = provider.hasCopyWith ? '' : ', onChanged';

    buffer.writeln(
      '/// Proxy ref for the ${field.name} number field with text controller access.',
    );
    buffer.writeln(
      'class $proxyName extends ${provider.baseName}ProxyWidgetRef {',
    );
    if (provider.hasCopyWith) {
      buffer
          .writeln('  $proxyName(super._ref, this._numberFieldRef$superArgs);');
    } else {
      buffer.writeln(
        '  $proxyName(super._ref, this._numberFieldRef, this._manualUpdate$superArgs);',
      );
    }
    buffer.writeln();
    buffer.writeln('  final NumberFieldRef<$baseNumberType> _numberFieldRef;');
    buffer.writeln();
    if (!provider.hasCopyWith) {
      buffer.writeln(
        '  final void Function(${provider.baseName} notifier, ${field.type} value) _manualUpdate;',
      );
      buffer.writeln();
    }
    buffer.writeln(
      '  ${field.type} get ${field.name} => select((s) => s.${field.name});',
    );
    buffer.writeln(
      provider.hasCopyWith
          ? '  void update${field.name.pascalCase}(${field.type} value) => notifier.update${field.name.pascalCase}(value);'
          : '  void update${field.name.pascalCase}(${field.type} value) => _manualUpdate(notifier, value);',
    );
    buffer.writeln(
      '  TextEditingController get textController => _numberFieldRef.controller;',
    );
    buffer.writeln('}');
    buffer.writeln();

    buffer.writeln(
      '/// Widget for the ${field.name} field with auto number controller sync.',
    );
    buffer.writeln('///');
    buffer.writeln('/// **Usage:**');
    buffer.writeln('/// ```dart');
    buffer.writeln('/// $widgetName(');
    buffer.writeln('///   builder: (context, ref) {');
    buffer.writeln('///     return TextField(controller: ref.textController);');
    buffer.writeln('///   },');
    buffer.writeln('/// )');
    buffer.writeln('/// ```');
    buffer.writeln('class $widgetName extends ConsumerWidget {');
    buffer.writeln('  const $widgetName({');
    buffer.writeln('    super.key,');
    if (provider.hasFamily) {
      for (final param in provider.familyParameters) {
        buffer.writeln('    this.${param.name},');
      }
    }
    buffer.writeln('    this.controller,');
    buffer.writeln('    this.debounceDuration,');
    if (!provider.hasCopyWith) {
      buffer.writeln('    required this.onChanged,');
    }
    buffer.writeln('    required this.builder,');
    if (provider.isAsyncValue) {
      buffer.writeln('    this.loading,');
      buffer.writeln('    this.error,');
    }
    buffer.writeln('  });');
    buffer.writeln();
    if (provider.hasFamily) {
      for (final param in provider.familyParameters) {
        final overrideType = param.isNullable ? param.type : '${param.type}?';
        buffer.writeln('  final $overrideType ${param.name};');
      }
      buffer.writeln();
    }
    buffer.writeln('  final TextEditingController? controller;');
    buffer.writeln('  final Duration? debounceDuration;');
    if (!provider.hasCopyWith) {
      buffer.writeln(
        '  final void Function(${provider.baseName} notifier, ${field.type} value) onChanged;',
      );
    }
    buffer.writeln(
      '  final Widget Function(BuildContext context, $proxyName ref) builder;',
    );
    if (provider.isAsyncValue) {
      buffer.writeln('  final Widget? loading;');
      buffer.writeln(
        '  final Widget Function(Object error, StackTrace stackTrace)? error;',
      );
    }
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  Widget build(BuildContext context, WidgetRef ref) {');

    if (provider.hasFamily) {
      final nonNullableParams =
          provider.familyParameters.where((p) => !p.isNullable).toList();
      if (nonNullableParams.isNotEmpty) {
        final needsScopeConditions =
            nonNullableParams.map((p) => '${p.name} == null').join(' || ');
        buffer.writeln('    final needsScope = $needsScopeConditions;');
        buffer.writeln(
          '    if (needsScope) assert(_debugCheckHas${provider.baseName}Scope(context));',
        );
      }
      buffer.writeln(
        '    final scope = _${provider.baseName}ParamsInheritedWidget.maybeOf(context);',
      );
      for (final param in provider.familyParameters) {
        buffer.writeln(
          '    final ${param.name}Value = ${param.name} ?? scope?.${param.name};',
        );
        if (!param.isNullable) {
          buffer.writeln(
            "    assert(${param.name}Value != null, 'No ${param.name} provided for ${provider.baseName}Provider');",
          );
        }
      }
      _writeParamsAssignment(buffer, provider, useValueSuffix: true);
    }

    if (provider.isAsyncValue) {
      buffer.writeln(
        '    final asyncValue = ref.watch(${provider.providerNameWithFamily(prefix: 'params')});',
      );
      buffer.writeln('    return asyncValue.when(');
      buffer.writeln('      data: (data) {');
      buffer.writeln('        final value = data.${field.name};');
      buffer.writeln('        return NumberField<$baseNumberType>(');
      buffer.writeln('          value: value,');
      buffer.writeln('          controller: controller,');
      buffer.writeln('          debounceDuration: debounceDuration,');
      if (provider.hasCopyWith) {
        if (field.isNullable) {
          buffer.writeln(
            '          onChanged: (v) => ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier).update${field.name.pascalCase}(v),',
          );
        } else {
          buffer.writeln(
            '          onChanged: (v) { if (v != null) ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier).update${field.name.pascalCase}(v); },',
          );
        }
      } else {
        if (field.isNullable) {
          buffer.writeln(
            '          onChanged: (v) => onChanged(ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier), v),',
          );
        } else {
          buffer.writeln(
            '          onChanged: (v) { if (v != null) onChanged(ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier), v); },',
          );
        }
      }
      buffer.writeln('          builder: (context, numberFieldRef) {');
      buffer.writeln(
        '            return builder(context, $proxyName(ref, numberFieldRef$manualUpdateArg$proxyArgs));',
      );
      buffer.writeln('          },');
      buffer.writeln('        );');
      buffer.writeln('      },');
      buffer.writeln(
        '      loading: () => loading ?? const SizedBox.shrink(),',
      );
      buffer.writeln(
        '      error: (err, stack) => error?.call(err, stack) ?? const SizedBox.shrink(),',
      );
      buffer.writeln('    );');
    } else {
      buffer.writeln('    final value = ref.watch(');
      buffer.writeln(
        '      ${provider.providerNameWithFamily(prefix: 'params')}.select((s) => s.${field.name}),',
      );
      buffer.writeln('    );');
      buffer.writeln();
      buffer.writeln('    return NumberField<$baseNumberType>(');
      buffer.writeln('      value: value,');
      buffer.writeln('      controller: controller,');
      buffer.writeln('      debounceDuration: debounceDuration,');
      if (provider.hasCopyWith) {
        if (field.isNullable) {
          buffer.writeln(
            '      onChanged: (v) => ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier).update${field.name.pascalCase}(v),',
          );
        } else {
          buffer.writeln(
            '      onChanged: (v) { if (v != null) ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier).update${field.name.pascalCase}(v); },',
          );
        }
      } else {
        if (field.isNullable) {
          buffer.writeln(
            '      onChanged: (v) => onChanged(ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier), v),',
          );
        } else {
          buffer.writeln(
            '      onChanged: (v) { if (v != null) onChanged(ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier), v); },',
          );
        }
      }
      buffer.writeln('      builder: (context, numberFieldRef) {');
      buffer.writeln(
        '        return builder(context, $proxyName(ref, numberFieldRef$manualUpdateArg$proxyArgs));',
      );
      buffer.writeln('      },');
      buffer.writeln('    );');
    }

    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }
}
