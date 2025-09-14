import 'package:autoverpod_generator/src/generators/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/debug_check.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/consumer_widget.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';

String generateStatusWidget(ProviderDefinition provider) {
  // Check for field name conflicts
  final fields = provider.returnType.classInfo?.fields ?? [];
  final hasStatusConflict = fields.any((f) => f.name == 'status');

  return generateConsumerWidget(
    name: provider.formStatusWidgetName,
    fields: [
      ClassField(
        name: 'builder',
        type:
            'Widget Function(BuildContext context, ${provider.formBaseProxyWidgetName} ref, ${provider.getSubmitMethodInfo().asyncValueType()} status)',
      ),
      ClassField(
        name: 'onChanged',
        type:
            'void Function(${provider.getSubmitMethodInfo().asyncValueType()} previous, ${provider.getSubmitMethodInfo().asyncValueType()} next)?',
        isRequired: false,
      ),
    ],
    build: '''
${generateDebugCheckCall(provider)}
if (onChanged != null) {${provider.hasFamily ? 'final params = ${provider.formInheritedWidgetName}.of(context).params;' : ''}
    ref.listen(
      ${provider.callStatusProviderNameWithFamily(prefix: 'params')},
      (previous, next) {
        if (previous != next) {
          onChanged!(previous, next);
        }
      },
    );
}
final stateRef = ${provider.formBaseProxyWidgetName}(ref);
return builder(context, stateRef, stateRef.${hasStatusConflict ? 'formStatus' : 'status'});
''',
  );
}
