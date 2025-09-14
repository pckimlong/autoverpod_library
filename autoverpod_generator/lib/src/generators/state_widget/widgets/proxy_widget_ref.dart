import 'package:code_builder/code_builder.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/proxy_widget_ref.dart';

import '../state_widget_names.dart';

String generateProxyWidgetRef(ProviderDefinition provider) {
  return generateBaseProxyWidgetRef(
    provider.proxyWidgetName,
    methods: [
      if (provider.hasNotifier)
        Method(
          (b) => b
            ..name = 'notifier'
            ..type = MethodType.getter
            ..returns = refer(provider.baseName)
            ..lambda = true
            ..body = Code('''
                  _ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier)
                '''),
        ),
      if (provider.hasFamily)
        Method(
          (b) => b
            ..returns = refer(provider.familyAsRecordType)
            ..name = 'params'
            ..type = MethodType.getter
            ..lambda = true
            ..body =
                Code('${provider.paramInheritedWidgetName}.of(context).params'),
        ),
    ],
  );
}
