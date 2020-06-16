class SignInValidator {
  final int _minPasswordLength = 8;
  final int _maxPasswordLength = 50;

  String emailValidator(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }

  String passwordValidator(String value) {
    //* Main Validation terms
    if (value.isEmpty) {
      return "Password can't be empty";
    }

    if (value.length < _minPasswordLength) {
      return "Password must be at least $_minPasswordLength characters long";
    } else if (value.length > _maxPasswordLength) {
      return "Password must be less than $_maxPasswordLength characters long";
    }
    //* Password strenth terms
    // String passwordPattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    // RegExp regExp = RegExp(passwordPattern);
    // switch (regExp.hasMatch(value)) {
    //   case false:
    //     return "Only use letter, numbers and special charachters";
    //     break;
    //   case true:
    //     return null;
    //     break;
    // }
  }
}
