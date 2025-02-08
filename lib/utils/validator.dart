
class Kvalidator {
  static String? validateEmptyText(String? filedName, String? value) {
    if (value == null || value.isEmpty) {
      return '$filedName is required.';
    }
    return null;
  }



  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    // final emailRegExp = RegExp(r'^[\w\-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    // final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }

    return null;
  }

 

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password is at lest required 6 character';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one spacial character.';
    }
    return null;
  }

 static String? confirmPasswordValidator(String? confirmPassword, String password) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'Confirm Password is required';
  }
  if (confirmPassword != password) {
    return 'Passwords do not match';
  }
  return null; 
}


    static String? validatePhoneNumber(String? value) {
    // Check if the value is null or empty
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }

    // Check if the phone number has 10 digits
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }

    // Check if the phone number contains only digits
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Phone number must contain only digits';
    }

    // Check if the phone number contains 10 zeros (0000000000)
    if (value == '0000000000') {
      return 'Phone number cannot be 10 zeros';
    }

    // Check if the phone number contains 10 ones (1111111111)
    if (value == '1111111111') {
      return 'Phone number cannot be 10 ones';
    }

    return null;  // No validation error
  }
}
