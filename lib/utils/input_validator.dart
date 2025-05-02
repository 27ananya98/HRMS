
class InputValidator {
  static String? validateField(String value, String field) {
    if (value.isEmpty) {
      return "$field can't be empty";
    } else {
      return null;
    }
  }

  static String? validateReturnShortMessage(String value, String field) {
    if (value.isEmpty) {
      return "Please enter";
    } else {
      return null;
    }
  }

  static String? validateMarks(String value, String field, String gradingType) {
    if (value.isEmpty) {
      return "$field can't be empty";
    } else {
      switch (gradingType) {
        case '':
          return 'Select grading system';
        case 'Scale 10 Grading System':
          if (double.parse(value.toString()) >= 0.1 &&
              double.parse(value.toString()) <= 10) {
            return null;
          } else {
            return 'Grading must be between 0.1 & 10.';
          }
        case 'Scale 4 Grading System':
          if (double.parse(value.toString()) >= 0.1 &&
              double.parse(value.toString()) <= 4) {
            return null;
          } else {
            return 'Grading must be between 0.1 & 4.';
          }
        case '% Marks of 100 Maximum':
          if (double.parse(value.toString()) >= 35 &&
              double.parse(value.toString()) <= 100) {
            return null;
          } else {
            return 'Percentage of marks must be between 35 to 100';
          }
        default:
          return null;
      }
    }
  }

  static String? validateOTP(String value, String field) {
    if (value.isEmpty) {
      return "$field can't be empty";
    } else if (value.length < 6) {
      return 'Invalid OTP';
    } else {
      return null;
    }
  }

  static String? validatePhone(String value, String field) {
    if (value.isEmpty) {
      return "$field can't be empty";
    } else if (value.length < 10) {
      return 'Please enter valid $field';
    } else {
      return null;
    }
  }

  static String? validateEmail(String value, String error) {
    if (value.isEmpty ||
        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    final regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    if (value.isEmpty) {
      return "Password can't be empty";
    } else if (value.length < 6) {
      return 'Password should have minimum 6 characters';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String value, String password) {
    if (value == password) {
      return null;
    } else {
      return "Confirm Password mismatch";
    }
  }
}
