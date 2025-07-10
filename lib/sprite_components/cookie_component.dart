import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:math' as math;

import 'package:gift_grab_ui/config/constants.dart';
import 'package:gift_grab_ui/sprite_components/santa_component.dart';

class CookieComponent extends SpriteComponent
    with HasGameReference, CollisionCallbacks {
  final double _spriteHeight = 160.0;
  late Vector2 _velocity;
  double speed = 600;
  final double degree = math.pi / 180;

  final Vector2 startPosition;

  CookieComponent({required this.startPosition});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await game.loadSprite(Constants.cookieSprite);

    final double spawnAngle = _getSpawnAngle();
    final double vx = math.cos(spawnAngle * degree) * speed;
    final double vy = math.sin(spawnAngle * degree) * speed;
    _velocity = Vector2(vx, vy);

    width = _spriteHeight;
    height = _spriteHeight;
    anchor = Anchor.center;

    add(CircleHitbox()..radius = 1);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _updatePosition(dt);
    _keepInBounds();
  }

  void _updatePosition(double dt) {
    position += _velocity * dt;
  }

  void _keepInBounds() {
    if (position.x < 0 || position.x > game.size.x) {
      _velocity.x = -_velocity.x;
      position.x = position.x.clamp(0, game.size.x);
    }
    if (position.y < 0 || position.y > game.size.y) {
      _velocity.y = -_velocity.y;
      position.y = position.y.clamp(0, game.size.y);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is SantaComponent) {
      removeFromParent();
    }
  }

  double _getSpawnAngle() {
    final random = math.Random().nextDouble();
    return lerpDouble(0, 360, random)!;
  }
}
