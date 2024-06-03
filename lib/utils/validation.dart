class Validation {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter an email address.';
    }
    RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "please enter Password";
    } else if (password.length <= 8) {
      return "Password must be at least 8 characters";
    } else {
      return null;
    }
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return "Please enter name";
    } else {
      return null;
    }
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "Please enter Phone number";
    } else {
      return null;
    }
  }
}
