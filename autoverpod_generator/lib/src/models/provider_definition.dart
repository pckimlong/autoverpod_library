// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:analyzer/dart/element/element.dart';
import 'package:autoverpod_generator/src/models/provider_return_type_definition.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';
import 'package:code_builder/code_builder.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

import 'method_definition.dart';
import 'param_definition.dart';

enum ProviderType { classBased, functionBased }

enum ProviderModifier { autoDispose, family, keepAlive }

class ProviderDefinition {
  final String baseName;
  final String providerName;
  final ProviderType providerType;
  final ProviderReturnTypeDefinition returnType;
  final List<ParamDefinition> familyParameters;
  final List<MethodDefinition> methods;
  final Set<ProviderModifier> modifiers;
  final String? documentation;
  final List<String> dependencies;
  final Map<String, List<String>> genericParameters;

  bool get hasNotifier => providerType == ProviderType.classBased;
  bool get hasFamily => familyParameters.isNotEmpty;
  bool get isAsyncValue =>
      ['Future', 'Stream', 'FutureOr'].contains(returnType.wrapperType);

  ProviderDefinition({
    required this.baseName,
    required this.providerName,
    required this.providerType,
    required this.returnType,
    this.familyParameters = const [],
    this.methods = const [],
    this.modifiers = const {},
    this.documentation,
    this.dependencies = const [],
    this.genericParameters = const {},
  });

  factory ProviderDefinition.parse(
    Element element, {
    bool parseReturnTypeClassInfo = false,
  }) {
    try {
      final isClass = element is ClassElement;
      final baseName = element.name!.pascalCase;
      final providerName = '${baseName}Provider'.camelCase;
      final modifiers = _parseModifiers(element);
      final dependencies = _parseDependencies(element);
      final genericParams = _parseGenericParameters(element);
      final documentation = element.documentationComment;

      if (isClass) {
        final classElement = element;
        final buildMethod = classElement.methods.firstWhere(
          (m) => m.name == 'build',
          orElse: () => throw InvalidGenerationSourceError(
            'Provider class must have a build method',
            element: element,
          ),
        );

        return ProviderDefinition(
          baseName: baseName,
          providerName: providerName,
          providerType: ProviderType.classBased,
          returnType: ProviderReturnTypeDefinition.parse(
            buildMethod.returnType,
            parseClassInfo: parseReturnTypeClassInfo,
          ),
          familyParameters: buildMethod.formalParameters
              .map((p) => ParamDefinition.parse(p))
              .toList(),
          methods: classElement.methods
              .map((m) => MethodDefinition.parseMethod(m))
              .toList(),
          modifiers: modifiers,
          documentation: documentation,
          dependencies: dependencies,
          genericParameters: genericParams,
        );
      } else {
        // Function-based provider
        final functionElement = element as TopLevelFunctionElement;

        return ProviderDefinition(
          baseName: baseName,
          providerName: providerName,
          providerType: ProviderType.functionBased,
          returnType:
              ProviderReturnTypeDefinition.parse(functionElement.returnType),
          familyParameters: functionElement.formalParameters
              .skip(1) // Skip first param (Ref)
              .map((p) => ParamDefinition.parse(p))
              .toList(),
          modifiers: modifiers,
          documentation: documentation,
          dependencies: dependencies,
          genericParameters: genericParams,
        );
      }
    } catch (e, stack) {
      throw InvalidGenerationSourceError(
        'Error parsing provider definition: $e\n$stack',
        element: element,
      );
    }
  }

  static Set<ProviderModifier> _parseModifiers(Element element) {
    final modifiers = <ProviderModifier>{};
    for (final metadata in element.metadata.annotations) {
      final annotation = metadata.computeConstantValue();
      if (annotation != null) {
        final type = annotation.type?.toString();
        if (type?.contains('autoDispose') == true) {
          modifiers.add(ProviderModifier.autoDispose);
        } else if (type?.contains('family') == true) {
          modifiers.add(ProviderModifier.family);
        } else if (type?.contains('keepAlive') == true) {
          modifiers.add(ProviderModifier.keepAlive);
        }
      }
    }
    return modifiers;
  }

  static List<String> _parseDependencies(Element element) {
    final dependencies = <String>[];
    if (element is ClassElement) {
      for (final field in element.fields) {
        if (field.type.toString().contains('Provider')) {
          dependencies.add(field.type.toString());
        }
      }
    }
    return dependencies;
  }

  static Map<String, List<String>> _parseGenericParameters(Element element) {
    final genericParams = <String, List<String>>{};
    if (element is ClassElement) {
      for (final typeParam in element.typeParameters) {
        final paramName = typeParam.name ?? '';
        if (paramName.isEmpty) continue;

        final bound = typeParam.bound;
        final bounds = <String>[];

        // Add the direct bound if it exists
        if (bound != null) {
          final boundStr = bound.getDisplayString();
          bounds.add(boundStr);

          // Extract any nested type arguments if present
          if (boundStr.contains('<')) {
            final startIndex = boundStr.indexOf('<') + 1;
            final endIndex = boundStr.lastIndexOf('>');
            if (startIndex < endIndex) {
              final typeArgs = boundStr.substring(startIndex, endIndex);
              bounds.addAll(typeArgs.split(',').map((t) => t.trim()));
            }
          }
        }

        genericParams[paramName] = bounds;
      }
    }
    return genericParams;
  }

