import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:gift_grab_ui/sprite_components/gift_component.dart';

class GiftSpawner<T extends FlameGame> extends Component
    with HasGameReference<T> {
  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _spawnGift(); // Spawn the first gift as soon as the spawner loads
  }

  void _spawnGift() {
    final randomPosition = _createRandomPosition();
    add(
      GiftComponent(
        startPosition: randomPosition,
        onCollected: () {
          // Spawn a new gift immediately when the current one is collected
          _spawnGift();
        },
      ),
    );
  }

  Vector2 _createRandomPosition() {
    return Vector2(
      _random.nextDouble() * game.size.x,
      _random.nextDouble() * game.size.y,
    );
  }
}
