import 'package:autoverpod_generator/src/models/provider_definition.dart';

import '../state_widget_names.dart';

String generateDebugCheckFunction(ProviderDefinition provider) {
  final className = provider.providerScopeName;

  return '''
  bool _debugCheckHas$className(BuildContext context) {
    assert(() {
      if (context.widget is! $className &&
          context.findAncestorWidgetOfExactType<$className>() == null) {
        
        // Check if we're in a navigation context (dialog or pushed screen)
        final isInNavigation = ModalRoute.of(context) != null;
        
        if (!isInNavigation) {
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('No $className found'),
            ErrorDescription(
              '\${context.widget.runtimeType} widgets require a $className widget ancestor '
              'or to be used in a navigation context with proper state management.',
            ),
          ]);
        }
        // If in navigation context, we'll return true but log a warning
        debugPrint('Widget \${context.widget.runtimeType} used in navigation without direct $className');
      }
      return true;
    }());
    return true;
  }
  ''';
}

String generateDebugCheckCall(ProviderDefinition provider) {
  return '''
  _debugCheckHas${provider.providerScopeName}(context);
  ''';
}
