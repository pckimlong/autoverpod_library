import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/consumer_widget.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';

import '../state_widget_names.dart';
import 'debug_check.dart';

String generateSelectWidget(ProviderDefinition provider) {
  final builderType =
      'Widget Function(BuildContext context, ${provider.subProxyWidgetName} ref, Selected value)';

  return generateConsumerWidget(
    name: provider.selectWidgetName,
    generic: 'Selected',
    fields: [
      ClassField(
        name: 'selector',
        type: 'Selected Function(${provider.returnType.baseType} state)',
        isRequired: true,
      ),
      ClassField(name: 'builder', type: builderType, isRequired: true),
      ClassField.providerListenable(
        'onStateChanged',
        'Selected',
        bothNullable: true,
      ),
    ],
    build: '''
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
final stateRef = ${provider.subProxyWidgetName}(ref);
return builder(context, stateRef, stateRef.select(selector));
    ''',
  );
}
