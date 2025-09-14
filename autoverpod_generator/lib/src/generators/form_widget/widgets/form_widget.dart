import 'package:autoverpod_generator/src/generators/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';

String generateFormScopeWidget(ProviderDefinition provider) {
  String buildReturn() {
    if (!provider.isAsyncValue) {
      return '''
if (widget.builder != null) {
  return widget.builder!(
    context,
    ${provider.formBaseProxyWidgetName}(ref),
    widget.child,
  );
}

return widget.child!;
''';
    }

    return '''
final isInitializedAsync = ref.watch(
  ${provider.providerNameWithFamily(prefix: 'widget')}.select((dataAsync) => dataAsync.whenData((_) => true)),
);

return isInitializedAsync.when(
          skipLoadingOnReload: true,
          skipLoadingOnRefresh: true,
          data: (_) {
            if (widget.builder != null) {
              return widget.builder!(
                context,
                ${provider.formBaseProxyWidgetName}(ref),
                widget.child,
              );
            }

            return widget.child!;
          },
          error: (error, stack) =>
              widget.onInitError?.call(error, stack) ??
              Theme.of(context).extension<KimappThemeExtension>()?.defaultErrorStateWidget?.call(
                    context,
                    ref,
                    error,
                  ) ??
              const SizedBox.shrink(),
          loading: () {
            return widget.onInitLoading?.call() ??
                Theme.of(context)
                    .extension<KimappThemeExtension>()
                    ?.defaultLoadingStateWidget
                    ?.call(context, ref) ??
                const Center(child: CircularProgressIndicator());
          },
        );
''';
  }

  return '''
class ${provider.formScopeWidgetName} extends ConsumerStatefulWidget {
  const ${provider.formScopeWidgetName}({
    super.key,${provider.familyParametersAsClassFields().map((e) => e.toNamedConstructorField()).join('\n')}
    this.formKey,
    this.autovalidateMode,
    this.onPopInvokedWithResult,
    required this.builder,
    this.child,
    this.onSucceed,
    ${provider.isAsyncValue ? '''
    this.onInitLoading,
    this.onInitError,''' : ''}
  }) : assert(child != null || builder != null, 'Either child or builder must be provided');
  ${provider.familyParametersAsClassFields().map((e) => e.toClassField()).join('\n')}
  final Widget Function(
    BuildContext context,
    ${provider.formBaseProxyWidgetName} ref,
    Widget? child,
  )? builder;
  final Widget? child;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;
  final void Function(bool, Object?)? onPopInvokedWithResult;
  final void Function(BuildContext context, ${provider.getSubmitMethodInfo().rawResultType} value)? onSucceed;
  ${provider.isAsyncValue ? '''
  final Widget Function()? onInitLoading;
  final Widget Function(Object error, StackTrace stack)? onInitError;
  ''' : ''}

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _${provider.formScopeWidgetName}State();
}

class _${provider.formScopeWidgetName}State extends ConsumerState<${provider.formScopeWidgetName}> {
  late final GlobalKey<FormState> _cachedFormKey;

  @override
  void initState() {
    super.initState();
    _cachedFormKey = widget.formKey ?? GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _cachedFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      ${provider.callStatusProviderNameWithFamily(prefix: 'widget')},
      (previous, next) {
        if (previous?.hasValue == false && next?.hasValue == true) {
          widget.onSucceed?.call(context, next!.requireValue);
        }
      },
    );

    return ${provider.formInheritedWidgetName}(
      formKey: _cachedFormKey, ${provider.hasFamily ? """params:  ${provider.familyAsRecordBindString(prefix: 'widget')},""" : ""}
      child: Form(
        key: _cachedFormKey,
        autovalidateMode: widget.autovalidateMode,
        onPopInvokedWithResult: widget.onPopInvokedWithResult,
        child: Consumer(
          builder: (context, ref, child) {
            ${buildReturn()}
          },
        ),
      ),
    );
  }
}
  ''';
}
