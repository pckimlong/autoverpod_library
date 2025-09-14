import 'package:analyzer/dart/element/element.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../../../autoverpod_generator.dart';
import 'widgets/debug_check.dart';
import 'widgets/param_inherited_widget.dart';
import 'widgets/param_widget.dart';
import 'widgets/proxy_widget_ref.dart';
import 'widgets/scope_widget.dart';
import 'widgets/select_widget.dart';
import 'widgets/state_widget.dart';
import 'widgets/state_widget_proxy.dart';

/// Generator for creating state-based widgets from providers
class StateWidgetGenerator extends WidgetGenerator {
  @override
  final TypeChecker annotationTypeChecker = const TypeChecker.fromRuntime(StateWidget);

  @override
  bool canProcess(Element element) {
    return annotationTypeChecker.hasAnnotationOf(element);
  }

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final provider = ProviderDefinition.parse(element);
    final buffer = StringBuffer();

    // Add descriptive header comment
    buffer.writeln(_generateHeaderComment(provider));
    buffer.writeln();

    buffer.writeln(generateParamInheritedWidget(provider));
    buffer.writeln(generateProxyWidgetRef(provider));
    buffer.writeln(generateScopeWidget(provider));
    buffer.writeln(generateDebugCheckFunction(provider));
    buffer.writeln(generateParamWidget(provider));
    buffer.writeln(generateStateWidgetProxy(provider));
    buffer.writeln(generateStateWidget(provider));
    buffer.writeln(generateSelectWidget(provider));

    return returnContent(buffer, comment: false);
  }

  /// Generates a descriptive header comment for the generated state widget file
  String _generateHeaderComment(ProviderDefinition provider) {
    final buffer = StringBuffer();

    buffer
        .writeln('// ============================================================================');
    buffer.writeln('// AUTOVERPOD GENERATED STATE WIDGET - DO NOT MODIFY BY HAND');
    buffer
        .writeln('// ============================================================================');
    buffer.writeln('//');
    buffer.writeln('// Source: ${provider.providerName}');
    buffer.writeln('//');
    buffer.writeln('// PUBLIC WIDGETS:');
    buffer.writeln('// - ${provider.baseName}Scope: Main scope widget for provider access');
    buffer.writeln('// - ${provider.baseName}Widget: Consumer widget with automatic state access');
    buffer.writeln('// - ${provider.baseName}Select: Selector widget for optimized rebuilds');
    buffer.writeln('//');

    return buffer.toString();
  }

  @override
  List<String> getRequiredImports() {
    return [
      'package:flutter_riverpod/flutter_riverpod.dart',
      'package:kimapp_utils/kimapp_utils.dart',
      'package:flutter/material.dart',
    ];
  }
}
