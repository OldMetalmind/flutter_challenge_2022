/// Helper extension with extra functionality to [Duration]
extension DurationExtensions on Duration {
  /// Multiplies the Duration by a value
  Duration multiply(int value) {
    return Duration(
      days: inDays * value,
      hours: inHours * value,
      minutes: inMinutes * value,
      seconds: inSeconds * value,
      milliseconds: inMilliseconds * value,
      microseconds: inMicroseconds * value,
    );
  }
}
