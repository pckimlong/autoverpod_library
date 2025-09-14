// ignore_for_file: require_trailing_commas

import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/consumer_widget.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';

import '../state_widget_names.dart';

String generateScopeWidget(ProviderDefinition provider) {
  final isAsyncValue = provider.isAsyncValue;
  final stateType = provider.getProviderType(name: isAsyncValue ? 'asyncValue' : 'state');
  final baseReturnType = provider.returnType.baseType;
  final builderType =
      "Widget Function(BuildContext context, ${provider.proxyWidgetName} ref, $stateType, Widget? child,)?";
  final hasFamily = provider.familyParameters.isNotEmpty;

  String inheritedWidget({required String child}) {
    if (!hasFamily) return child;

    return '''
    ${provider.paramInheritedWidgetName}(
      params: ${provider.familyAsRecordBindString()},
      child: $child,
    )
    ''';
  }

  String asyncTypeBuilder() {
    if (!isAsyncValue) return 'return child ?? const SizedBox.shrink();';

    return '''
              final themeExtension = Theme.of(context).extension<KimappThemeExtension>();
              return state.when(
                skipLoadingOnReload: skipLoadingOnReload,
                skipLoadingOnRefresh: skipLoadingOnRefresh,
                data: (data) {
                  final result = this.data?.call(data) ?? child;
                  if (result == null) {
                    debugPrint('No child provided for ${provider.baseName}ProviderScope. Empty SizedBox will be returned.');
                    return const SizedBox.shrink();
                  }
                  return result;
                },
                error: (error, stack) =>
                    this.error?.call(error, stack) ?? 
                    themeExtension?.defaultErrorStateWidget?.call(context, ref, error) ??
                    const SizedBox.shrink(),
                loading: () => loading?.call() ?? 
                    themeExtension?.defaultLoadingStateWidget?.call(context, ref) ??
                    const SizedBox.shrink(),
              );
    ''';
  }

  return generateConsumerWidget(
    name: provider.providerScopeName,
    fields: [
      ...provider.familyParameters.map((p) => p.toClassField()),
      if (isAsyncValue) ...[
        ClassField(name: 'loading', type: 'Widget Function()?', isRequired: false),
        ClassField(
          name: 'error',
          type: 'Widget Function(Object error, StackTrace? stackTrace)?',
          isRequired: false,
        ),
        ClassField(name: 'data', type: 'Widget Function($baseReturnType data)?', isRequired: false),
        ClassField(
            name: 'skipLoadingOnReload', type: 'bool', isRequired: false, defaultValue: 'true'),
        ClassField(
            name: 'skipLoadingOnRefresh', type: 'bool', isRequired: false, defaultValue: 'true'),
      ],
      ClassField(name: 'builder', type: builderType, isRequired: false),
      ClassField(name: 'child', type: 'Widget?', isRequired: false),
      ClassField.providerListenable('onStateChanged', provider.getProviderType()),
    ],
    build: '''
if (onStateChanged != null) {
  ref.listen(${provider.providerNameWithFamily()}, onStateChanged!);
}

return ${inheritedWidget(child: '''
 Consumer(
  child: child,
  builder: (context, ref, child) {
    final state = ref.watch(${provider.providerNameWithFamily()});

    if (builder != null) {
      return builder!(context, ${provider.proxyWidgetName}(ref), state, child);
    }
    
    ${asyncTypeBuilder()}
  },
 )
''')};
''',
  );
}
