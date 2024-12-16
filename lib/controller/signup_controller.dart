import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/constants/database_references.dart';
import 'package:task_management_app/views/admin_dash_board.dart';
import 'package:task_management_app/views/login_page.dart';

//const String ADMIN_COLLECTION_REFERENCE = "admins";
FirebaseAuth auth = FirebaseAuth.instance;
//String _UNIQUE_ADMIN_DOC_REF = auth.currentUser!.uid;

class SignupController extends GetxController {
  RxBool isPasswordInvisible = true.obs;

  RxBool isConfirmPasswordInvisible = true.obs;

  RxBool isComfirmPasswordMatched = false.obs;

  guessCompanyName(String emailDomain) {
    final parts = emailDomain.split('@');
    final domainParts = parts[1].split('.');
    return domainParts[0].toUpperCase();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController companyNameController = TextEditingController();

  RxBool creatingAccount = false.obs;

  Future<void> signupAdmin() async {
    creatingAccount.value = true;
    await auth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then(
      (value) async {
        Get.snackbar("Account is created successfully", "",
            colorText: Colors.white,
            backgroundColor: Get.theme.primaryColor,
            duration: Duration(seconds: 5),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);

        createUserInDB();

        creatingAccount.value = false;

        // auth.currentUser!.sendEmailVerification().then(
        //   (value) {
        //     Get.snackbar("Important",
        //         "Verfication email sent to your email address. Please verify your email address.",
        //         colorText: Colors.white,
        //         backgroundColor: Get.theme.primaryColor,
        //         duration: Duration(seconds: 7),
        //         borderRadius: 20.0,
        //         snackPosition: SnackPosition.TOP);
        //   },
        // ).onError(
        //   (error, stackTrace) {
        //     print("Email Verification Error: $error");

        //     String cleanedError =
        //         error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();
        //     //cleanedText.trim();

        //     Get.snackbar("Error", cleanedError,
        //         backgroundColor: Colors.red,
        //         colorText: Colors.white,
        //         duration: Duration(seconds: 5),
        //         borderRadius: 20.0,
        //         snackPosition: SnackPosition.TOP);
        //   },
        // );

        Get.to(
          () => LoginPage(),
        );
      },
    ).onError(
      (error, stackTrace) {
        print("FireAuth Error: $error");

        String cleanedError =
            error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();
        //cleanedText.trim();

        creatingAccount.value = false;
        Get.snackbar("Error", cleanedError,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 5),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
      },
    );
  }

  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> createUserInDB() async {
    await _fireStore
        .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
        .doc(companyNameController.text)
        .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
        .add({
      "workEmail": emailController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      //  "companyName": companyNameController.text,
      //"role": "admin",
      //  "uid": auth.currentUser!.uid,
    }).then(
      (value) {
        Get.snackbar("Admin data store successfully", "",
            colorText: Colors.white,
            backgroundColor: Get.theme.primaryColor,
            duration: Duration(seconds: 5),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
      },
    ).onError(
      (error, stackTrace) {
        print("Firestore Error: $error");

        String cleanedError =
            error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

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
