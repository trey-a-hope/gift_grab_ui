import 'package:flutter/material.dart';
import 'package:gift_grab_ui/formz_inputs/toggle/toggle.dart';

class ToggleInput extends StatelessWidget {
  final Toggle toggle;
  final String title;
  final String? subtitle;
  final void Function(bool)? onChanged;

  const ToggleInput(
    this.toggle, {
    required this.title,
    this.subtitle,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SwitchListTile(
      title: Text(title, style: theme.textTheme.displayLarge),
      subtitle: subtitle == null
          ? null
          : Text(subtitle!, style: theme.textTheme.headlineSmall),
      value: toggle.value,
      onChanged: onChanged,
    );
  }
}
