extension DateHelpers on DateTime {
  bool get isSameWeekAsToday {
    final now = DateTime.now();
    final firstDayOfThisWeek = now.subtract(Duration(days: now.weekday - 1));
    final lastDayOfThisWeek = now.add(Duration(days: 7 - now.weekday));
    return isAfter(firstDayOfThisWeek.subtract(
          const Duration(days: 1),
        )) &&
        isBefore(lastDayOfThisWeek.add(
          const Duration(days: 1),
        ));
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

List<DateTime> getDaysInWeek() {
  final now = DateTime.now();
  final firstDayOfThisWeek = now.subtract(Duration(days: now.weekday - 1));
  return List.generate(
      7, (index) => firstDayOfThisWeek.add(Duration(days: index)));
}
