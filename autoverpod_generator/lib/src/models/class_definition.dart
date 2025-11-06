import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:autoverpod_generator/src/models/field_definition.dart';
import 'package:autoverpod_generator/src/models/method_definition.dart';

/// Configuration options for class parsing behavior.
class ClassParserOptions {
  /// Creates parser options with default values.
  const ClassParserOptions({
    this.parseCopyWith = true,
    this.parseConstructors = true,
    this.parseFields = true,
    this.parseParentTypes = false,
    this.parsePrivateFields = false,
    this.parseSyntheticFields = false,
    this.parseStaticFields = false,
    this.toParseMethods = const [],
  });

  /// Whether to parse copyWith-related information
  final bool parseCopyWith;

  /// Whether to parse parent class types (superclass, interfaces, mixins)
  final bool parseParentTypes;

  /// Whether to parse constructors
  final bool parseConstructors;

  /// Whether to parse fields
  final bool parseFields;

  /// Whether to include private fields in parsing
  final bool parsePrivateFields;

  /// Whether to include synthetic fields in parsing
  final bool parseSyntheticFields;

  /// List of method names to parse for detailed information, "*" for all methods
  final List<String> toParseMethods;

  /// Whether to parse static fields
  final bool parseStaticFields;

  bool get parseAllMethods => toParseMethods.contains('*');

  /// Creates a copy of this configuration with some fields replaced.
  ClassParserOptions copyWith({
    bool? parseCopyWith,
    bool? parseMethods,
    bool? parseParentTypes,
    bool? parseConstructors,
    bool? parseFields,
    bool? parsePrivateFields,
    bool? parseSyntheticFields,
    bool? freezedSupport,
    List<String>? toParseMethods,
  }) {
    return ClassParserOptions(
      parseCopyWith: parseCopyWith ?? this.parseCopyWith,
      parseParentTypes: parseParentTypes ?? this.parseParentTypes,
      parseConstructors: parseConstructors ?? this.parseConstructors,
      parseFields: parseFields ?? this.parseFields,
      parsePrivateFields: parsePrivateFields ?? this.parsePrivateFields,
      parseSyntheticFields: parseSyntheticFields ?? this.parseSyntheticFields,
      toParseMethods: toParseMethods ?? this.toParseMethods,
    );
  }
}

/// Represents a Dart class definition with its properties and methods.
class ClassDefinition {
  ClassDefinition({
    required this.name,
    required this.isFreezed,
    required this.parentTypes,
    required this.fields,
    required this.methods,
    required this.constructors,
    required this.copyWithMethod,
  });

  /// Name of the class
  final String name;

  /// List of field definitions
  final List<FieldDefinition> fields;

  /// Whether the class is a Freezed class
  final bool isFreezed;

  /// Map of method names to their definitions
  final Map<String, MethodDefinition?> methods;

  /// List of constructor names
  final List<String> constructors;

  /// List of parent type names (superclass, interfaces, mixins)
  final List<String> parentTypes;

  /// Method definition for the copyWith method
  final MethodDefinition? copyWithMethod;

