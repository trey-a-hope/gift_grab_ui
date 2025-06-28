part of 'game_bloc.dart';

class GameState extends Equatable {
  final int score;
  final int remainingTime;
  final int flameRemainingTime;
  final bool isGameOver;
  final bool isSantaFlamed;
  final bool isSantaFrozen;
  final double santaSpeed;
  final bool isFlameSpawned;
  final bool isCookieSpawned;
  final int speedBoostRemainingTime;
  final bool isSpeedBoosted;

  const GameState({
    this.score = 0,
    this.remainingTime = Constants.gameTimeLimit,
    this.flameRemainingTime = 10,
    this.isGameOver = false,
    this.isSantaFlamed = false,
    this.isSantaFrozen = false,
    this.santaSpeed = 500,
    this.isFlameSpawned = false,
    this.isCookieSpawned = false,
    this.speedBoostRemainingTime = 7,
    this.isSpeedBoosted = false,
  });

  GameState copyWith({
    int? score,
    int? remainingTime,
    int? flameRemainingTime,
    bool? isGameOver,
    bool? isSantaFlamed,
    bool? isSantaFrozen,
    double? santaSpeed,
    bool? isFlameSpawned,
    bool? isCookieSpawned,
    int? speedBoostRemainingTime,
    bool? isSpeedBoosted,
  }) {
    return GameState(
      score: score ?? this.score,
      remainingTime: remainingTime ?? this.remainingTime,
      flameRemainingTime: flameRemainingTime ?? this.flameRemainingTime,
      isGameOver: isGameOver ?? this.isGameOver,
      isSantaFlamed: isSantaFlamed ?? this.isSantaFlamed,
      isSantaFrozen: isSantaFrozen ?? this.isSantaFrozen,
      santaSpeed: santaSpeed ?? this.santaSpeed,
      isFlameSpawned: isFlameSpawned ?? this.isFlameSpawned,
      isCookieSpawned: isCookieSpawned ?? this.isCookieSpawned,
      speedBoostRemainingTime:
          speedBoostRemainingTime ?? this.speedBoostRemainingTime,
      isSpeedBoosted: isSpeedBoosted ?? this.isSpeedBoosted,
    );
  }

  @override
  List<Object?> get props => [
    score,
    remainingTime,
    flameRemainingTime,
    isGameOver,
    isSantaFlamed,
    isSantaFrozen,
    santaSpeed,
    isFlameSpawned,
    isCookieSpawned,
    speedBoostRemainingTime,
    isSpeedBoosted,
  ];
}
