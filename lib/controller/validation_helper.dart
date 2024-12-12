class ValidationHelper {
  static String? nullOrEmptyString(String? input) {
    print("FOR PHONE NO: $input");
    if (input == null || input == "") {
      return "Input field is empty";
    }
    return null;
  }

  static String? isEmailValid(String? input) {
    if (nullOrEmptyString(input) == null) {
      String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
      RegExp regExp = RegExp(pattern);

      if (!regExp.hasMatch(input!)) {
        return "Email is not valid";
      }
      //return null;
    }

    return nullOrEmptyString(input);
  }

  static String? isPasswordContain(String? pass) {
    if (nullOrEmptyString(pass) == null) {
      //"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
      RegExp regExp = RegExp(
          r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&-+=()])(?=\\S+$).{8, 20}$');
      print("${regExp.hasMatch(pass!)}");
      print(pass);
      if (regExp.hasMatch(pass)) {
        return "Password don't contain uppercase, lowercase, number, symbol and length is below 6";
      }
      return null;
    }
    return nullOrEmptyString(pass);
  }

  static String? isPassAndConfirmPassSame(String pass, String confirmPass) {
    // if (isPasswordContain(pass) == null &&
    //     isPasswordContain(confirmPass) == null) {
    if (nullOrEmptyString(confirmPass) == null) {
      if (pass != confirmPass) {
        return "Passwords don't match.";
      }
      return null;
    }
    return nullOrEmptyString(confirmPass);
    // }
    // return isPasswordContain(pass);
  }
}
