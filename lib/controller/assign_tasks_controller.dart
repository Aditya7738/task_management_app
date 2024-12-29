import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/constants/database_references.dart';
import 'package:task_management_app/controller/login_controller.dart';

class AssignTasksController extends GetxController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  LoginController _loginController = Get.put(LoginController());

  RxString companyName = "".obs;

  RxString workEmail = "".obs;

  SharedPreferencesAsync sharedPreferencesAsync = SharedPreferencesAsync();

  //late Stream<QuerySnapshot<Map<String, dynamic>>> managersCollection;
  late Stream<QuerySnapshot<Map<String, dynamic>>> employeesCollection;

  RxBool deletingProfile = false.obs;

  Future<void> deleteProfile(DocumentSnapshot<Object?> document) async {
    deletingProfile.value = true;
    await document.reference.delete().then(
      (value) {
        deletingProfile.value = false;
        Get.back();
        Get.snackbar("Selected profile deleted successfully", "",
            colorText: Colors.white,
            backgroundColor: Get.theme.primaryColor,
            duration: Duration(seconds: 3),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
      },
    ).onError((error, stackTrace) {
      print("Firebase Error: $error");

      String cleanedError =
          error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();
      //cleanedText.trim();

      deletingProfile.value = false;
      Get.snackbar("Error", cleanedError,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          borderRadius: 20.0,
          snackPosition: SnackPosition.TOP);
    });
  }

  RxBool updatingProfile = false.obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  Future<void> updateProfile(DocumentSnapshot<Object?> document) async {
    updatingProfile.value = true;
    await document.reference.update({
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
    }).then(
      (value) {
        updatingProfile.value = false;
        Get.back();
        Get.snackbar("Selected profile updated successfully", "",
            colorText: Colors.white,
            backgroundColor: Get.theme.primaryColor,
            duration: Duration(seconds: 3),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
      },
    ).onError(
      (error, stackTrace) {
        print("Firebase Error: $error");

        String cleanedError =
            error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();
        //cleanedText.trim();

        updatingProfile.value = false;
        Get.snackbar("Error", cleanedError,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 5),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
      },
    );
  }

  // Future<QuerySnapshot<Map<String, dynamic>>> getFutureManagersCollection() {
  //   return _fireStore
  //       .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
  //       .doc(companyName.value)
  //       .collection(DatabaseReferences.MANAGERS_COLLECTION_REFERENCE)
  //       .get();
  // }

  // Future<QuerySnapshot<Map<String, dynamic>>> getFutureEmployeesCollection() {
  //   return _fireStore
  //       .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
  //       .doc(companyName.value)
  //       .collection(DatabaseReferences.EMPLOYEES_COLLECTION_REFERENCE)
  //       .get();
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getEmployeeCollection() {
    return _fireStore
        .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
        .doc(companyName.value)
        .collection(DatabaseReferences.EMPLOYEES_COLLECTION_REFERENCE)
        .snapshots();
  }

  RxBool fetchingCompanyName = false.obs;

  RxBool assignedTaskToManager = false.obs;
}
