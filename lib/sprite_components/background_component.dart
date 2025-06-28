import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:gift_grab_ui/config/constants.dart';

class BackgroundComponent<T extends FlameGame> extends SpriteComponent
    with HasGameReference {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await game.loadSprite(Constants.backgroundSprite);
    size = game.size;
  }
}
