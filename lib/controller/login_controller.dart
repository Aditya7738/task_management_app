import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/views/admin_dash_board.dart';
import 'package:task_management_app/views/dashboard_screen.dart';

class LoginController extends GetxController {
  RxBool isPasswordInvisible = true.obs;

  guessCompanyName(String emailDomain) {
    final parts = emailDomain.split('@');
    final domainParts = parts[1].split('.');
    return domainParts[0].toUpperCase();
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
          companyNameController.text.toLowerCase().trim() +
          ".com";
    }

    await auth
        .signInWithEmailAndPassword(
            email: emailController.value.text.trim(),
            password: passwordController.text.trim())
        .then(
      (value) async {
        logingAccount.value = false;

        await sharedPreferencesAsync.setString(
            "company_name", companyNameController.text.trim());
        await sharedPreferencesAsync.setString("role", role.value);

        await sharedPreferencesAsync.setString(
            "workEmail", emailController.value.text.trim());

        Get.snackbar("Login successfully", "",
            colorText: Colors.white,
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

  RxBool sendingResetMail = false.obs;

  TextEditingController resetUsernameController = TextEditingController();

  TextEditingController resetCompanyController = TextEditingController();

  Future<void> resetPassword() async {
    sendingResetMail.value = true;

    String email = "";

    if (role.value != "Admin") {
      email = resetUsernameController.text +
          "@" +
          resetCompanyController.text.toLowerCase() +
          ".com";
    } else {
      email = resetUsernameController.text;
    }

    await auth.sendPasswordResetEmail(email: email).then(
      (value) {
        sendingResetMail.value = false;

        Get.back();

        Get.snackbar("Password reset email sent", "",
            colorText: Colors.white,
            backgroundColor: Get.theme.primaryColor,
            duration: Duration(seconds: 4),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
      },
    ).onError(
      (error, stackTrace) {
        print("Firebase Error: $error");

        String cleanedError =
            error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

        sendingResetMail.value = false;
        Get.snackbar("Error", cleanedError,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 5),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
      },
    );
  }

  Future<void> getPermissions() async {
    final permissionStatus = await Permission.storage.status;

    if (permissionStatus.isDenied) {
      await Permission.storage.request();

      if (permissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else {}
  }
}
