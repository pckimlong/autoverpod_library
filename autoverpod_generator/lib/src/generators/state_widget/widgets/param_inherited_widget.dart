import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/inherited_widget.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';

import '../state_widget_names.dart';

String generateParamInheritedWidget(ProviderDefinition provider) {
  if (!provider.hasFamily) return '';
  return generateInheritedWidget(
    name: provider.paramInheritedWidgetName,
    fields: [
      ClassField(
        name: 'params',
        type: provider.familyAsRecordType,
        isRequired: true,
      ),
    ],
  );
}
