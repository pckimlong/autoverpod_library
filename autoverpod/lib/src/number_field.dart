import 'package:flutter/widgets.dart';

/// Reference object providing access to text controller and update function.
class NumberFieldRef<T extends num> {
  const NumberFieldRef({required this.controller, required this.update});

  /// The text editing controller for the field.
  final TextEditingController controller;

  /// Update function to sync value back to state.
  ///
  /// For non-nullable fields, generated widgets will ignore `null` updates.
  final ValueChanged<T?> update;
}

/// A helper widget that handles TextEditingController synchronization
/// with a numeric value.
///
/// This widget manages the bidirectional sync between a numeric value and
/// a TextEditingController, eliminating boilerplate in generated number field
/// widgets. It supports `int`, `double`, and `num` fields.
class NumberField<T extends num> extends StatefulWidget {
  const NumberField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.builder,
    this.controller,
    this.formatter,
    this.parser,
  });

  /// The current value to display. If null, treated as empty string.
  final T? value;

  /// Called when the parsed number changes.
  ///
  /// If the text cannot be parsed, `null` is passed.
  final ValueChanged<T?> onChanged;

  /// Optional external controller. If not provided, one is created internally.
  final TextEditingController? controller;

  /// Optional formatter to convert value to text.
  final String Function(T value)? formatter;

  /// Optional parser to convert text to value.
  final T? Function(String text)? parser;

  /// Builder function that receives context and a ref with controller access.
  final Widget Function(BuildContext context, NumberFieldRef<T> ref) builder;

  @override
  State<NumberField<T>> createState() => _NumberFieldState<T>();
}

class _NumberFieldState<T extends num> extends State<NumberField<T>> {
  late TextEditingController _controller;
  bool _isInternalController = false;

  String _format(T? value) {
    if (value == null) return '';
    final formatter = widget.formatter;
    if (formatter != null) return formatter(value);
    return value.toString();
  }

  T? _parse(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return null;
    final parser = widget.parser;
    if (parser != null) return parser(trimmed);
    if (T == int) return int.tryParse(trimmed) as T?;
    if (T == double) return double.tryParse(trimmed) as T?;
    return num.tryParse(trimmed) as T?;
  }

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    if (widget.controller != null) {
      _controller = widget.controller!;
      _isInternalController = false;
      if (_controller.text.isEmpty && widget.value != null) {
        _controller.text = _format(widget.value);
      }
    } else {
      _controller = TextEditingController(text: _format(widget.value));
      _isInternalController = true;
    }
    _controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(NumberField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_handleControllerChanged);
      if (_isInternalController) {
        _controller.dispose();
      }
      _initController();
    } else if (widget.value != oldWidget.value) {
      final formatted = _format(widget.value);
      if (formatted != _controller.text) {
        _controller.text = formatted;
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
    if (_isInternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleControllerChanged() {
    final parsed = _parse(_controller.text);
    if (parsed != widget.value) {
      widget.onChanged(parsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      NumberFieldRef<T>(controller: _controller, update: widget.onChanged),
    );
  }
}

