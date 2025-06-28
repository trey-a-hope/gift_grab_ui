import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gift_grab_ui/formz_inputs/range/range.dart';

class RangeInput extends StatelessWidget {
  final Range range;
  final String title;
  final void Function(double)? onChanged;

  const RangeInput(
    this.range, {
    required this.title,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.people, size: 20, color: Colors.white),
            const Gap(8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(color: Colors.white),
            ),
            const Spacer(),
            Text(
              '${range.value}',
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(color: Colors.white),
            ),
          ],
        ),
        const Gap(8),
        SliderTheme(
          data: SliderTheme.of(
            context,
          ).copyWith(showValueIndicator: ShowValueIndicator.always),
          child: Slider(
            value: range.value.toDouble(),
            min: range.min.toDouble(),
            max: range.max.toDouble(),
            label: '${range.value}',
            onChanged: onChanged,
          ),
        ),
        if (range.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              range.errorMessage!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
