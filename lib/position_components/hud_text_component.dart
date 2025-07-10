import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:gift_grab_ui/gift_grab_ui.dart';

class HUDTextComponents extends PositionComponent
    with HasGameReference, FlameBlocListenable<GameBloc, GameState> {
  late TextComponent _scoreText;
  late TextComponent _timerText;

  HUDTextComponents();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _timerText = TextComponent(
      text: 'Time: 0',
      position: Vector2(40, 50),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: AppThemes.lightTheme.textTheme.displayLarge,
      ),
    );

    _scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(game.size.x - 40, 50),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: AppThemes.lightTheme.textTheme.displayLarge,
      ),
    );

    add(_timerText);
    add(_scoreText);
  }

  @override
  void onNewState(GameState state) {
    _scoreText.text = 'Score: ${state.score}';
    _timerText.text = 'Time: ${state.remainingTime}';
  }
}
