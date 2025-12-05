import 'package:autoverpod_generator/src/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';

String generateDebugCheckFunction(ProviderDefinition provider) {
  final widgetName = provider.formScopeWidgetName;
  return '''
  bool _debugCheckHas${provider.baseName}Form(BuildContext context) {
    assert(() {
      if (context.widget is! $widgetName &&
          context.findAncestorWidgetOfExactType<$widgetName>() == null) {
        
        // Check if we're in a navigation context (dialog or pushed screen)
        final isInNavigation = ModalRoute.of(context) != null;
        
        if (!isInNavigation) {
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('No $widgetName found'),
            ErrorDescription(
              '\${context.widget.runtimeType} widgets require a $widgetName widget ancestor '
              'or to be used in a navigation context with proper state management.',
            ),
          ]);
        }
        // If in navigation context, we'll return true but log a warning
        debugPrint('Widget \${context.widget.runtimeType} used in navigation without direct $widgetName');
      }
      return true;
    }());
    return true;
  }
  ''';
}

String generateDebugCheckCall(ProviderDefinition provider) {
  return '''
  _debugCheckHas${provider.baseName}Form(context);
  ''';
}
