import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:math' as math;

import 'package:gift_grab_ui/config/constants.dart';

class IceComponent extends SpriteComponent
    with HasGameReference, CollisionCallbacks {
  static const double _tableHeight = 200.0;
  static const double _tabletSpeed = 300.0;
  static const double sizeRatio = 1.0;

  late final Vector2 _velocity;
  final double _spriteHeight;
  final double speed;

  IceComponent() : _spriteHeight = _tableHeight, speed = _tabletSpeed;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await _setupSprite();
    _setupPhysics();
    _setupCollision();
  }

  Future<void> _setupSprite() async {
    sprite = await game.loadSprite(Constants.iceSprite);
    width = _spriteHeight * sizeRatio;
    height = _spriteHeight;
    anchor = Anchor.center;
  }

  void _setupPhysics() {
    position = Vector2(
      math.Random().nextDouble() * game.size.x,
      math.Random().nextDouble() * game.size.y,
    );
    _velocity = _calculateInitialVelocity();
  }

  void _setupCollision() {
    add(CircleHitbox()..radius = width / 2);
    add(ScreenHitbox());
  }

  Vector2 _calculateInitialVelocity() {
    final double angle = _getRandomAngle() * (math.pi / 180);
    return Vector2(math.cos(angle) * speed, math.sin(angle) * speed);
  }

  double _getRandomAngle() => lerpDouble(0, 360, math.Random().nextDouble())!;

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
}
