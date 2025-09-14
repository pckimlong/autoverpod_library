import 'package:analyzer/dart/element/element.dart';
import 'package:autoverpod/autoverpod.dart';
import 'package:autoverpod_generator/src/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

import '../models/provider_definition.dart';

/// Generator that creates provider extensions and helper methods for form state management.
/// This generator outputs to .g.dart files and handles:
/// - Form state management
/// - Submit functionality
/// - Success/error handling
/// - Field updates
class FormProviderGenerator extends GeneratorForAnnotation<FormWidget> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'FormWidget annotation can only be applied to classes.',
        element: element,
      );
    }

    final provider = ProviderDefinition.parse(element, parseReturnTypeClassInfo: true);
    final buffer = StringBuffer();

    // Add descriptive header comment
    buffer.writeln(_generateHeaderComment(provider));
    buffer.writeln();

    // Generate the form provider abstraction
    buffer.writeln(_generateFormProviderAbstraction(provider));
    return returnContent(buffer, comment: false);
  }

  /// Generates a descriptive header comment for the generated form provider file
  String _generateHeaderComment(ProviderDefinition provider) {
    final buffer = StringBuffer();

    buffer.writeln(
      '// ============================================================================',
    );
    buffer.writeln('// AUTOVERPOD GENERATED FORM PROVIDER - DO NOT MODIFY BY HAND');
    buffer.writeln(
      '// ============================================================================',
    );
    buffer.writeln('//');
    buffer.writeln('// Generated from: ${provider.providerName}');
    buffer.writeln('//');
    buffer.writeln('// GENERATED PROVIDER:');
    buffer.writeln('// - ${provider.callStatusProviderName}: Form submission status provider');
    buffer.writeln('//');
    buffer.writeln('// ABSTRACT CLASS: _\$${provider.baseName}Widget');
    buffer.writeln('// - call(): Submit form with validation and status handling');
    buffer.writeln('// - submit(): Override to implement form submission logic');
    buffer.writeln('// - onSuccess(): Override to handle successful submissions');
    buffer.writeln('//');

    return buffer.toString();
  }
}

/// Contains information about the state provider
class StateProviderInfo {
  final String declaration;
  final String readProvider;
  final Field statusProvider;

  StateProviderInfo({
    required this.declaration,
    required this.readProvider,
    required this.statusProvider,
  });
}

/// Generates the form provider abstraction code including:
/// - State management
/// - Submit functionality
/// - Field update methods
/// - Success/error handling
String _generateFormProviderAbstraction(ProviderDefinition provider) {
  final submitMethodInfo = provider.getSubmitMethodInfo();
  final stateProviderInfo = _generateStateProviderInfo(provider, submitMethodInfo);
  final updateMethods = _generateUpdateMethods(provider);

  // Generate the proxy class using code_builder
  final proxyClass = Class(
    (b) => b
      ..name = '_\$${provider.baseName}Widget'
      ..abstract = true
      ..extend = refer('_\$${provider.baseName}')
      ..methods.addAll([
        _generateOnSuccessMethod(provider, submitMethodInfo.rawResultType),
        _generateCallMethod(provider, submitMethodInfo, stateProviderInfo),
        _generateInvalidateSelfMethod(provider),
        _generateSubmitMethod(provider, submitMethodInfo),
        ...updateMethods,
      ]),
  ).accept(DartEmitter()).toString();

  // Create the call status provider declaration
  final callStatusDeclaration =
      'StateProvider.autoDispose'
      '${provider.hasFamily ? ".family" : ""}'
      '<AsyncValue<${submitMethodInfo.rawResultType}>?'
      '${provider.hasFamily ? ",${provider.familyAsRecordType}" : ""}>'
      '((ref${provider.hasFamily ? " ,_" : ""}) => null)';

  // Return the complete generated code
  return '''
final ${provider.callStatusProviderName} = $callStatusDeclaration;

$proxyClass
''';
}

