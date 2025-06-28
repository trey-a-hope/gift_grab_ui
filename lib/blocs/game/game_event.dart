part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class StartGameEvent extends GameEvent {}

class ResetGameEvent extends GameEvent {}

class TimerTickEvent extends GameEvent {}

class ScorePointEvent extends GameEvent {}

// Flame related events
class DisplayFlameEvent extends GameEvent {}

class StartFlameCountdownEvent extends GameEvent {}

class FlameTickEvent extends GameEvent {}

class DeactivateFlameEvent extends GameEvent {}

// Santa related events
class FreezeSantaEvent extends GameEvent {}

class UnfreezeSantaEvent extends GameEvent {}

// Cookie related events
class DisplayCookieEvent extends GameEvent {}

class StartSpeedBoostCountdownEvent extends GameEvent {}

class SpeedBoostTickEvent extends GameEvent {}
