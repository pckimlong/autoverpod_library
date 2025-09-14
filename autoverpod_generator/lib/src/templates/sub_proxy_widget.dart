import 'package:code_builder/code_builder.dart';
import 'package:autoverpod_generator/src/templates/comment_generator.dart';

String generateSubProxyWidget(
  String name, {
  required String parentName,
  List<Field> finalFields = const [],
  List<Method> methods = const [],
  CommentGenerator? classComment,
  String? generic,
}) {
  return Class(
    (b) => b
      ..docs.addAll([if (classComment != null) classComment.content])
      ..name = name + (generic != null ? '<$generic>' : '')
      ..extend = refer(parentName)
      ..fields.addAll(finalFields)
      ..methods.addAll(methods)
      ..constructors.add(
        Constructor(
          (b) => b
            ..docs.addAll([if (classComment != null) classComment.macroRef])
            ..requiredParameters.add(
              Parameter(
                (b) => b
                  ..name = '_ref'
                  ..toSuper = true,
              ),
            )
            ..optionalParameters.addAll(
              finalFields.map(
                (e) => Parameter(
                  (b) => b
                    ..toThis = true
                    ..named = true
                    ..name = e.name
                    ..required = true, // Assuming fields should be required
                ),
              ),
            ),
        ),
      ),
  ).accept(DartEmitter()).toString();
}
