import 'package:get/get.dart';

class SignupController extends GetxController {
  RxBool isPasswordInvisible = true.obs;

  RxBool isConfirmPasswordInvisible = true.obs;

  RxBool isComfirmPasswordMatched = false.obs;

  guessCompanyName(String emailDomain) {
    final parts = emailDomain.split('@');
    final domainParts = parts[1].split('.');
    return domainParts[0].toUpperCase();
  }
}
