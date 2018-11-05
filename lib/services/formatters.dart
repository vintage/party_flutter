class FormatterService {
  static String secondsToTime(int value) {
    int minutes = (value / 60).floor();
    int seconds = value % 60;

    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }
}
