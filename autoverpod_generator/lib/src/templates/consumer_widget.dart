import 'package:autoverpod_generator/src/templates/comment_generator.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';

String generateConsumerWidget({
  required String name,
  required List<ClassField> fields,
  required String build,
  CommentGenerator? comment,
  bool useHook = false,
  String? generic,
}) {
  return '''
${comment.getContent()}class $name${generic != null ? '<$generic>' : ''} extends ${useHook ? 'HookConsumerWidget' : 'ConsumerWidget'} {
  ${comment.getMacroRef()}\tconst $name({
    super.key,
    ${fields.map((e) => e.toNamedConstructorField()).join('\n')}
  });

  ${fields.map((e) => e.toClassField()).join('\n')}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    $build
  }
}''';
}
