import 'package:flutter/material.dart';
import 'package:gift_grab_ui/formz_inputs/short_text/short_text.dart';

class ShortTextInput extends StatefulWidget {
  final ShortText shortText;
  final String labelText;
  final void Function(String)? onChanged;

  const ShortTextInput(
    this.shortText, {
    required this.labelText,
    this.onChanged,
    super.key,
  });

  @override
  State<ShortTextInput> createState() => _ShortTextInputState();
}

class _ShortTextInputState extends State<ShortTextInput> {
  late TextEditingController _controller;
  bool _isInternalUpdate = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.shortText.value);
  }

  @override
  void didUpdateWidget(ShortTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update controller if value changed externally (not from user typing)
    if (oldWidget.shortText.value != widget.shortText.value &&
        !_isInternalUpdate) {
      final selection = _controller.selection;
      _controller.text = widget.shortText.value;
      // Preserve cursor position if possible
      if (selection.baseOffset <= widget.shortText.value.length) {
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
        widget.onChanged?.call(value);
        _isInternalUpdate = false;
      },
      style: theme.textTheme.displayMedium,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: theme.textTheme.displaySmall,
        prefixIcon: const Icon(Icons.person, color: Colors.white),
        border: const OutlineInputBorder(),
        errorText: widget.shortText.errorMessage,
        errorStyle: theme.textTheme.headlineSmall?.copyWith(color: Colors.red),
      ),
      textInputAction: TextInputAction.next,
      maxLength: ShortText.max,
    );
  }
}
