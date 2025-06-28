import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:gift_grab_ui/blocs/game/game_bloc.dart';
import 'package:gift_grab_ui/sprite_components/flame_component.dart';

class FlameSpawner<T extends FlameGame> extends Component
    with HasGameReference<T>, FlameBlocListenable<GameBloc, GameState> {
  bool _hasSpawned = false;

  @override
  void onNewState(GameState state) {
    if (state.isFlameSpawned && !_hasSpawned) {
      _hasSpawned = true;
      final randomPosition = Vector2(
        Random().nextDouble() * game.size.x,
        Random().nextDouble() * game.size.y,
      );
      add(FlameComponent(startPosition: randomPosition));
    }
  }
}
