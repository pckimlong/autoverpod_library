import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

/// Analyzer integration shared by the generator's model readers.
class TypeUtils {
  static DartType safeReadType(DartType Function() readType) => readType();

  static bool isNullable(DartType? type) =>
      type == null || type.nullabilitySuffix == NullabilitySuffix.question;

  static String? resolveImportPath(DartType? type) {
    final uri = type?.element?.library?.uri.toString();
    return uri == null || uri.startsWith('dart:') ? null : uri;
  }

  /// Include nested generic types and types exposed by imported model fields.
  static Set<String> importsFor(ClassElement provider) {
    final imports = <String>{};
    void visit(DartType type) {
      final uri = resolveImportPath(type);
      if (uri != null) imports.add(uri);
      final alias = type.alias;
      if (alias != null) {
        final aliasUri = alias.element.library.uri.toString();
        if (!aliasUri.startsWith('dart:')) imports.add(aliasUri);
        for (final argument in alias.typeArguments) {
          visit(argument);
        }
      }
      if (type is RecordType) {
        for (final field in [...type.positionalFields, ...type.namedFields]) {
          visit(field.type);
        }
      }
      if (type is InterfaceType) {
        for (final argument in type.typeArguments) {
          visit(argument);
        }
      }
      if (type is FunctionType) {
        visit(type.returnType);
        for (final parameter in type.formalParameters) {
          visit(parameter.type);
        }
      }
    }

    final build = provider.methods.firstWhere((m) => m.name == 'build');
    visit(build.returnType);
    for (final parameter in build.formalParameters) {
      visit(parameter.type);
    }
    var state = build.returnType;
    if (state is InterfaceType &&
        [
          'Future',
          'FutureOr',
          'Stream',
          'AsyncValue',
        ].contains(state.element.name)) {
      state = state.typeArguments.first;
    }
    if (state is InterfaceType) {
      for (final field in state.element.fields.where(
        (f) => !f.isStatic && f.isPublic,
      )) {
        visit(field.type);
      }
      for (final constructor in state.element.constructors.where(
        (c) => c.isFactory && c.name == 'new',
      )) {
        for (final parameter in constructor.formalParameters) {
          visit(parameter.type);
        }
      }
    }
    imports.remove(provider.library.uri.toString());
    return imports;
  }
}