/// Generates state provider information
StateProviderInfo _generateStateProviderInfo(
  ProviderDefinition provider,
  SubmitMethodInfo submitInfo,
) {
  // Create the provider declaration
  final declaration =
      'StateProvider.autoDispose'
      '${provider.hasFamily ? ".family" : ""}'
      '<AsyncValue<${submitInfo.rawResultType}>?'
      '${provider.hasFamily ? ",${provider.familyAsRecordType}" : ""}>'
      '((ref${provider.hasFamily ? " ,_" : ""}) => null)';

  // Create the provider read expression
  final readProvider =
      "${provider.callStatusProviderName}"
      "${provider.hasFamily ? "(${provider.familyAsRecordBindString()})" : ""}";

  // Create the field definition
  final statusProvider = Field(
    (b) => b
      ..name = provider.callStatusProviderName
      ..static = false
      ..modifier = FieldModifier.final$
      ..assignment = Code(declaration),
  );

  return StateProviderInfo(
    declaration: declaration,
    readProvider: readProvider,
    statusProvider: statusProvider,
  );
}

/// Generates field update methods for the form state
List<Method> _generateUpdateMethods(ProviderDefinition provider) {
  final List<Method> updateMethods = [];

  // Add the general state update method
  updateMethods.add(_generateStateUpdateMethod(provider));

  // Add field-specific update methods if class info is available
  if (provider.returnType.classInfo != null) {
    final returnClass = provider.returnType.classInfo!;
    final copyWithNames = returnClass.copyWithMethod?.parameters.map((e) => e.name).toSet() ?? {};

    // Generate update methods for each field where not in copyWith method
    // this allow developer to override it
    for (final field in returnClass.fields) {
      if (!copyWithNames.contains(field.name)) {
        updateMethods.add(
          Method(
            (b) => b
              ..name = 'update${field.name.pascalCase}'
              ..returns = refer('void')
              ..requiredParameters.add(
                Parameter(
                  (b) => b
                    ..name = 'newValue'
                    ..type = refer(field.type),
                ),
              )
              ..docs.add(
                '/// Update the ${field.name} field of ${returnClass.name} class.\n'
                '/// Please override this method and manually update the field\n'
                '/// since it is not available through copyWith method.',
              ),
          ),
        );
      }
    }
  }

  return updateMethods;
}

/// Generates a method for updating the entire state
Method _generateStateUpdateMethod(ProviderDefinition provider) {
  // Create appropriate update statement based on state type
  final updateStatement = provider.isAsyncValue
      ? 'this.state.whenData(update)'
      : 'update(this.state)';

  return Method(
    (b) => b
      ..name = 'updateState'
      ..returns = refer('void')
      ..docs.add(
        '/// Update the state of the form.\n'
        '/// This allows for more flexible updates to specific fields.',
      )
      ..requiredParameters.add(
        Parameter(
          (b) => b
            ..name = 'update'
            ..type = refer(
              '${provider.returnType.baseType} Function(${provider.returnType.baseType} state)',
            ),
        ),
      )
      ..lambda = true
      ..body = Code('this.state = $updateStatement'),
  );
}

/// Generates the onSuccess callback method
Method _generateOnSuccessMethod(ProviderDefinition provider, String rawResultType) {
  final hasOverride = provider.methods.any((e) => e.name == 'onSuccess');
  return Method(
    (b) => b
      ..name = 'onSuccess'
      ..annotations.add(refer('protected'))
      ..returns = refer('void')
      ..docs.add(
        '/// Callback for when the form is successfully submitted.\n'
        '/// Override this method and run "dart pub run build_runner build" to make it work. otherwise error will be thrown.',
      )
      ..requiredParameters.add(
        Parameter(
          (b) => b
            ..name = 'result'
            ..type = refer(rawResultType),
        ),
      )
      ..lambda = !hasOverride
      ..body = hasOverride
          ? null
          : Code(
              "throw UnimplementedError('This error occurred because you overrode the method without running build_runner. Please run [dart pub run build_runner build] to generate the necessary code.')",
            ),
  );
}

