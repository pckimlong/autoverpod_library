// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:analyzer/dart/element/element.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';

class ParamDefinition {
  final String name;
  final String type;
  final bool isRequired;
  final bool isNamed;
  final String? defaultValue;
  final List<String> annotations;
  final String? documentation;

  ParamDefinition({
    required this.name,
    required this.type,
    this.isRequired = true,
    this.isNamed = true,
    this.defaultValue,
    this.annotations = const [],
    this.documentation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'isRequired': isRequired,
      'isNamed': isNamed,
      'defaultValue': defaultValue,
      'annotations': annotations,
      'documentation': documentation,
    };
  }

  factory ParamDefinition.parse(ParameterElement parameter) {
    return ParamDefinition(
      name: parameter.name,
      type: parameter.type.getDisplayString(),
      isRequired: parameter.isRequired,
      isNamed: parameter.isNamed,
      defaultValue: parameter.defaultValueCode,
      annotations: parameter.metadata.map((m) => m.toSource()).toList(),
      documentation: parameter.documentationComment,
    );
  }

  ClassField toClassField({bool isFinal = true}) {
    return ClassField(
      name: name,
      type: type,
      isRequired: isRequired,
      defaultValue: defaultValue,
      comment: [if (documentation != null) documentation!],
      isFinal: isFinal,
    );
  }
}
