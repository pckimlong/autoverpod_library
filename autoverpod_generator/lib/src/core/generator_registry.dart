import 'package:autoverpod_generator/src/core/generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Registry for all widget generators
class GeneratorRegistry {
  GeneratorRegistry._();

  static final GeneratorRegistry _instance = GeneratorRegistry._();

  /// Get the singleton instance
  static GeneratorRegistry get instance => _instance;

  /// List of registered generators
  final List<WidgetGenerator> _generators = [];

  /// Set of additional imports required by generators
  final Set<String> _additionalImports = {};

  /// Register a new generator
  void registerGenerator(WidgetGenerator generator) =>
      _generators.add(generator);

  /// Get all registered generators
  List<WidgetGenerator> get generators => List.unmodifiable(_generators);

  /// Add an additional import that will be included in generated files
  void addImport(String import) => _additionalImports.add(import);

  /// Get all required imports from all registered generators
  List<String> getAllRequiredImports() {
    final imports = <String>{};

    // Add imports from generators
    for (final generator in _generators) {
      imports.addAll(generator.getRequiredImports());
    }

    // Add additional imports
    imports.addAll(_additionalImports);

    return imports.toList();
  }

  /// Generate code for all registered generators
  Future<String> generateForLibrary(
    LibraryReader library,
    BuildStep buildStep,
  ) async {
    final buffer = StringBuffer();

    for (final generator in _generators) {
      final output = await generator.generate(library, buildStep);

      if (output.isNotEmpty) {
        buffer.writeln(output);
      }
    }

    return buffer.toString();
  }
}
