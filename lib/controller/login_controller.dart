import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/views/admin_dash_board.dart';

class LoginController extends GetxController {
  RxBool isPasswordInvisible = true.obs;

  guessCompanyName(String emailDomain) {
    final parts = emailDomain.split('@');
    final domainParts = parts[1].split('.');
    return domainParts[0].toUpperCase();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController companyNameController = TextEditingController();

  RxBool logingAccount = false.obs;

  // void init() {
  //   User? user = auth.currentUser;

  //   if (user != null) {
  //     print("User is logged in");
  //     Get.to(() => AdminDashboardScreen());
  //   } else {
  //     print("User is not logged in");
  //   }
  // }

  Future<void> loginAdmin() async {
    logingAccount.value = true;
    await auth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then(
      (value) {
        logingAccount.value = false;
        Get.snackbar("Login successfully", "",
            colorText: Colors.white,
            backgroundColor: Get.theme.primaryColor,
            duration: Duration(seconds: 4),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
        Get.to(
          () => AdminDashboardScreen(),
        );
      },
    ).onError(
      (error, stackTrace) {
        print("Firebase Error: $error");

        String cleanedError =
            error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();
        //cleanedText.trim();

        logingAccount.value = false;
        Get.snackbar("Error", cleanedError,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 5),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
      },
    );
  }
}
