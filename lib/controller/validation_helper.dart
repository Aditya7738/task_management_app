class ValidationHelper {
  static String? nullOrEmptyString(String? input) {
    print("FOR PHONE NO: $input");
    if (input == null || input == "") {
      return "Input field is empty";
    }
    return null;
  }
}