  /// Gets the generic type parameter names defined in the class
  List<String> get genericTypeNames => genericParameters.keys.toList();

  /// Gets all bounds (constraints) for a specific generic type parameter
  List<String> getGenericTypeBounds(String typeName) =>
      genericParameters[typeName] ?? [];

  /// Checks if a class has any generic type parameters
  bool get hasGenericTypes => genericParameters.isNotEmpty;

  /// Gets a formatted string of all generic type parameters with their bounds
  String get genericTypeDefinition {
    if (!hasGenericTypes) return '';

    return genericParameters.entries.map((entry) {
      final typeName = entry.key;
      final bounds = entry.value;
      if (bounds.isEmpty) return typeName;
      return '$typeName extends ${bounds.join(' & ')}';
    }).join(', ');
  }

  /// Gets a formatted string of generic type parameters for use in declarations
  String get genericTypeDeclaration {
    if (!hasGenericTypes) return '';
    return '<${genericTypeNames.join(', ')}>';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baseName': baseName,
      'returnType': returnType.toMap(),
      'providerName': providerName,
      'providerType': providerType.toString(),
      'familyParameters': familyParameters.map((x) => x.toMap()).toList(),
      'methods': methods.map((x) => x.toMap()).toList(),
      'modifiers': modifiers.map((x) => x.toString).toList(),
      'documentation': documentation,
      'dependencies': dependencies,
      'genericParameters': genericParameters,
    };
  }

  List<ClassField> familyParametersAsClassFields() {
    return familyParameters.map((p) => p.toClassField()).toList();
  }

  String get familyAsRecordType {
    if (familyParameters.isEmpty) {
      return '';
    }

    return '({${familyParameters.map((p) => '${p.type} ${p.name}').join(', ')}})';
  }

  String familyAsRecordBindString({String prefix = ''}) {
    if (familyParameters.isEmpty) {
      return '';
    }

    return '(${familyParameters.map((p) => '${p.name} : ${prefix.isEmpty ? '' : '$prefix.'}${p.name}').join(', ')})';
  }

  /// Combine param with optional prefix, separated by comma
  /// param1 : {[prefix].}param1, param2 : {[prefix].}param2
  String familyBindString({String prefix = ''}) {
    if (familyParameters.isEmpty) {
      return '';
    }

    return familyParameters.map((p) {
      if (!p.isNamed) {
        return prefix.isEmpty ? p.name : '$prefix.${p.name}';
      }
      return '${p.name} : ${prefix.isEmpty ? '' : '$prefix.'}${p.name}';
    }).join(', ');
  }

  /// Already handle family For use by wrapped with read, watch etc
  /// [prefix] refer to how it relate to eg param.familyField1, param.familyField2
  String providerNameWithFamily({String prefix = ''}) {
    if (familyParameters.isEmpty) {
      return providerName;
    }

    return '$providerName(${familyBindString(prefix: prefix)})';
  }

  String readNotifierString({String ref = 'ref'}) {
    return '$ref.read(${providerNameWithFamily()}.notifier)';
  }

  /// Returns the provider's type, handling both synchronous and asynchronous cases
  ///
  /// For asynchronous providers (Future/Stream), wraps the base type in AsyncValue:
  /// - Future<int> becomes AsyncValue<int>
  /// - Stream<String> becomes AsyncValue<String>
  ///
  /// For synchronous providers, returns the base type directly:
  /// - int remains int
  /// - String remains String
  ///
  /// If [name] is provided, appends it to create a type declaration:
  /// - getProviderType(name: "value") with Future<int> returns "AsyncValue<int> value"
  String getProviderType({String? name}) {
    final type = isAsyncValue
        ? 'AsyncValue<${returnType.baseType}>'
        : returnType.baseType;

    if (name != null) {
      return '$type $name';
    }

    return type;
  }

  SubmitMethodInfo getSubmitMethodInfo() {
    final submitMethod = methods.firstWhereOrNull((m) => m.name == 'submit');
    final resultType = submitMethod?.returnType ?? 'Future<void>';

    final rawResultType = resultType.contains('Future')
        ? resultType.replaceFirst('Future<', '').replaceFirst('>', '')
        : resultType;

    final futureResultType =
        resultType.contains('Future') ? resultType : 'Future<$resultType>';

    return SubmitMethodInfo(
      resultType: resultType,
      rawResultType: rawResultType,
      futureResultType: futureResultType,
      namedParams:
          submitMethod?.codeBuilderParams().where((p) => p.named).toList() ??
              [],
      positionalParams:
          submitMethod?.codeBuilderParams().where((p) => !p.named).toList() ??
              [],
    );
  }
}

class SubmitMethodInfo {
  final String resultType;
  final String rawResultType;
  final String futureResultType;
  final List<Parameter> namedParams;
  final List<Parameter> positionalParams;

  SubmitMethodInfo({
    required this.resultType,
    required this.rawResultType,
    required this.futureResultType,
    required this.namedParams,
    required this.positionalParams,
  });

  String asyncValueType({bool isNullable = true, bool isFuture = false}) {
    final async = 'AsyncValue<$rawResultType>${isNullable ? '?' : ''}';
    if (isFuture) {
      return 'Future<$async>';
    }
    return async;
  }
}
