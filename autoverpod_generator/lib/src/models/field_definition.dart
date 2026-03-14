import 'package:lean_builder/element.dart';

import 'type_utils.dart';

/// Simplified field definition - only includes fields actually used by generators
class FieldDefinition {
  final String name;
  final String type;
  final bool isNullable;
  final String? importPath;

  FieldDefinition({
    required this.name,
    required this.type,
    required this.isNullable,
    this.importPath,
  });

  /// Parse from a Freezed factory constructor parameter
  factory FieldDefinition.fromParam(ParameterElement param) {
    final type = TypeUtils.safeReadType(() => param.type);
    final importPath = TypeUtils.resolveImportPath(type);

    return FieldDefinition(
      name: param.name,
      type: type?.toString() ?? 'dynamic',
      isNullable: type?.isNullable ?? true,
      importPath: importPath,
    );
  }

  /// Parse from a class field
  factory FieldDefinition.fromField(FieldElement field) {
    final type = TypeUtils.safeReadType(() => field.type);
    final importPath = TypeUtils.resolveImportPath(type);

    return FieldDefinition(
      name: field.name,
      type: type?.toString() ?? 'dynamic',
      isNullable: type?.isNullable ?? true,
      importPath: importPath,
    );
  }

  /// Parse from an instance getter accessor.
  factory FieldDefinition.fromAccessor(PropertyAccessorElement accessor) {
    final type = TypeUtils.safeReadType(() => accessor.returnType);
    final importPath = TypeUtils.resolveImportPath(type);

    return FieldDefinition(
      name: accessor.name,
      type: type?.toString() ?? 'dynamic',
      isNullable: type?.isNullable ?? true,
      importPath: importPath,
    );
  }

  /// Check if this is a String field (for text controller generation)
  bool get isTextField => type == 'String' || type == 'String?';

  /// Check if this is a numeric field (for NumberField generation)
  bool get isNumberField {
    final base = typeWithoutNullable;
    return base == 'int' || base == 'double' || base == 'num';
  }

  /// Get type without nullable suffix
  String get typeWithoutNullable =>
      isNullable ? type.substring(0, type.length - 1) : type;
}
