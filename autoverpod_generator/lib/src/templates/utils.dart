class ClassField {
  final String name;
  final String type;
  final bool _isRequired;
  String? defaultValue;
  bool isFinal;

  ClassField({
    required this.name,
    required this.type,
    bool isRequired = true,
    this.defaultValue,
    this.isFinal = true,
  }) : _isRequired = isRequired;

  bool get isNullable => type.contains('?');
  bool get isRequired => _isRequired || (!isNullable && defaultValue == null);
  bool get isOptional => !isRequired;

  String toClassField() {
    return '${isFinal ? 'final' : ''} $type $name;';
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
}

String returnContent(StringBuffer buffer, {required bool comment}) {
  if (comment) {
    return '/*\n${buffer.toString()}\n*/';
  }
  return buffer.toString();
}
