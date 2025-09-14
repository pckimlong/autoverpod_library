import 'package:autoverpod_generator/src/generators/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';

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
