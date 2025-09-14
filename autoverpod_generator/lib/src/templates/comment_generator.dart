class CommentGenerator {
  final List<String> lines;
  final String? raw;
  final String? macro;

  const CommentGenerator({this.lines = const [], this.raw, this.macro});

  bool get hasComment => lines.isNotEmpty || (raw != null && raw!.isNotEmpty);

  String get content {
    if (!hasComment) {
      return '';
    }

    final comment = raw ?? "/// ${lines.join('\n/// ')}";

    if (macro != null) {
      return '/// {@template $macro}\n$comment\n/// {@endtemplate}';
    }

    return comment;
  }

  String get macroRef {
    if (macro != null) {
      return '/// {@macro $macro}';
    }
    return '';
  }
}

extension CommentGeneratorExtension on CommentGenerator? {
  String getContent() {
    if (this == null) return '';

    return this!.content;
  }

  String getMacroRef() {
    if (this == null) return '';

    return this!.macroRef;
  }
}
