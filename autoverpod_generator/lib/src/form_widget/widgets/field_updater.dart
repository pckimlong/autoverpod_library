import 'package:code_builder/code_builder.dart';
import 'package:recase/recase.dart';

import '../../models/provider_definition.dart';

String generateFieldUpdaterExtension(ProviderDefinition provider) {
  return Extension(
    (b) => b
      ..name = '${provider.baseName}FieldUpdater'
      ..on = refer(provider.baseName)
      ..docs.add(
        '/// Extension that adds field update methods to the form provider.\n'
        '/// These methods allow updating individual fields that have copyWith support.',
      )
      ..methods.addAll(_generateUpdateMethods(provider)),
  ).accept(DartEmitter()).toString();
}

/// Generates field update methods for the form state.
/// Only fields that are included in the copyWith method will have update methods generated.
///
/// This extension is generated in the .widget.dart file rather than .g.dart, which allows
/// for more flexible import management. The .g.dart files are controlled by the developer
/// and have limited import capabilities.
///
/// This approach makes the provider file independent from the base provider file,
/// eliminating the need to manage complex import relationships between them.
List<Method> _generateUpdateMethods(ProviderDefinition provider) {
  final List<Method> updateMethods = [];

  // Add field-specific update methods if class info is available
  if (provider.returnType.classInfo != null) {
    final returnClass = provider.returnType.classInfo!;
    final copyWithNames = returnClass.copyWithMethod?.parameters.map((e) => e.name).toSet() ?? {};

    // Generate update methods for each field
    for (final field in returnClass.fields) {
      if (copyWithNames.contains(field.name)) {
        // Field can be updated via copyWith
        updateMethods.add(
          _generateFieldUpdateMethod(
            provider,
            field.name,
            field.type,
            provider.returnType.baseType,
          ),
        );
      }
    }
  }

  return updateMethods;
}

/// Generates a method for updating a specific field
Method _generateFieldUpdateMethod(
  ProviderDefinition provider,
  String fieldName,
  String fieldType,
  String baseType,
) {
  // Create appropriate update statement based on state type
  final newValue = fieldType == 'String?'
      ? 'newValue == null || newValue.isEmpty ? null : newValue'
      : 'newValue';

  final updateStatement = provider.isAsyncValue
      ? 'state.whenData((state) => state.copyWith($fieldName: $newValue))'
      : 'state.copyWith($fieldName: $newValue)';

  return Method(
    (b) => b
      ..name = 'update${fieldName.pascalCase}'
      ..docs.add('/// Update the $fieldName field of $baseType class.')
      ..returns = refer('void')
      ..requiredParameters.add(
        Parameter(
          (b) => b
            ..name = 'newValue'
            ..type = refer(fieldType),
        ),
      )
      ..lambda = true
      ..body = Code('state = $updateStatement'),
  );
}