  /// Parses a [DartType] into a [ClassDefinition] with the specified options.
  ///
  /// Returns null if the type is not a class.
  static ClassDefinition? parse(
    DartType type, {
    ClassParserOptions options = const ClassParserOptions(),
  }) {
    if (type.element is! ClassElement) {
      return null;
    }

    // Ignore if it is a library type
    if (_isLibraryType(type.element as ClassElement)) {
      return null;
    }

    final classElement = type.element as ClassElement;
    final isFreezed = _isFreezed(classElement);

    final parentTypes = options.parseParentTypes
        ? _parseParentTypes(classElement)
        : const <String>[];

    final fields = options.parseFields
        ? _parseFields(classElement, isFreezed, options)
        : const <FieldDefinition>[];

    final methods = _parseMethods(classElement, fields, options);

    final constructors = options.parseConstructors
        ? _parseConstructors(classElement, options)
        : const <String>[];

    return ClassDefinition(
      name: classElement.name ?? '',
      fields: fields,
      isFreezed: isFreezed,
      methods: methods,
      constructors: constructors,
      parentTypes: parentTypes,
      copyWithMethod: methods['copyWith'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'isFreezed': isFreezed,
      'parentTypes': parentTypes,
      'constructors': constructors,
      'fields': fields.map((x) => x.toMap()).toList(),
      'copyWithMethod': copyWithMethod?.toMap(),
      'methods': methods.map((key, value) => MapEntry(key, value?.toMap())),
    };
  }

  /// Check if a class is a freezed class by looking for the @freezed annotation
  /// and the _$ mixin
  static bool _isFreezed(ClassElement element) {
    // Check for @freezed annotation
    final hasFreezedAnnotation =
        element.metadata.annotations.any((m) => m.element?.displayName == 'freezed');

    // Check for the _$ mixin which is characteristic of freezed classes
    final hasMixin =
        element.mixins.any((m) => m.getDisplayString().startsWith('_\$'));

    return hasFreezedAnnotation || hasMixin;
  }

  /// Parse parent types (superclass, interfaces, and mixins)
  static List<String> _parseParentTypes(ClassElement element) {
    return [
      if (element.supertype != null &&
          element.supertype!.element.name != 'Object')
        element.supertype!.getDisplayString(),
      ...element.interfaces.map((i) => i.getDisplayString()),
      ...element.mixins.map((m) => m.getDisplayString()),
    ];
  }

  static bool _isLibraryType(ClassElement element) {
    // First check the base type against known library types
    if (_dartCoreTypes.contains(element.name)) return true;

    // If it's a generic library type, check its base
    final isGeneric = element.typeParameters.isNotEmpty;
    if (isGeneric && _dartCoreTypes.contains(element.name)) return true;

    return false;
  }

  /// Parse fields from a class element, handling both Freezed and regular classes
  static List<FieldDefinition> _parseFields(
    InterfaceElement element,
    bool isFreezed,
    ClassParserOptions options,
  ) {
    final fields = <FieldDefinition>[];

    if (isFreezed) {
      // For freezed classes, look at the factory constructor parameters
      final factoryConstructors = element.constructors.where((c) {
        final constructorName = c.name ?? '';
        return c.isFactory &&
            (!c.isSynthetic || options.parseSyntheticFields) &&
            (c.isPublic || options.parsePrivateFields) &&
            (options.parseStaticFields || !c.isStatic) &&
            constructorName != 'fromJson'; // ignore fromJson factory constructor
      });

      for (final constructor in factoryConstructors) {
        final params = constructor.formalParameters.where((p) {
          return (!p.isSynthetic || options.parseSyntheticFields) &&
              (p.isPublic || options.parsePrivateFields);
        });

        for (final param in params) {
          final paramName = param.name ?? '';
          if (paramName.isEmpty || fields.any((f) => f.name == paramName)) {
            continue;
          }

          fields.add(FieldDefinition.parseFreezedParam(param));
        }
      }

      // Add fields from the class element
      fields.addAll(
        element.fields
            .where((f) {
              return (!f.isSynthetic || options.parseSyntheticFields) &&
                  (options.parseStaticFields || !f.isStatic) &&
                  (f.isPublic || options.parsePrivateFields);
            })
            .map((f) => FieldDefinition.parse(f))
            .toList(),
      );
    } else {
      // Regular class field parsing
      fields.addAll(
        element.fields
            .where((f) {
              return (!f.isSynthetic || options.parseSyntheticFields) &&
                  (options.parseStaticFields || !f.isStatic) &&
                  (f.isPublic || options.parsePrivateFields);
            })
            .map((f) => FieldDefinition.parse(f))
            .toList(),
      );
    }

    return fields;
  }

  /// Parse method names from a class element, including methods from mixins and freezed implementations
  static Map<String, MethodDefinition?> _parseMethods(
    InterfaceElement element,
    List<FieldDefinition> fields,
    ClassParserOptions options,
  ) {
    if (options.toParseMethods.isEmpty && !options.parseCopyWith) {
      return const <String, MethodDefinition?>{};
    }

    final methods = <String, MethodDefinition?>{};

    // Get methods directly declared in the class
    for (final method in element.methods.where((m) {
      final methodName = m.name;
      return methodName != null &&
          ((!m.isSynthetic || options.parseSyntheticFields) &&
                  (m.isPublic || options.parsePrivateFields) &&
                  (options.parseAllMethods ||
                      options.toParseMethods.contains(methodName)) ||
              (options.parseCopyWith && methodName == 'copyWith'));
    })) {
      final methodName = method.name;
      if (methodName != null) {
        methods[methodName] = MethodDefinition.parseMethod(method);
      }
    }

    // Get getters
    for (final accessor in element.getters.where((a) {
      final accessorName = a.name;
      return accessorName != null &&
          ((!a.isSynthetic || options.parseSyntheticFields) &&
                  (a.isPublic || options.parsePrivateFields) &&
                  (options.parseAllMethods ||
                      options.toParseMethods.contains(accessorName)) ||
              (options.parseCopyWith && accessorName == 'copyWith'));
    })) {
      final accessorName = accessor.name;
      if (accessorName != null) {
        methods[accessorName] = MethodDefinition.parseGetter(accessor);
      }
    }

    if (_isFreezed(element as ClassElement)) {
      // For Freezed classes, look for the generated CopyWith interface
      final copyWithInterface = element.library.classes
          .where((e) => e.name == '\$${element.name}CopyWith')
          .firstOrNull;

      if (copyWithInterface != null) {
        // Find the call method in the CopyWith interface which contains the parameters
        final callMethod = copyWithInterface.methods
            .where((m) => m.name == 'call')
            .firstOrNull;

        if (callMethod != null) {
          methods['copyWith'] = MethodDefinition.parseMethod(callMethod);
        }
      }

      // Also look for methods in the private mixin for completeness
      final privateMixin = element.library.mixins
          .where((e) => e.name?.startsWith('_\$${element.name}') ?? false)
          .firstOrNull;

      if (privateMixin != null) {
        for (final method in privateMixin.methods.where(
          (m) {
            final methodName = m.name;
            return methodName != null &&
                (!m.isSynthetic || options.parseSyntheticFields) &&
                (m.isPublic || options.parsePrivateFields) &&
                !methodName.startsWith('_') &&
                // Skip methods that are already defined as fields
                !fields.any((f) => f.name == methodName) &&
                (options.parseAllMethods ||
                    options.toParseMethods.contains(methodName));
          },
        )) {
          final methodName = method.name;
          if (methodName != null) {
            methods[methodName] = MethodDefinition.parseMethod(method);
          }
        }

        // Get getters from private mixin
        for (final accessor in privateMixin.getters.where(
          (a) {
            final accessorName = a.name;
            return accessorName != null &&
                (!a.isSynthetic || options.parseSyntheticFields) &&
                (a.isPublic || options.parsePrivateFields) &&
                !accessorName.startsWith('_') &&
                !fields.any((f) => f.name == accessorName) &&
                (options.parseAllMethods ||
                    options.toParseMethods.contains(accessorName));
          },
        )) {
          final accessorName = accessor.name;
          if (accessorName != null) {
            methods[accessorName] = MethodDefinition.parseGetter(accessor);
          }
        }
      }
    }

    return methods;
  }

  /// Parse constructor names from a class element
  static List<String> _parseConstructors(
    InterfaceElement element,
    ClassParserOptions options,
  ) {
    return element.constructors
        .where((c) {
          return (!c.isSynthetic || options.parseSyntheticFields) &&
              (c.isPublic || options.parsePrivateFields);
        })
        .map((c) => c.name ?? '')
        .toList();
  }
}

/// A comprehensive set of Dart core library types.
/// This includes collections, futures/streams, basic types, and other commonly used
/// types from the dart:core library.
const _dartCoreTypes = {
  // Core collections
  'List', 'Set', 'Map', 'Iterable',
  // Futures and Streams
  'Future', 'FutureOr', 'Stream',
  // Basic types
  'String', 'int', 'double', 'num', 'bool',
  // Other common types
  'DateTime', 'Duration', 'Uri', 'Runes',
  'Comparable', 'Pattern', 'RegExp',
  // Collections
  'Iterator', 'Queue', 'HashSet', 'LinkedHashSet', 'SplayTreeSet',
  'HashMap', 'LinkedHashMap', 'SplayTreeMap',
};
