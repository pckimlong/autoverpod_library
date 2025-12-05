import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';

class FieldDefinition {
  final String name;
  final String type;
  final bool isNullable;
  final bool isFinal;
  final String? documentation;
  final String? defaultValue;
  final List<String> annotations;
  final bool isPrivate;
  final bool isStatic;
  final bool isGetter;
  final bool isLate;
  final String? importPath;

  FieldDefinition({
    required this.name,
    required this.type,
    this.isNullable = false,
    this.isFinal = true,
    this.documentation,
    this.defaultValue,
    this.annotations = const [],
    this.isPrivate = false,
    this.isStatic = false,
    this.isGetter = false,
    this.isLate = false,
    this.importPath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'isNullable': isNullable,
      'isFinal': isFinal,
      'documentation': documentation,
      'defaultValue': defaultValue,
      'annotations': annotations,
      'isPrivate': isPrivate,
      'isStatic': isStatic,
      'isGetter': isGetter,
      'isLate': isLate,
      'importPath': importPath,
    };
  }

  factory FieldDefinition.parse(FieldElement field) {
    String? importPath;
    final fieldType = field.type;
    if (fieldType.element != null) {
      final uri = fieldType.element!.library?.uri.toString();
      if (uri != null && !uri.startsWith('dart:')) {
        importPath = uri;
      }
    }

    return FieldDefinition(
      name: field.name ?? '',
      type: field.type.toString(),
      isNullable: field.type.nullabilitySuffix == NullabilitySuffix.question,
      isFinal: field.isFinal,
      documentation: field.documentationComment,
      defaultValue: field.computeConstantValue()?.toString(),
      annotations: field.metadata.annotations.map((m) => m.toSource()).toList(),
      isPrivate: field.isPrivate,
      isStatic: field.isStatic,
      isGetter: field.getter != null && field.setter == null,
      isLate: field.isLate,
      importPath: importPath,
    );
  }

  factory FieldDefinition.parseFreezedParam(FormalParameterElement param) {
    String? importPath;
    final paramType = param.type;
    if (paramType.element != null) {
      final uri = paramType.element!.library?.uri.toString();
      if (uri != null && !uri.startsWith('dart:')) {
        importPath = uri;
      }
    }

    return FieldDefinition(
      name: param.name ?? '',
      type: param.type.toString(),
      isNullable: param.type.nullabilitySuffix == NullabilitySuffix.question,
      isFinal: true, // Freezed classes always generated as final
      documentation: param.documentationComment,
      defaultValue: param.defaultValueCode,
      annotations: param.metadata.annotations.map((m) => m.toSource()).toList(),
      isPrivate: param.isPrivate,
      isStatic: param.isStatic,
      isGetter: param is FieldFormalParameterElement,
      isLate: param.isLate,
      importPath: importPath,
    );
  }

  String get typeWithoutNullable =>
      isNullable ? type.substring(0, type.length - 1) : type;
}
