import 'package:flutter/material.dart';
import 'package:gift_grab_ui/widgets/gg_scaffold_widget.dart';

class GameOverOverlay extends StatelessWidget {
  final int score;
  final void Function() playAgain;

  const GameOverOverlay(this.score, this.playAgain, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GGScaffoldWidget(
      canPop: true,
      title: 'Game Over',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Text('Score: $score', style: theme.textTheme.displayLarge),
            ),
            SizedBox(
              width: 400,
              height: 100,
              child: ElevatedButton(
                onPressed: playAgain,
                child: Text('Play Again?', style: theme.textTheme.displayLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
