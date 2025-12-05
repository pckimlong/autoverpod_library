import 'package:autoverpod_generator/src/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/form_widget/widgets/param_widget.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/consumer_widget.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';

import 'debug_check.dart';

String generateStateWidget(ProviderDefinition provider) {
  final builderType =
      'Widget Function(BuildContext context, ${provider.formBaseProxyWidgetName} ref, Widget? child,)';
  return generateConsumerWidget(
    name: provider.formStateWidgetName,
    fields: [
      ClassField(
        name: 'builder',
        type: builderType,
        comment: [
          'The builder function that constructs the widget tree.',
          'Access the state directly via ref.state, which is equivalent to ref.watch(${provider.providerNameWithFamily(prefix: 'params')})',
          '',
          'For selecting specific fields, use ref.select() - e.g. ref.select((value) => value.someField)',
          'The ref parameter provides type-safe access to the provider state and notifier',
        ],
      ),
      ClassField(name: 'child', type: 'Widget?', isRequired: false),
      ClassField.providerListenable(
        'onStateChanged',
        provider.returnType.baseTypeNonNullable,
        bothNullable: true,
      ),
    ],
    build:
        '''
${generateDebugCheckCall(provider)}
if (onStateChanged != null) {
  ${provider.paramsDeclaration}
  ref.listen(${provider.providerNameWithFamily(prefix: 'params')}, (pre, next) {
    if (pre != next)
      onStateChanged!(${provider.isAsyncValue ? 'pre?.valueOrNull' : 'pre'}, ${provider.isAsyncValue ? 'next.valueOrNull' : 'next'});
  });
}
return ${generateParamWidgetWrapper(provider, child: 'builder(context, ${provider.formBaseProxyWidgetName}(ref), child)')};
    ''',
  );
}
