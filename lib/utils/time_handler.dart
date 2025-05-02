import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'fun.dart';

class TimeHandler {
  static String getTimeFormat(TimeOfDay timeOfDay) {
    //"9:00"
    final now = DateTime.now();
    final parsedTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formatter = DateFormat('hh:mm a'); // 12-hour format with AM/PM
    //"9:00 AM"
    return formatter.format(parsedTime); // Example: "03:00 PM"
  }
  static DateTime convertZuluToIST(String timeString) {
    if (!timeString.endsWith('Z')) {
      print('Given time is not in Zulu format. Returning the original time.');
      return DateTime.parse(timeString);
    }
    DateTime utcTime = DateTime.parse(timeString);
    DateTime istTime = utcTime.add(Duration(hours: 5, minutes: 30));
    return istTime;
  }

  static MonthComparison compareMonthToCurrent(DateTime targetDate) {
    final currentDate = DateTime.now();
    if (targetDate.year < currentDate.year ||
        (targetDate.year == currentDate.year &&
            targetDate.month < currentDate.month)) {
      return MonthComparison.Previous;
    } else if (targetDate.year == currentDate.year &&
        targetDate.month == currentDate.month) {
      return MonthComparison.Current;
    } else {
      return MonthComparison.Next;
    }
  }

  static String convertUtcToIndianTime(String utcDateTimeString) {
    // "2023-08-14T23:58:00.000Z"
    try {
      DateTime utcDateTime = DateTime.parse(utcDateTimeString);
      DateTime indianDateTime = utcDateTime.toLocal();
      final formattedTime = DateFormat('hh:mm a').format(indianDateTime);
      return formattedTime;
    } catch (e) {
      print("Error converting datetime: $e");
      return "Invalid datetime";
    }
    //05:30 AM
  }

  static String convertUtcToIndianDateTime(String utcDateTimeString) {
    // "2023-08-14T23:58:00.000Z"
    try {
      DateTime utcDateTime = DateTime.parse(utcDateTimeString);
      DateTime indianDateTime = utcDateTime.toLocal();
      final formattedDate = DateFormat('MMM dd, yyyy').format(indianDateTime);
      final formattedTime = DateFormat('hh:mm a').format(indianDateTime);
      return formattedDate + " " + formattedTime;
    } catch (e) {
      print("Error converting datetime: $e");
      return "Invalid datetime";
    }
    //Sep 05,2023 05:30 AM
  }

  static String getTime() {
    DateTime dateTime = DateTime.now();
    return dateTime.toString();
  }

