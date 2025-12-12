import 'package:lean_builder/element.dart';

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
    String? importPath;
    final paramType = param.type;
    if (paramType.element != null) {
      final uri = paramType.element!.librarySrc.shortUri.toString();
      if (!uri.startsWith('dart:')) {
        importPath = uri;
      }
    }

    return FieldDefinition(
      name: param.name,
      type: param.type.toString(),
      isNullable: param.type.isNullable,
      importPath: importPath,
    );
  }

  /// Parse from a class field
  factory FieldDefinition.fromField(FieldElement field) {
    String? importPath;
    final fieldType = field.type;
    if (fieldType.element != null) {
      final uri = fieldType.element!.librarySrc.shortUri.toString();
      if (!uri.startsWith('dart:')) {
        importPath = uri;
      }
    }

    return FieldDefinition(
      name: field.name,
      type: field.type.toString(),
      isNullable: field.type.isNullable,
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
  String get typeWithoutNullable => isNullable ? type.substring(0, type.length - 1) : type;
}
