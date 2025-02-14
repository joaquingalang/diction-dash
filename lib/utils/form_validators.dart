// Check If Email Matches Requirements
bool _isValidEmail(String email) {
  String emailFormat = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
  return RegExp(emailFormat).hasMatch(email);
}

// Check If Password Matches Requirements
bool _isValidPassword(String password) {
  bool lengthCheck = password.length >= 8;

  String passwordFormat =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*~_]).{8,}$';
  bool formatCheck = RegExp(passwordFormat).hasMatch(password);

  print('Length Check: $lengthCheck');
  print('Format Check: $formatCheck');

  return lengthCheck && formatCheck;
}

// Validate Username
String? validateUsername(String? username) {
  // Check if username is null or empty
  if (username == null ||
      username.isEmpty ||
      username.trim().isEmpty) {
    return 'Please provide a username.';

    // Check if username is shorter than 3 characters
  } else if (username.length < 3) {
    return 'Please provide a longer username.';
  }

  // Return null if username is valid (this validates this field)
  return null;
}

// Validate Email
String? validateEmail(String? email) {
  // Check if email is null or empty
  if (email == null || email.isEmpty) {
    return 'Please provide an email.';

  // Check if email meets requirements
  } else if (!_isValidEmail(email)) {
    return 'Please provide a valid email.';
  }

  // Return null if email is valid (this validates this field)
  return null;
}

String? validateRegisterPassword(String? password) {
  String lengthCheck = !(password!.length >= 8) ? '\n- Minimum 8 Characters' : '';
  String upperCaseCheck = !RegExp(r'(?=.*?[A-Z])').hasMatch(password) ? '\n- Minimum 1 Upper case' : '';
  String lowerCaseCheck = !RegExp(r'(?=.*?[a-z])').hasMatch(password) ? '\n- Minimum 1 Lowercase' : '';
  String numberCheck = !RegExp(r'(?=.*?[0-9])').hasMatch(password) ? '\n- Minimum 1 Number' : '';
  String specialCharCheck = !RegExp(r'(?=.*?[!@#$%^&*~_])').hasMatch(password) ? '\n- Minimum 1 Special Character' : '';

  // Check if password is null or empty
  if (password == null || password.isEmpty) {
    return 'Please provide a password.';

  // Check if password meets requirements
  } else if (!_isValidPassword(password)) {
    String invalidPasswordMessage = 'Please provide a valid password.$lengthCheck$upperCaseCheck$lowerCaseCheck$numberCheck$specialCharCheck';
    return invalidPasswordMessage;
  }

  // Return null if password is valid (this validates this field)
  return null;
}

String? validateLoginPassword(String? password) {
  // Check if password is null or empty
  if (password == null || password.isEmpty) {
    return 'Invalid password.';
  }

  // Return null if password is valid (this validates this field)
  return null;
}

String? validateConfirmPassword(String? confirmPassword) {
  // Check if confirm password is null or empty
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'Please confirm password.';
  }

  // Return null if confirm password is valid (this validates this field)
  return null;
}