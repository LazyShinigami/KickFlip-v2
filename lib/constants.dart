import 'package:flutter/material.dart';
import 'package:kickflip/models.dart';

class ThemeColors {
  Color light = const Color(0x54E6E5E5);
  Color medium = const Color(0x779E9E9E);
  Color dark = const Color(0xF08A70CD);
}

class Validator {
  String validateLoginCreds({
    required String email,
    required String password,
    required String accountType,
  }) {
    // Regular expression pattern for email validation
    String emailPattern =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // You can adjust the pattern as needed

    // Check if email is empty
    if (email.isEmpty) {
      return 'Please enter your e-mail';
    }
    // Check if email is valid
    else if (!RegExp(emailPattern).hasMatch(email)) {
      return 'Please enter a valid e-mail';
    }

    // Check if password is empty
    if (password.isEmpty || password.length < 8) {
      return 'Please enter your password';
    }
    // You can add more conditions to password validation if needed

    // Check if account type is selected
    // TODO: Check with firebase if an account exists of the same type
    if (accountType.isEmpty) {
      return 'Please select your account type';
    }

    // If all validations pass, return null
    return '';
  }

  String validateSignUpFields({
    required String name,
    required String email,
    required String password,
  }) {
    // Regular expression pattern for email validation
    String emailPattern =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // You can adjust the pattern as needed

    // Check if name is empty
    if (name.isEmpty) {
      return 'Please enter your name';
    }

    // Check if email is empty
    if (email.isEmpty) {
      return 'Please enter your e-mail';
    }
    // Check if email is valid
    else if (!RegExp(emailPattern).hasMatch(email)) {
      return 'Please enter a valid e-mail';
    }

    // Check if password is empty
    if (password.isEmpty || password.length < 8) {
      return 'Please create a strong password (at least 8 characters)';
    }
    // You can add more conditions to password validation if needed

    // If all validations pass, return null
    return '';
  }
}

class DateTimeClass {
  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String monthAbbreviation = _getMonthAbbreviation(now.month);
    String formattedDate =
        '${_addLeadingZero(now.day)} $monthAbbreviation, ${now.year.toString().substring(2)}';
    return formattedDate;
  }

  String _getMonthAbbreviation(int month) {
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

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  // Sorting notifications as per date and time in order of recency
  void sortNotifications(List<S_NotificationItem> list) {
    list.sort(
      (a, b) {
        // First, compare dates
        var dateComparison = b.date.compareTo(a.date);
        if (dateComparison != 0) {
          return dateComparison; // If dates are different, return the result of comparing dates
        } else {
          // If dates are equal, compare times
          return b.time.compareTo(a.time); // Compare times
        }
      },
    );
  }
}

class Shaders {
  final Map<Color, String> colorShades = {
    Colors.white: 'white',
    Colors.red: 'red',
    Colors.pink: 'pink',
    Colors.purple: 'purple',
    Colors.blue: 'blue',
    Colors.teal: 'teal',
    Colors.green: 'green',
    Colors.yellow: 'yellow',
    Colors.brown: 'brown',
    Colors.orange: 'orange',
    Colors.grey: 'grey',
    Colors.amber: 'amber',
    Colors.cyan: 'cyan',
    Colors.blueGrey: 'blueGrey',
    Colors.black: 'black',
  };
}
