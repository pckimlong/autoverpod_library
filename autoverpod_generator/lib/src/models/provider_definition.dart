import 'package:lean_builder/element.dart';
import 'package:lean_builder/src/type/type.dart';
import 'package:recase/recase.dart';

import 'field_definition.dart';
import 'param_definition.dart';

/// Simplified provider definition with only fields needed for state widget generation
class ProviderDefinition {
  final String baseName;
  final String providerName;
  final bool isAsyncValue;
  final String baseType;
  final List<ParamDefinition> familyParameters;
  final List<FieldDefinition> fields;

  ProviderDefinition({
    required this.baseName,
    required this.providerName,
    required this.isAsyncValue,
    required this.baseType,
    required this.familyParameters,
    required this.fields,
  });

  /// Whether this provider has family parameters
  bool get hasFamily => familyParameters.isNotEmpty;

  /// Parse a class element into a ProviderDefinition
  factory ProviderDefinition.parse(ClassElement element) {
    final baseName = element.name.pascalCase;
    final providerName = '${baseName}Provider'.camelCase;

    // Find the build method
    final buildMethod = element.methods.firstWhere(
      (m) => m.name == 'build',
      orElse: () => throw StateError(
          'Provider class ${element.name} must have a build method'),
    );

    // Parse return type
    final returnType = buildMethod.returnType;
    final wrapperType =
        returnType is InterfaceType ? returnType.element.name : null;
    final isAsyncValue =
        ['Future', 'Stream', 'FutureOr', 'AsyncValue'].contains(wrapperType);

    // Get base type (unwrap Future/Stream if needed)
    String baseType;
    DartType stateType;
    if (isAsyncValue &&
        returnType is ParameterizedType &&
        returnType.typeArguments.isNotEmpty) {
      stateType = returnType.typeArguments.first;
      baseType = stateType.toString();
    } else {
      stateType = returnType;
      baseType = returnType.toString();
    }

    // Parse family parameters from build method
    final familyParameters = buildMethod.parameters
        .map((p) => ParamDefinition.fromElement(p))
        .toList();

    // Parse fields from return type's class
    final fields = _parseFields(stateType);

    return ProviderDefinition(
      baseName: baseName,
      providerName: providerName,
      isAsyncValue: isAsyncValue,
      baseType: baseType,
      familyParameters: familyParameters,
      fields: fields,
    );
  }

  /// Parse fields from a state class (including Freezed support)
  static List<FieldDefinition> _parseFields(DartType type) {
    if (type.element is! ClassElement) return [];

    final classElement = type.element as ClassElement;
    final fields = <FieldDefinition>[];

    // Check if it's a Freezed class by multiple strategies
    final isFreezed =
        classElement.mixins.any((m) => m.toString().startsWith('_\$')) ||
            classElement.mixins
                .any((m) => m.element?.name.startsWith('_\$') ?? false);

    if (isFreezed) {
      // Parse from factory constructor parameters for Freezed
      final factoryConstructors = classElement.constructors.where(
        (c) => c.isFactory && c.name != 'fromJson',
      );

      for (final constructor in factoryConstructors) {
        for (final param in constructor.parameters) {
          final paramName = param.name;
          if (paramName.isEmpty || fields.any((f) => f.name == paramName)) {
            continue;
          }
          fields.add(FieldDefinition.fromParam(param));
        }
      }
    }

    // Fallback: if no fields found via factory, try public getters/fields
    // This handles cases where Freezed detection fails or non-Freezed classes
    if (fields.isEmpty) {
      for (final field
          in classElement.fields.where((f) => f.isPublic && !f.isStatic)) {
        // Skip internal Freezed fields
        if (field.name.startsWith('_') ||
            field.name == 'copyWith' ||
            field.name == 'hashCode') {
          continue;
        }
        fields.add(FieldDefinition.fromField(field));
      }
    }

    return fields;
  }

  /// Get provider name with family parameters
  String providerNameWithFamily({String prefix = ''}) {
    if (!hasFamily) return providerName;

    final params = familyParameters.map((p) {
      final value = prefix.isEmpty ? p.name : '$prefix.${p.name}';
      return p.isNamed ? '${p.name}: $value' : value;
    }).join(', ');

    return '$providerName($params)';
  }

  /// Get family parameters as binding string
  String familyBindString({String prefix = ''}) {
    if (!hasFamily) return '';

    return familyParameters.map((p) {
      final value = prefix.isEmpty ? p.name : '$prefix.${p.name}';
      return p.isNamed ? '${p.name}: $value' : value;
    }).join(', ');
  }
}
