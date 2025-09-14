import 'package:autoverpod_generator/src/generators/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/proxy_widget_ref.dart';
import 'package:code_builder/code_builder.dart';

String generateFormBaseProxyWidgetRef(ProviderDefinition provider) {
  // Check for field name conflicts
  final fields = provider.returnType.classInfo?.fields ?? [];
  final hasStatusConflict = fields.any((f) => f.name == 'status');
  final hasSelectConflict = fields.any((f) => f.name == 'select');
  final hasParamsConflict = fields.any((f) => f.name == 'params');
  final hasFormKeyConflict = fields.any((f) => f.name == 'formKey');
  final hasNotifierConflict = fields.any((f) => f.name == 'notifier');
  final hasSubmitConflict = fields.any((f) => f.name == 'submit');

  return generateBaseProxyWidgetRef(
    provider.formBaseProxyWidgetName,
    methods: [
      if (provider.hasFamily)
        Method(
          (b) => b
            ..returns = refer(provider.familyAsRecordType)
            ..name = hasParamsConflict ? 'formParams' : 'params'
            ..type = MethodType.getter
            ..lambda = true
            ..docs.addAll([
              if (hasParamsConflict)
                '/// Access the form parameters. Using formParams to avoid conflict with field named "params".',
            ])
            ..body =
                Code('${provider.formInheritedWidgetName}.of(context).params'),
        ),
      Method(
        (b) => b
          ..name = hasStatusConflict ? 'formStatus' : 'status'
          ..type = MethodType.getter
          ..returns = refer(provider.getSubmitMethodInfo().asyncValueType())
          ..lambda = true
          ..docs.addAll([
            if (hasStatusConflict)
              '/// Access the form submission status. Using formStatus to avoid conflict with field named "status".',
          ])
          ..body = Code('''
              _ref.watch(${provider.callStatusProviderNameWithFamily(prefix: 'params')})
              '''),
      ),
      Method(
        (b) => b
          ..name = hasFormKeyConflict ? 'getFormKey' : 'formKey'
          ..type = MethodType.getter
          ..returns = refer('GlobalKey<FormState>')
          ..lambda = true
          ..docs.addAll([
            if (hasFormKeyConflict)
              '/// Access the form key. Using getFormKey to avoid conflict with field named "formKey".',
          ])
          ..body =
              Code('${provider.formInheritedWidgetName}.of(context).formKey'),
      ),
      Method(
        (b) => b
          ..name = hasNotifierConflict ? 'formNotifier' : 'notifier'
          ..type = MethodType.getter
          ..returns = refer(provider.baseName)
          ..lambda = true
          ..docs.addAll([
            if (hasNotifierConflict)
              '/// Access the form notifier. Using formNotifier to avoid conflict with field named "notifier".',
          ])
          ..body = Code('''
              _ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier)
              '''),
      ),
      Method((b) {
        final submitInfo = provider.getSubmitMethodInfo();

        final positionalParamsString = submitInfo.positionalParams
            .where((e) => e.name != 'state')
            .map((param) => param.name)
            .join(', ');

        final namedParamsString = submitInfo.namedParams
            .map((param) => '${param.name}: ${param.name}')
            .join(', ');

        String callParams = '';
        if (positionalParamsString.isNotEmpty && namedParamsString.isNotEmpty) {
          callParams = '$positionalParamsString, $namedParamsString';
        } else if (positionalParamsString.isNotEmpty) {
          callParams = positionalParamsString;
        } else if (namedParamsString.isNotEmpty) {
          callParams = namedParamsString;
        }

        b
          ..name = hasSubmitConflict ? 'formSubmit' : 'submit'
          ..returns = refer(provider.callFunctionReturnType)
          ..docs.addAll([
            '/// Submits the form. Internally this calls [notifier.submit] with the form key validated.',
            if (hasSubmitConflict)
              '/// Using formSubmit to avoid conflict with field named "submit".',
          ])
          ..modifier = MethodModifier.async
          ..requiredParameters.addAll(
            submitInfo.positionalParams
                .where((e) => e.name != 'state')
                .toList(),
          )
          ..optionalParameters.addAll(submitInfo.namedParams)
          ..body = Code('''
    if (!(${hasFormKeyConflict ? 'getFormKey' : 'formKey'}.currentState?.validate() ?? false)) {
      return AsyncValue.error(Exception('Form is not valid'), StackTrace.current);
    }
    ${hasFormKeyConflict ? 'getFormKey' : 'formKey'}.currentState?.save();

    return await ${hasNotifierConflict ? 'formNotifier' : 'notifier'}($callParams);
''');
      }),
      // To force user to use select instead of state, I disabled this method, select will able to access full state too
      // Method(
      //   (b) => b
      //     ..name = hasStateConflict ? 'formState' : 'state'
      //     ..type = MethodType.getter
      //     ..lambda = true
      //     ..returns = refer(provider.returnType.baseType)
      //     ..docs.addAll([
      //       if (hasStateConflict)
      //         '/// Access the form state. Using formState to avoid conflict with field named "state".',
      //     ])
      //     ..body = Code(
      //       '_ref.watch(${provider.providerNameWithFamily(prefix: 'params')})${provider.isAsyncValue ? '.requireValue' : ''}',
      //     ),
      // ),
      Method(
        (b) => b
          ..name = hasSelectConflict ? 'formSelect' : 'select'
          ..returns = refer('Selected')
          ..types.add(refer('Selected'))
          ..docs.addAll([
            if (hasSelectConflict)
              '/// Select a value from the form state. Using formSelect to avoid conflict with field named "select".',
          ])
          ..requiredParameters.add(
            Parameter(
              (b) => b
                ..name = 'selector'
                ..type =
                    refer('Selected Function(${provider.returnType.baseType})'),
            ),
          )
          ..lambda = true
          ..body = Code(
            '_ref.watch(${provider.providerNameWithFamily(prefix: 'params')}.select((value) => selector(value${provider.isAsyncValue ? '.requireValue' : ''})))',
          ),
      ),
    ],
  );
}
