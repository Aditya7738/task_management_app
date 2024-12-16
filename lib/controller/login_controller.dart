import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/views/admin_dash_board.dart';
import 'package:task_management_app/views/dashboard_screen.dart';

class LoginController extends GetxController {
  RxBool isPasswordInvisible = true.obs;

  guessCompanyName(String emailDomain) {
    final parts = emailDomain.split('@');
    final domainParts = parts[1].split('.');
    return domainParts[0];
  }

  RxString role = "Manager".obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  var emailController = TextEditingController().obs;

  TextEditingController usernameController = TextEditingController();

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

  SharedPreferencesAsync sharedPreferencesAsync = SharedPreferencesAsync();

  Future<void> login() async {
    logingAccount.value = true;

    if (role.value != "Admin") {
      emailController.value.text = usernameController.text +
          "@" +
          companyNameController.text.toLowerCase() +
          ".com";
    }

    await auth
        .signInWithEmailAndPassword(
            email: emailController.value.text,
            password: passwordController.text)
        .then(
      (value) async {
        logingAccount.value = false;

        await sharedPreferencesAsync.setString(
            "company_name", companyNameController.text);
        await sharedPreferencesAsync.setString("role", role.value);

        Get.snackbar("Login successfully", "",
            colorText: const Color.fromARGB(255, 57, 47, 47),
            backgroundColor: Get.theme.primaryColor,
            duration: Duration(seconds: 4),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);

        role.value == "Admin"
            ? Get.to(() => AdminDashboardScreen())
            : Get.to(() => DashboardScreen());
        // Get.to(
        //   () => AdminDashboardScreen(),
        // );
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
