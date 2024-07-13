import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_quest/src/bloc/state/timer_state.dart';
import 'event/timer_event.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInitial()) {
    on<StartTimer>(_onStartTimer);
    on<Tick>(_onTick);
  }

  StreamSubscription<int>? _tickerSubscription;

  void _onStartTimer(StartTimer event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    _tickerSubscription = _tick().listen((seconds) {
      add(Tick(seconds));
    });
    emit(TimerRunning(0));
  }

  void _onTick(Tick event, Emitter<TimerState> emit) {
    emit(TimerRunning(event.seconds));
  }

  Stream<int> _tick() async* {
    int seconds = 0;
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield seconds++;
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
