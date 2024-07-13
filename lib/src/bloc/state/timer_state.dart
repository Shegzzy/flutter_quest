abstract class TimerState {}

class TimerInitial extends TimerState {}

class TimerRunning extends TimerState {
  final int seconds;
  TimerRunning(this.seconds);
}

class TimerStopped extends TimerState {}
