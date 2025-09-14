import 'package:autoverpod_generator/src/models/provider_definition.dart';

extension StateWidgetNames on ProviderDefinition {
  String get proxyWidgetName => '_${baseName}ProxyWidgetRef';
  String get subProxyWidgetName => '_${baseName}StateProxyWidgetRef';
  String get paramInheritedWidgetName => '_${baseName}InheritedWidget';
  String get providerScopeName => '${baseName}ProviderScope';
  String get paramWidgetName => '${baseName}ParamsWidget';
  String get stateWidgetName => '${baseName}StateWidget';
  String get selectWidgetName => '${baseName}SelectWidget';

  String get paramsDeclaration {
    if (!hasFamily) return '';
    return 'final params = $paramInheritedWidgetName.of(context).params;';
  }
}
