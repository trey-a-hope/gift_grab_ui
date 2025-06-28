import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:gift_grab_ui/blocs/game/game_bloc.dart';
import 'package:gift_grab_ui/sprite_components/cookie_component.dart';

class CookieSpawner<T extends FlameGame> extends Component
    with HasGameReference<T>, FlameBlocListenable<GameBloc, GameState> {
  bool _hasSpawned = false;

  @override
  void onNewState(GameState state) {
    if (state.isCookieSpawned && !_hasSpawned) {
      _hasSpawned = true;
      final randomPosition = Vector2(
        Random().nextDouble() * game.size.x,
        Random().nextDouble() * game.size.y,
      );
      add(CookieComponent(startPosition: randomPosition));
    }
  }
}
