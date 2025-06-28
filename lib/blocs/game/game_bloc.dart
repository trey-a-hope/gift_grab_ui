import 'dart:async';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_grab_ui/config/constants.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  static const int initialTime = Constants.gameTimeLimit;
  static const int flameImmunityDuration = 10;
  static const double originalSpeed = 500;
  static const int speedBoostDuration = 7;

  Timer? _gameTimer;

  // flame
  Timer? _flameDisplayTimer;
  Timer? _flameCountdownTimer;
  bool _hasSpawnedFlame = false;

  // ice
  Timer? _frozenCountdown;

  // cookie
  Timer? _cookieDisplayTimer;
  Timer? _cookieCountdown;
  bool _hasSpawnedCookie = false;

  GameBloc() : super(GameState()) {
    on<StartGameEvent>(_onStartGameEvent);
    on<ScorePointEvent>(_onScorePointEvent);
    on<TimerTickEvent>(_onTimerTickEvent);
    on<ResetGameEvent>(_onResetGameEvent);

    // Flame related events
    on<DisplayFlameEvent>(_onDisplayFlameEvent);
    on<StartFlameCountdownEvent>(_onStartFlameCountdownEvent);
    on<DeactivateFlameEvent>(_onDeactivateFlameEvent);
    on<FlameTickEvent>(_onFlameTickEvent);

    // Cookie related events
    on<DisplayCookieEvent>(_onDisplayCookieEvent);
    on<StartSpeedBoostCountdownEvent>(_onStartSpeedBoostCountdownEvent);
    on<SpeedBoostTickEvent>(_onSpeedBoostTickEvent);

    // Santa related events
    on<FreezeSantaEvent>(_onFreezeSantaEvent);
    on<UnfreezeSantaEvent>(_onUnfreezeSantaEvent);
  }

  void startTimer() {
    _gameTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(TimerTickEvent()),
    );

    // Spawn flame
    final randomFlameSeconds = Random().nextInt(initialTime);
    _flameDisplayTimer = Timer(Duration(seconds: randomFlameSeconds), () {
      if (!_hasSpawnedFlame) {
        add(DisplayFlameEvent());
        _hasSpawnedFlame = true;
      }
    });

    // Spawn cookie
    final randomCookieSeconds = Random().nextInt(initialTime);
    _cookieDisplayTimer = Timer(Duration(seconds: randomCookieSeconds), () {
      if (!_hasSpawnedCookie) {
        add(DisplayCookieEvent());
        _hasSpawnedCookie = true;
      }
    });
  }

  void stopTimer() {
    _gameTimer?.cancel();
    _gameTimer = null;

    _flameDisplayTimer?.cancel();
    _flameDisplayTimer = null;

    _flameCountdownTimer?.cancel();
    _flameCountdownTimer = null;

    _frozenCountdown?.cancel();
    _frozenCountdown = null;

    _cookieDisplayTimer?.cancel();
    _cookieDisplayTimer = null;

    _cookieCountdown?.cancel();
    _cookieCountdown = null;
  }

  void _onResetGameEvent(ResetGameEvent event, Emitter<GameState> emit) {
    stopTimer();
    emit(
      GameState(
        remainingTime: initialTime,
        flameRemainingTime: flameImmunityDuration,
        speedBoostRemainingTime: speedBoostDuration,
        score: 0,
        isGameOver: false,
        isSantaFlamed: false,
        isSantaFrozen: false,
        isSpeedBoosted: false,
        santaSpeed: originalSpeed,
        isFlameSpawned: false,
        isCookieSpawned: false,
      ),
    );
    _hasSpawnedFlame = false;
    _hasSpawnedCookie = false;
    startTimer();
  }

  void _onDeactivateFlameEvent(
    DeactivateFlameEvent event,
    Emitter<GameState> emit,
  ) {
    emit(
      state.copyWith(
        isSantaFlamed: false,
        flameRemainingTime: flameImmunityDuration,
      ),
    );
  }

  void _onDisplayFlameEvent(DisplayFlameEvent event, Emitter<GameState> emit) {
    emit(state.copyWith(isFlameSpawned: true));
  }

  void _onTimerTickEvent(TimerTickEvent event, Emitter<GameState> emit) {
    final newTime = state.remainingTime - 1;
    if (newTime <= 0) {
      _gameTimer?.cancel();
      emit(state.copyWith(remainingTime: 0, isGameOver: true));
    } else {
      emit(state.copyWith(remainingTime: newTime));
    }
  }

  void _onStartGameEvent(StartGameEvent event, Emitter<GameState> emit) {
    emit(GameState(remainingTime: initialTime, score: 0, isGameOver: false));
    startTimer();
  }

  void _onScorePointEvent(ScorePointEvent event, Emitter<GameState> emit) {
    emit(state.copyWith(score: state.score + 1));
  }

  void _onStartFlameCountdownEvent(
    StartFlameCountdownEvent event,
    Emitter<GameState> emit,
  ) {
    emit(
      state.copyWith(
        isSantaFlamed: true,
        flameRemainingTime: flameImmunityDuration,
      ),
    );
    _startFlameCountdown();
  }

  void _startFlameCountdown() {
    _flameCountdownTimer?.cancel();
    _flameCountdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(FlameTickEvent());
    });
  }

  void _onFlameTickEvent(FlameTickEvent event, Emitter<GameState> emit) {
    final newTime = state.flameRemainingTime - 1;
    if (newTime <= 0) {
      _flameCountdownTimer?.cancel();
      emit(
        state.copyWith(
          isSantaFlamed: false,
          flameRemainingTime: flameImmunityDuration,
        ),
      );
    } else {
      emit(state.copyWith(flameRemainingTime: newTime));
    }
  }

  // Santa related event handlers
  void _onFreezeSantaEvent(FreezeSantaEvent event, Emitter<GameState> emit) {
    if (!state.isSantaFrozen) {
      _frozenCountdown?.cancel();
      emit(state.copyWith(isSantaFrozen: true));

      _frozenCountdown = Timer(const Duration(seconds: 3), () {
        add(UnfreezeSantaEvent());
      });
    }
  }

  void _onUnfreezeSantaEvent(
    UnfreezeSantaEvent event,
    Emitter<GameState> emit,
  ) {
    emit(state.copyWith(isSantaFrozen: false));
  }

  @override
  Future<void> close() {
    _gameTimer?.cancel();
    _flameDisplayTimer?.cancel();
    _flameCountdownTimer?.cancel();
    _frozenCountdown?.cancel();
    _cookieCountdown?.cancel();
    return super.close();
  }

  void _onDisplayCookieEvent(
    DisplayCookieEvent event,
    Emitter<GameState> emit,
  ) {
    emit(state.copyWith(isCookieSpawned: true));
  }

  void _onStartSpeedBoostCountdownEvent(
    StartSpeedBoostCountdownEvent event,
    Emitter<GameState> emit,
  ) {
    _cookieCountdown?.cancel(); // Cancel any existing timer
    emit(
      state.copyWith(
        isSpeedBoosted: true, // Add this state flag
        santaSpeed: state.santaSpeed * 2,
        speedBoostRemainingTime: speedBoostDuration,
      ),
    );
    _startSpeedBoostCountdown();
  }

  void _startSpeedBoostCountdown() {
    _cookieCountdown?.cancel();
    _cookieCountdown = Timer.periodic(const Duration(seconds: 1), (_) {
      add(SpeedBoostTickEvent());
    });
  }

  void _onSpeedBoostTickEvent(
    SpeedBoostTickEvent event,
    Emitter<GameState> emit,
  ) {
    final newTime = state.speedBoostRemainingTime - 1;
    if (newTime <= 0) {
      _cookieCountdown?.cancel();
      emit(
        state.copyWith(
          isSpeedBoosted: false,
          santaSpeed: originalSpeed,
          speedBoostRemainingTime: speedBoostDuration,
        ),
      );
    } else {
      emit(state.copyWith(speedBoostRemainingTime: newTime));
    }
  }
}
