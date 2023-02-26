import 'dart:ui';

extension DateTimeExtend on DateTime {
  DateTime? toUTC() {
    return this;
  }

  DateTime copy() {
    return DateTime(this.year, this.month, this.day, this.hour, this.minute, this.second, this.millisecond, this.microsecond);
  }
}
