import 'package:autoverpod_generator/src/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/inherited_widget.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';

String generateParamInheritedWidget(ProviderDefinition provider) {
  return generateInheritedWidget(
    name: provider.formInheritedWidgetName,
    fields: [
      ClassField(name: 'formKey', type: 'GlobalKey<FormState>', isRequired: true),
      if (provider.hasFamily)
        ClassField(name: 'params', type: provider.familyAsRecordType, isRequired: true),
    ],
  );
}
