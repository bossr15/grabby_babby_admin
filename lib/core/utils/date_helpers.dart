import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:intl/intl.dart';

class DateHelpers {
  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(date);
  }

  static DateTime parseDate(String date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).parse(date);
  }

  static Future<DateTime?> showDateDialog({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final now = DateTime.now();
    initialDate ??= now;
    firstDate ??= DateTime(now.year - 10);
    lastDate ??= DateTime(now.year + 10);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    return pickedDate;
  }

  static Future<DateTimeRange?> showDateRange({
    required BuildContext context,
  }) async {
    final selectedDates = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        selectedDayHighlightColor: AppColors.darkBlue,
        weekdayLabelTextStyle: const TextStyle(color: Colors.black),
        controlsTextStyle: const TextStyle(color: Colors.black),
        dayTextStyle: const TextStyle(color: Colors.black),
      ),
      // value: initialDateRange,
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(15),
    );

    if (selectedDates != null && selectedDates.length == 2) {
      return DateTimeRange(
          start: selectedDates.first!, end: selectedDates.last!);
    }

    return null;
  }

  static String formatDateRange(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) {
      return "Select Date Range";
    }

    final formatter = DateFormat('MMM dd');
    final start = formatter.format(startDate);
    final end = formatter.format(endDate);

    return "$start - $end";
  }

// incoming date format: 2025-02-08 -> output: 2nd Feb
  static String formatStringDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String dayWithSuffix = _addOrdinalSuffix(parsedDate.day);
    String month = _getMonthAbbreviation(parsedDate.month);
    return '$dayWithSuffix $month';
  }

  static String _addOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  static String _getMonthAbbreviation(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }
}