  static String getDiffrence(DateTime startTime, DateTime endTime) {
    Duration difference = endTime.difference(startTime);
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);
    print('Time difference: $hours hours, $minutes minutes, $seconds seconds');
    var sTime = '$hours:$minutes:$seconds';
    return sTime;
  }

  static String calculateTimeDifference(
      String inTimeString, String outTimeString) {
    // "inTime": "2023-09-01T04:46:29.618Z",
    // "outTime": "2023-09-01T13:47:42.040Z",
    DateTime inTime = DateTime.parse(inTimeString);
    DateTime outTime = DateTime.parse(outTimeString);
    Duration timeDifference = outTime.difference(inTime);
    int hours = timeDifference.inHours;
    int minutes = timeDifference.inMinutes % 60;
    // 9:00
    return "${hours}:${minutes}";
  }

  static String getTimeFromUnix(int unixTime) {
    DateTime dateTime =
    DateTime.fromMillisecondsSinceEpoch(unixTime * 1000, isUtc: true);
    return dateTime.toString();
  }

  static int timeToSeconds(String time) {
    List<String> parts = time.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    return hours * 3600 + minutes * 60 + seconds;
  }

  static int timeStartFrom(int iTime) {
    var sStartTime = getTimeFromUnix(iTime);
    DateTime startTime = DateTime.parse(sStartTime);
    var eEndTime = getTime();
    DateTime endTime = DateTime.parse(eEndTime);
    var sTimeDiff = getDiffrence(startTime, endTime);
    var sTimeInSec = timeToSeconds(sTimeDiff);
    print(sTimeInSec);
    return sTimeInSec;
  }
  static String getTimer(int remainingSeconds){
    Duration duration = Duration(seconds: remainingSeconds); // 1 hour, 1 minute, 1 second
    int hours = duration.inHours;
    int minutes = (duration.inMinutes - (hours * 60));
    int seconds = (duration.inSeconds - (hours * 3600) - (minutes * 60));
    var timeToDisplay= "${Fun.padNumberWithZero(hours)}:${Fun.padNumberWithZero(minutes)}:${Fun.padNumberWithZero(seconds)}";
    print('$hours:$minutes:$seconds'); // Output: 1:1:1
    return timeToDisplay;
  }
  static String getCurrentTime(){
    DateTime currentTime = DateTime.now().toUtc();
    int unixTimeMilliseconds = currentTime.millisecondsSinceEpoch;
    int unixTimeSeconds = (unixTimeMilliseconds / 1000).round();
    //"inTimeUnix": 1700111563,
    return unixTimeSeconds.toString();
  }
  static String getCurrentTimeSS(){
    DateTime currentTime = DateTime.now().toUtc();
    String formattedTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(currentTime);
    // Output: 2023-11-16T05:12:43.783Z
    return formattedTime;
  }

  static DateTime getLastMonth(DateTime currentDate) {
    final lastMonth =
    DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
    if (lastMonth.month == 12) {
      return DateTime(currentDate.year - 1, 12, currentDate.day);
    } else {
      return lastMonth;
    }
  }

  static DateTime getNextMonthDate(DateTime currentDate) {
    final lastMonth =
    DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
    if (lastMonth.month == 12) {
      return DateTime(currentDate.year - 1, 12, currentDate.day);
    } else {
      return lastMonth;
    }
  }

  static DateTime getNextMonth(DateTime currentDate) {
    DateTime nextMonthDate = currentDate.add(Duration(days: 30));
    String formattedDate = DateFormat('yyyy-MM-dd').format(nextMonthDate);
    return DateTime.parse(formattedDate);
  }

  static String getFormattedDate(int? month, int? year) {
    String? formattedDate;
   try{
     List<String> monthsAbbreviation = [
       "", "Jan", "Feb", "Mar", "Apr", "May", "Jun",
       "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
     ];
     String monthAbbreviation = monthsAbbreviation[month!];
     String formattedYear = year.toString();
            formattedDate = "$monthAbbreviation-$formattedYear";
   }catch (e){
   //
   }
    return formattedDate ?? '';
  }

  static String sMonthYear(DateTime current) {
    DateTime now = current;
    List<String> months = [
      '',
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
    String month = months[now.month];
    String year = now.year.toString();
    String monthYear = '$month $year';
    //print("The current month and year are: $monthYear");
    return monthYear;
  }

  static String getYearName(DateTime current) {
    DateTime now = current;
    List<String> months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    String month = months[now.month];
    String year = now.year.toString();
    String monthYear = '$month $year';
    //print("The current month and year are: $monthYear");
    return monthYear;
  }

  static String getWeekAndMonth(String dateString) {
    DateTime birthdayDate = convertZuluToIST(dateString);
    int currentYear = DateTime.now().year;
    DateTime updatedBirthdayDate = DateTime(currentYear, birthdayDate.month, birthdayDate.day);
    String formattedDate = DateFormat('EEE, MMM d').format(updatedBirthdayDate);
    return formattedDate;
  }

  static bool isTimeDifferenceValid(TimeOfDay startTime, TimeOfDay endTime) {
    DateTime now = DateTime.now();
    DateTime startDateTime = DateTime(
        now.year, now.month, now.day, startTime.hour, startTime.minute);
    DateTime endDateTime =
    DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
    Duration difference = endDateTime.difference(startDateTime);
    if (difference.inHours >= 4) {
      return true;
    } else {
      return false;
    }
  }

  static String getDateFromUnix(String sValue) {
    //2023-08-01T05:05:01.895Z
    return DateTime.parse(sValue).toString().substring(0, 10);
    //2023-08-01
  }

  static String getMonthName(String inputDate) {
    //2023-9
    DateTime dateTime = DateTime.parse(inputDate + '-01');
    String formattedDate = "${_getMonth(dateTime.month)} ${dateTime.year}";
    //sep 2023
    return formattedDate;
  }

  static String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }


  static String convertDate(String dateStr) {
    //2023-08-01T05:05:01.895Z
    try {
      DateTime date = DateTime.parse(dateStr);
      String day = date.day.toString().padLeft(2, '0');
      String month = _getMonthName(date.month);
      String year = date.year.toString();
      //01 Aug 2023
      return '$day $month $year';
    } catch (e) {
      print("Error converting datetime: $e");
      return "Invalid datetime";
    }


  }

  static String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        throw Exception('Invalid month number');
    }
  }

  static String convertDateFormat(String inputDate) {
    //2023-08-01T05:05:01.895Z
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate =
        "${dateTime.day.toString().padLeft(2, '0')} ${_getMonthAbbreviation(dateTime.month)} ${dateTime.year} ${_formatTime(dateTime)}";
    //01 Aug 2023 05:05 AM
    return formattedDate;
  }
  static String getCompOffTime(String inputTime) {
    DateTime parsedTime = DateTime.parse(inputTime);
    parsedTime = parsedTime.add(Duration(hours: 5, minutes: 30));
    String formattedTime = DateFormat('dd MMM yyy hh:mm a').format(parsedTime);
    return formattedTime;
  }

  static String _getMonthAbbreviation(int month) {
    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }

  static String _formatTime(DateTime dateTime) {
    String period = "AM";
    int hour = dateTime.hour;
    if (hour >= 12) {
      period = "PM";
      if (hour > 12) {
        hour -= 12;
      }
    } else if (hour == 0) {
      hour = 12;
    }
    String formattedTime =
        "${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period";
    return formattedTime;
  }
  static String calculateTotalTime(String inTimeString, String outTimeString) {
    // "inTime": "2023-09-01T09:47:58.521Z",
    // "outTime": "2023-09-01T09:48:05.242Z"
    DateTime inTime = DateTime.parse(inTimeString);
    DateTime outTime = DateTime.parse(outTimeString);
    Duration timeDifference = outTime.difference(inTime);
    int hours = timeDifference.inHours;
    int minutes = timeDifference.inMinutes % 60;
    int seconds = timeDifference.inSeconds % 60;
    int milliseconds = timeDifference.inMilliseconds % 1000;
   // String formattedDifference = '$hours:$minutes';
    String formattedDifference = '$hours:$minutes:$seconds';
    return formattedDifference;
    // Sum of times: 87:00
  }
  static String addTimes(String time1, String time2) {
    // Split the time strings into parts
    List<String> parts1 = time1.split(':');
    List<String> parts2 = time2.split(':');
    if (parts1.length != 3 || parts2.length != 3) {
      throw ArgumentError('Invalid time format. Expected format HH:MM:SS.');
    }
    // Parse hours, minutes, and seconds
    int hours1 = int.parse(parts1[0]);
    int minutes1 = int.parse(parts1[1]);
    int seconds1 = int.parse(parts1[2]);
    int hours2 = int.parse(parts2[0]);
    int minutes2 = int.parse(parts2[1]);
    int seconds2 = int.parse(parts2[2]);
    // Calculate total hours, minutes, and seconds
    int totalHours = hours1 + hours2;
    int totalMinutes = minutes1 + minutes2;
    int totalSeconds = seconds1 + seconds2;
    // Adjust for overflow in seconds
    if (totalSeconds >= 60) {
      totalMinutes += totalSeconds ~/ 60;
      totalSeconds %= 60;
    }
    // Adjust for overflow in minutes
    if (totalMinutes >= 60) {
      totalHours += totalMinutes ~/ 60;
      totalMinutes %= 60;
    }
    // Return formatted result
    String result = '${totalHours}:${totalMinutes.toString().padLeft(2, '0')}:${totalSeconds.toString().padLeft(2, '0')}';
    return result;
  }
}

enum MonthComparison { Previous, Current, Next }
