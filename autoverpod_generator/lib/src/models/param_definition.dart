import 'package:lean_builder/element.dart';

import '../templates/utils.dart';
import 'type_utils.dart';

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
    final type = TypeUtils.safeReadType(() => parameter.type);
    final importPath = TypeUtils.resolveImportPath(type);

    return ParamDefinition(
      name: parameter.name,
      type: type?.toString() ?? 'dynamic',
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
