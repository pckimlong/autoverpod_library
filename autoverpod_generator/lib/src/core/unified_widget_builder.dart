import 'package:autoverpod_generator/src/core/generator_registry.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';

/// A unified builder that uses all registered generators
class UnifiedWidgetBuilder implements Builder {
  final GeneratorRegistry _registry;

  UnifiedWidgetBuilder({GeneratorRegistry? registry})
      : _registry = registry ?? GeneratorRegistry.instance;

  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': ['.widget.dart'],
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;

    // Skip generated part files
    if (inputId.path.endsWith('.g.dart') ||
        inputId.path.endsWith('.freezed.dart') ||
        inputId.path.endsWith('.widget.dart')) {
      return;
    }

    if (!await buildStep.canRead(inputId)) return;

    final content = await buildStep.readAsString(inputId);
    if (content.isEmpty) return;

    // Skip if the file is not a library
    final resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;

    // Skip if no generators can process this file
    final library = LibraryReader(await buildStep.resolver.libraryFor(inputId));
    bool hasAnnotations = false;

    for (final element in library.allElements) {
      for (final generator in _registry.generators) {
        if (generator.canProcess(element)) {
          hasAnnotations = true;
          break;
        }
      }
      if (hasAnnotations) break;
    }

    if (!hasAnnotations) return;

    final outputContent = await _generateOutput(library, buildStep);

    if (outputContent.isNotEmpty) {
      final outputId = inputId.changeExtension('.widget.dart');
      await buildStep.writeAsString(outputId, outputContent);
    }
  }

  Future<String> _generateOutput(
    LibraryReader library,
    BuildStep buildStep,
  ) async {
    final generatedCode =
        await _registry.generateForLibrary(library, buildStep);

    if (generatedCode.isEmpty) return '';

    // Get imports from registry
    final imports = Set<String>.from(_registry.getAllRequiredImports());

    // Add source file's imports to ensure dependencies are available
    final sourceImports = library.element.importedLibraries
        .map((lib) => lib.source.uri.toString())
        .where((uri) => _shouldIncludeSourceImport(uri))
        .cast<String>()
        .toSet();

    // Handle relative imports
    final currentDir = path.dirname(buildStep.inputId.path);
    final resolvedImports = imports.map((import) {
      if (import.startsWith('package:') || import.startsWith('dart:')) {
        return import;
      }
      // Convert relative imports to be relative to the output file
      final relativePath = path.relative(import, from: currentDir);
      return relativePath.startsWith('.') ? relativePath : './$relativePath';
    }).toSet();

    // Combine all imports and filter out unwanted ones
    final allImports = {...resolvedImports, ...sourceImports};
    final filteredImports = _filterAndSortImports(allImports, buildStep);

    // Create a library with imports and generated code
    final generatedLib = Library((b) {
      b.comments.addAll([
        "**************************************************************************",
        "GENERATED CODE - DO NOT MODIFY BY HAND",
        "**************************************************************************",
        "ignore_for_file: type=lint, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unnecessary_import, unused_import",
        "coverage:ignore-file",
      ]);

      // Import source file (but not the generated file itself)
      final sourceFileUri = buildStep.inputId.uri.toString();
      if (!sourceFileUri.endsWith('.widget.dart')) {
        b.directives.add(Directive.import(sourceFileUri));
      }

      // Add filtered and sorted imports
      b.directives.addAll(filteredImports.map((e) => Directive.import(e)));

      // Add the generated code
      b.body.add(Code("\n\n$generatedCode"));
    });

    return _dartfmt.format(generatedLib.accept(DartEmitter()).toString());
  }

  /// Filter out unwanted imports and sort them deterministically
  List<String> _filterAndSortImports(Set<String> imports, BuildStep buildStep) {
    final outputFileUri = buildStep.inputId.changeExtension('.widget.dart').uri.toString();
    
    final filtered = imports.where((uri) {
      // Remove self-imports (generated file importing itself)
      if (uri == outputFileUri) return false;
      
      // Remove only dart:core (it's automatically available)
      if (uri == 'dart:core') return false;
      
      // Remove private dart: imports
      if (uri.startsWith('dart:_')) return false;
      
      // Remove autoverpod_generator package imports
      if (uri.contains('autoverpod_generator')) return false;
      
      return true;
    }).toList();

    // Sort imports deterministically for consistent output
    filtered.sort(_compareImports);
    
    return filtered;
  }

  /// Determine if a source import should be included
  bool _shouldIncludeSourceImport(String uri) {
    // Skip private dart imports
    if (uri.startsWith('dart:_')) return false;
    
    // Skip annotation packages (they're not needed in generated code)
    if (uri.contains('annotation')) return false;
    
    // Skip the generator package itself
    if (uri.contains('autoverpod_generator')) return false;
    
    return true;
  }

  /// Compare imports for deterministic sorting
  int _compareImports(String a, String b) {
    // Dart imports first
    if (a.startsWith('dart:') && !b.startsWith('dart:')) return -1;
    if (!a.startsWith('dart:') && b.startsWith('dart:')) return 1;
    
    // Package imports second
    if (a.startsWith('package:') && !b.startsWith('package:')) return -1;
    if (!a.startsWith('package:') && b.startsWith('package:')) return 1;
    
    // Relative imports last
    if (!a.startsWith('dart:') && !a.startsWith('package:') && 
        (b.startsWith('dart:') || b.startsWith('package:'))) return 1;
    if ((a.startsWith('dart:') || a.startsWith('package:')) && 
        !b.startsWith('dart:') && !b.startsWith('package:')) return -1;
    
    // Within each category, sort alphabetically
    return a.compareTo(b);
  }

  static final _dartfmt =
      DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
}
