part of 'gift_grab_game.dart';

class GameStateHandler extends Component
    with
        HasGameReference<GiftGrabGame>,
        FlameBlocListenable<GameBloc, GameState> {
  final Function(int) onEndGame;
  GameStateHandler(this.onEndGame);

  @override
  void onNewState(GameState state) {
    debugPrint('onNewState: ${state.toString()}');

    if (state.isGameOver) {
      bloc.stopTimer();

      final score = state.score;

      onEndGame.call(score);

      // Flame -> Flutter Bloc conversion.
      game.score = score;
      game.resetGame = () {
        game.resumeEngine();
        game.overlays.remove('gameOver');
        bloc.add(ResetGameEvent());
      };
      // Normal gameRef variables.
      game.pauseEngine();
      game.overlays.add('gameOver');
    }
  }
}
