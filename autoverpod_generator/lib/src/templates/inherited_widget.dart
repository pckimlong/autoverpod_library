import 'package:autoverpod_generator/src/templates/comment_generator.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';

String generateInheritedWidget({
  required String name,
  required List<ClassField> fields,
  CommentGenerator? comment,
}) {
  return '''
${comment.getContent()}class $name extends InheritedWidget {
  ${comment.getMacroRef()}
  const $name({
    ${fields.map((e) => e.toNamedConstructorField()).join('\n')}
    required super.child,
  });

  ${fields.map((e) => e.toClassField()).join('\n')}

  static $name of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<$name>()!;
  }

  @override
  bool updateShouldNotify(covariant $name oldWidget) {
    return ${fields.isEmpty ? "true" : fields.map((e) => '${e.name} != oldWidget.${e.name}').join(' && ')};
  }
}
''';
}
