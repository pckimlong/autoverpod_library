import 'package:flutter/widgets.dart';

/// Reference object providing access to text controller and update function.
class StringFieldRef {
  const StringFieldRef({required this.controller, required this.update});

  /// The text editing controller for the field.
  final TextEditingController controller;

  /// Update function to sync value back to state.
  final ValueChanged<String> update;
}

/// A helper widget that handles TextEditingController synchronization
/// with a String value.
///
/// This widget manages the bidirectional sync between a String value and
/// a TextEditingController, eliminating boilerplate in generated field widgets.
class StringField extends StatefulWidget {
  const StringField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.builder,
    this.controller,
  });

  /// The current value to display. If null, treated as empty string.
  final String? value;

  /// Called when the text changes.
  final ValueChanged<String> onChanged;

  /// Optional external controller. If not provided, one is created internally.
  final TextEditingController? controller;

  /// Builder function that receives context and a ref with controller access.
  final Widget Function(BuildContext context, StringFieldRef ref) builder;

  @override
  State<StringField> createState() => _StringFieldState();
}

class _StringFieldState extends State<StringField> {
  late TextEditingController _controller;
  bool _isInternalController = false;

  String get _effectiveValue => widget.value ?? '';

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    if (widget.controller != null) {
      _controller = widget.controller!;
      _isInternalController = false;
      // Sync initial value to external controller if empty
      if (_controller.text.isEmpty && _effectiveValue.isNotEmpty) {
        _controller.text = _effectiveValue;
      }
    } else {
      _controller = TextEditingController(text: _effectiveValue);
      _isInternalController = true;
    }
    _controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(StringField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle controller change
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_handleControllerChanged);
      if (_isInternalController) {
        _controller.dispose();
      }
      _initController();
    } else if (widget.value != oldWidget.value &&
        widget.value != _controller.text) {
      // Sync value to controller
      _controller.text = _effectiveValue;
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
    final text = _controller.text;
    if (text != widget.value) {
      widget.onChanged(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      StringFieldRef(controller: _controller, update: widget.onChanged),
    );
  }
}
