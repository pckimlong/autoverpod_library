import 'package:autoverpod_generator/src/generators/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/consumer_widget.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';

import 'debug_check.dart';

String generateParamWidget(ProviderDefinition provider) {
  if (!provider.hasFamily) return '';

  final builderType =
      "Widget Function(BuildContext context, ${provider.formBaseProxyWidgetName} ref, ${provider.familyAsRecordType} params)";

  return generateConsumerWidget(
    name: provider.formParamWidgetName,
    fields: [ClassField(name: 'builder', type: builderType, isRequired: true)],
    build: '''
${generateDebugCheckCall(provider)}
final params = ${provider.formInheritedWidgetName}.of(context).params;
return builder(context, ${provider.formBaseProxyWidgetName}(ref), params);
  ''',
  );
}

String generateParamWidgetWrapper(
  ProviderDefinition provider, {
  required String child,
}) {
  if (!provider.hasFamily) return child;

  return '''
  ${provider.formParamWidgetName}(
    builder: (context, ref, params) => $child,
  )
  ''';
}
