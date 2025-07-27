import 'package:flutter/material.dart';
import 'package:gift_grab_ui/formz_inputs/long_text/long_text.dart';

class LongTextInput extends StatefulWidget {
  final LongText longText;
  final String? labelText;
  final String? helperText;
  final void Function(String) onChanged;

  const LongTextInput(
    this.longText, {
    this.labelText,
    this.helperText,
    required this.onChanged,
    super.key,
  });

  @override
  State<LongTextInput> createState() => _LongTextInputState();
}

class _LongTextInputState extends State<LongTextInput> {
  late TextEditingController _controller;
  bool _isInternalUpdate = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.longText.value);
  }

  @override
  void didUpdateWidget(LongTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update controller if value changed externally (not from user typing)
    if (oldWidget.longText.value != widget.longText.value &&
        !_isInternalUpdate) {
      final selection = _controller.selection;
      _controller.text = widget.longText.value;
      // Preserve cursor position if possible
      if (selection.baseOffset <= widget.longText.value.length) {
        _controller.selection = selection;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: _controller,
      onChanged: (value) {
        _isInternalUpdate = true;
        widget.onChanged(value);
        _isInternalUpdate = false;
      },
      style: theme.textTheme.displayLarge,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: theme.textTheme.displayLarge?.copyWith(color: Colors.grey),
        prefixIcon: const Icon(Icons.description),
        border: const OutlineInputBorder(),
        errorText: widget.longText.errorMessage,
        errorStyle: theme.textTheme.headlineSmall?.copyWith(color: Colors.red),
        helperText: widget.helperText,
      ),
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLines: LongText.maxLines,
      minLines: LongText.minLines,
      maxLength: LongText.max,
    );
  }
}
