import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/constants/database_references.dart';
import 'package:task_management_app/controller/login_controller.dart';
import 'package:task_management_app/controller/user_activities_controller.dart';

// const String ADMIN_COLLECTION_REFERENCE = "admins";
// const String EMPLOYEES_COLLECTION_REFERENCE = "employees";
//FirebaseAuth auth = FirebaseAuth.instance;
//String _UNIQUE_ADMIN_DOC_REF = auth.currentUser!.uid;

class AddEmployeesController extends GetxController {
  // TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  //TextEditingController roleController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  RxBool addingEmployee = false.obs;

  RxBool autofocuskb1 = true.obs;
  RxBool autofocuskb2 = true.obs;
  RxBool autofocuskb3 = true.obs;
  RxBool autofocuskb4 = true.obs;

  RxBool isPasswordInvisible = true.obs;

  LoginController _loginController = Get.put(LoginController());

  RxString role = "Manager".obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  UserActivitiesController _userActivitiesController =
      Get.put(UserActivitiesController());

  Future<void> createEmployeeAccount() async {
    addingEmployee.value = true;

    String email = usernameController.text +
        "@" +
        _userActivitiesController.companyName.value.toLowerCase() +
        ".com";

    print("EMAIL ${email}");

    await auth
        .createUserWithEmailAndPassword(
            email: email, password: passwordController.text)
        .then(
      (value) async {
        Get.snackbar("${role.value}'s account is created successfully", "",
            colorText: Colors.white,
            backgroundColor: Get.theme.primaryColor,
            duration: Duration(seconds: 5),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);

        addUsers();

        addingEmployee.value = false;

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

        // Get.to(
        //   () => LoginPage(),
        // );

        Get.back();
      },
    ).onError(
      (error, stackTrace) {
        print("FireAuth Error: $error");

        String cleanedError =
            error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();
        //cleanedText.trim();

        addingEmployee.value = false;
        Get.snackbar("Error", cleanedError,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 5),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
      },
    );
  }

  Future<void> addUsers() async {
    String collectionName = "";
    if (role.value == "Manager") {
      collectionName = DatabaseReferences.MANAGERS_COLLECTION_REFERENCE;
    } else {
      collectionName = DatabaseReferences.EMPLOYEES_COLLECTION_REFERENCE;
    }

    await _fireStore
        .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
        .doc(_loginController.emailController.value.text)
        .collection(collectionName)
        .add({
      //    "workEmail": emailController.text,
      "username": usernameController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "role": role.value
    }).then((value) {
      addingEmployee.value = false;

      Get.back();

      Get.snackbar("${role.value} added successfully", "",
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColor,
          duration: Duration(seconds: 5),
          borderRadius: 20.0,
          snackPosition: SnackPosition.TOP);
    }).onError((error, stackTrace) {
      print("FirestoreEmp Error: $error");

      addingEmployee.value = false;

      String cleanedError =
          error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

      Get.snackbar("Error", cleanedError,
          colorText: Colors.white,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          borderRadius: 20.0,
          snackPosition: SnackPosition.TOP);
    });
  }
}
