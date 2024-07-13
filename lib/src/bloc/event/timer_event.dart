abstract class TimerEvent {}

class StartTimer extends TimerEvent {}

class Tick extends TimerEvent {
  final int seconds;
  Tick(this.seconds);
}

class StopTimer extends TimerEvent {}

