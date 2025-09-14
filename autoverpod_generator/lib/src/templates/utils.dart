class ClassField {
  final String name;
  final String type;
  final bool _isRequired;
  String? defaultValue;
  final List<String> comment;
  bool isFinal;

  ClassField({
    required this.name,
    required this.type,
    bool isRequired = true,
    this.defaultValue,
    this.comment = const [],
    this.isFinal = true,
  }) : _isRequired = isRequired;

  bool get isNullable => type.contains('?');

  bool get isRequired => _isRequired || (!isNullable && defaultValue == null);

  bool get isOptional => !isRequired;

  String get typeWithNoNullable =>
      isNullable ? type.substring(0, type.length - 1) : type;

  String toClassField() {
    final text = '${isFinal ? 'final' : ''} $type $name;';

    if (comment.isNotEmpty) {
      return '/// ${comment.join('\n/// ')}\n$text';
    }

    return text;
  }

  String toNamedConstructorField({bool commaSeperator = true}) {
    String text;

    if (defaultValue != null) {
      text = 'this.$name = $defaultValue';
    } else if (isOptional && isNullable) {
      text = 'this.$name';
    } else {
      text = 'required this.$name';
    }

    return text + (commaSeperator ? "," : "");
  }

  /// Wrap type with something else. eg. int => AsynValue<int>
  String wrapTypeWith(String wrapper) {
    return '$wrapper<$type>';
  }

  factory ClassField.providerListenable(
    String name,
    String type, {
    bool bothNullable = false,
  }) {
    return ClassField(
      name: name,
      type:
          'void Function($type? previous, $type${bothNullable ? '?' : ''} next)?',
      isRequired: false,
    );
  }
}

String returnContent(StringBuffer buffer, {required bool comment}) {
  if (comment) {
    return '/*\n${buffer.toString()}\n*/';
  }

  return buffer.toString();
}
