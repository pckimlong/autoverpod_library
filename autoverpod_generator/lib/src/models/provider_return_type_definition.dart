// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unintended_html_in_doc_comment

import 'package:analyzer/dart/element/type.dart';
import 'package:autoverpod_generator/src/models/class_definition.dart';

class ProviderReturnTypeDefinition {
  final String rawType;

  /// Base provider return type, eg Future<int> -> int,
  final String baseType;

  /// Outer type, eg Future<int> -> Future, Stream<int> -> Stream
  final String? wrapperType;

  /// Class info, depends on the base type, if it is raw type, then this is null, if it is a class type, then this is the class info
  final ClassDefinition? classInfo;

  ProviderReturnTypeDefinition({
    required this.rawType,
    required this.baseType,
    required this.wrapperType,
    required this.classInfo,
  });

  String get baseTypeNonNullable => baseType.replaceAll('?', '');

  factory ProviderReturnTypeDefinition.parse(
    DartType type, {
    bool parseClassInfo = false,
  }) {
    final isGeneric =
        type is ParameterizedType && type.typeArguments.isNotEmpty;
    final wrapperType = type is InterfaceType ? type.element.name : null;
    final isAsync = ['Future', 'Stream', 'FutureOr'].contains(wrapperType);
    String baseType = type.toString();
    if (isGeneric) {
      // We interest on base type and wrapper type only when the first type argument is not Future or Stream
      // this mean IList, Map etc are not included
      if (isAsync) {
        baseType = type.typeArguments.first.toString();
      } else {
        baseType = type.getDisplayString();
      }
    }

    return ProviderReturnTypeDefinition(
      rawType: type.getDisplayString(),
      baseType: baseType,
      wrapperType: wrapperType,
      classInfo: parseClassInfo
          ? isAsync
              ? ClassDefinition.parse(
                  (type as InterfaceType).typeArguments.first,
                  options: ClassParserOptions(),
                )
              : ClassDefinition.parse(type)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rawType': rawType,
      'baseType': baseType,
      'wrapperType': wrapperType,
      'classInfo': classInfo?.toMap(),
    };
  }
}
