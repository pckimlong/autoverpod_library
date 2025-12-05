import 'package:autoverpod_generator/src/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/consumer_widget.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';

import 'debug_check.dart';

String generateSelectWidget(ProviderDefinition provider) {
  final builderType =
      'Widget Function(BuildContext context, ${provider.formBaseProxyWidgetName} ref, Selected value)';

  return generateConsumerWidget(
    name: provider.formSelectWidgetName,
    generic: 'Selected',
    fields: [
      ClassField(
        name: 'selector',
        type: 'Selected Function(${provider.returnType.baseType} state)',
        isRequired: true,
      ),
      ClassField(name: 'builder', type: builderType, isRequired: true),
      ClassField.providerListenable('onStateChanged', 'Selected', bothNullable: true),
    ],
    build:
        '''
${generateDebugCheckCall(provider)}
if (onStateChanged != null) {
  ${provider.paramsDeclaration}
  ref.listen(
    ${provider.providerNameWithFamily(prefix: 'params')}.select((value) => selector(value${provider.isAsyncValue ? '.requireValue' : ''})),
    (pre, next) {
      if (pre != next) onStateChanged!(pre, next);
    },
  );
}
final stateRef = ${provider.formBaseProxyWidgetName}(ref);
return builder(context, stateRef, stateRef.select(selector));
    ''',
  );
}
