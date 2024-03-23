class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    // You can add more complex email validation logic here if needed
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    // You can add more password validation logic here if needed
    return null;
  }

  static String? mobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    // You can add more mobile number validation logic here if needed
    return null;
  }

  static String? firstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    // You can add more name validation logic here if needed
    return null;
  }
  static String? lastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    // You can add more name validation logic here if needed
    return null;
  }
}
