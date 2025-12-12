import 'package:lean_builder/element.dart';

import '../templates/utils.dart';

/// Simplified parameter definition for family providers
class ParamDefinition {
  final String name;
  final String type;
  final bool isRequired;
  final bool isNamed;
  final String? importPath;

  ParamDefinition({
    required this.name,
    required this.type,
    this.isRequired = true,
    this.isNamed = true,
    this.importPath,
  });

  bool get isNullable => type.endsWith('?');

  factory ParamDefinition.fromElement(ParameterElement parameter) {
    String? importPath;
    final paramType = parameter.type;
    if (paramType.element != null) {
      final uri = paramType.element!.librarySrc.shortUri.toString();
      if (!uri.startsWith('dart:')) {
        importPath = uri;
      }
    }

    return ParamDefinition(
      name: parameter.name,
      type: parameter.type.toString(),
      isRequired: parameter.isRequired,
      isNamed: parameter.isNamed,
      importPath: importPath,
    );
  }

  ClassField toClassField({bool isFinal = true}) {
    return ClassField(
      name: name,
      type: type,
      isRequired: isRequired,
      isFinal: isFinal,
    );
  }
}
