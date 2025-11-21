// Módulo para el temporizador del juego
import 'dart:async';

class WordSearchTimer {
  Timer? _timer;
  int _remainingSeconds;
  final Function(int) onTick;
  final Function() onTimeUp;

  WordSearchTimer({
    required int initialSeconds,
    required this.onTick,
    required this.onTimeUp,
  }) : _remainingSeconds = initialSeconds;

  int get remainingSeconds => _remainingSeconds;

  String get formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingSeconds--;
      onTick(_remainingSeconds);

      if (_remainingSeconds <= 0) {
        stop();
        onTimeUp();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stop();
  }

  bool get isRunning => _timer != null;
}