/// Generates the call method that handles form submission
Method _generateCallMethod(
  ProviderDefinition provider,
  SubmitMethodInfo submitInfo,
  StateProviderInfo stateInfo,
) {
  final hasOverrideOnSuccess = provider.methods.any((e) => e.name == 'onSuccess');
  // Check if form is loaded based on state type
  final loadingCheck = provider.isAsyncValue
      ? '''
  // Ignore if form is not loaded yet
  if (this.state.isLoading) return const AsyncValue.loading();
  // Cannot submit when form is not loaded yet
  if (this.state.hasValue == false) return const AsyncValue.loading();
'''
      : '';

  return Method(
    (b) => b
      ..name = 'call'
      ..annotations.addAll([refer('nonVirtual')])
      ..modifier = MethodModifier.async
      ..returns = refer(provider.callFunctionReturnType)
      ..requiredParameters.addAll(
        submitInfo.positionalParams.where((e) => e.name != 'state').toList(),
      )
      ..optionalParameters.addAll(submitInfo.namedParams)
      ..body = Code('''
$loadingCheck

final _callStatus = this.ref.read(${stateInfo.readProvider});
final _updateCallStatus = this.ref.read(${stateInfo.readProvider}.notifier);

if (_callStatus?.isLoading == true) return const AsyncValue.loading();

if (_callStatus?.hasValue == true) {
  return _callStatus!;
}

_updateCallStatus.state = const AsyncValue.loading();
final result = await AsyncValue.guard(() async => await submit(
  ${submitInfo.positionalParams.map((e) {
        if (e.name == 'state') {
          if (provider.isAsyncValue) {
            return 'this.state.requireValue';
          } else {
            return 'this.state';
          }
        }
        return e.name;
      }).join(', ')}
  ${submitInfo.namedParams.isNotEmpty ? "${submitInfo.positionalParams.isNotEmpty ? ',' : ''}${submitInfo.namedParams.map((e) => "${e.name}: ${e.name}").join(', ')}" : ""}
));

_updateCallStatus.state = result;

${hasOverrideOnSuccess ? '''if (result.hasValue) {
  onSuccess(result.requireValue);
}''' : ''}

return result;
'''),
  );
}

/// Generates the invalidateSelf method
Method _generateInvalidateSelfMethod(ProviderDefinition provider) {
  return Method(
    (b) => b
      ..name = 'invalidateSelf'
      ..returns = refer('void')
      ..body = Code(
        'this.ref.invalidate(${provider.callStatusProviderName});\nthis.ref.invalidateSelf();',
      ),
  );
}

/// Generates the submit method signature
Method _generateSubmitMethod(ProviderDefinition provider, SubmitMethodInfo submitInfo) {
  return Method(
    (b) => b
      ..name = 'submit'
      ..annotations.addAll([refer('visibleForOverriding'), refer('protected')])
      ..docs.addAll([
        '/// Internal submit implementation for form submission.',
        '/// ',
        '/// ⚠️ WARNING: Do not call this method directly - use [call] instead.',
        '/// Direct usage bypasses:',
        '/// - Error handling',
        '/// - Loading state management ',
        '/// - Success callback handling',
        '/// - Form validation',
        '/// ',
        '/// This method should be overridden to implement the actual form submission logic:',
        '/// 1. Validate form data',
        '/// 2. Transform data if needed',
        '/// 3. Call API/repository methods',
        '/// 4. Return success/failure result',
      ])
      ..modifier = MethodModifier.async
      ..returns = refer(submitInfo.futureResultType)
      ..requiredParameters.addAll([
        if (!submitInfo.positionalParams.any((e) => e.name == 'state'))
          Parameter(
            (b) => b
              ..name = 'state'
              ..type = refer(provider.returnType.baseType),
          ),
      ])
      ..requiredParameters.addAll(submitInfo.positionalParams)
      ..optionalParameters.addAll(submitInfo.namedParams),
  );
}
