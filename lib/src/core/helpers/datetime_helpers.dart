extension DateHelpers on DateTime {
  bool get isSameWeekAsToday {
    final now = DateTime.now();
    final firstDayOfThisWeek = now.subtract(Duration(days: weekday - 1));
    final lastDayOfThisWeek = now.add(Duration(days: 7 - weekday));
    return now.isAfter(firstDayOfThisWeek.subtract(
          const Duration(days: 1),
        )) &&
        now.isBefore(lastDayOfThisWeek.add(
          const Duration(days: 1),
        ));
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }
}
