import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/constants/database_references.dart';

// const String ADMIN_COLLECTION_REFERENCE = "admins";
// const String EMPLOYEES_COLLECTION_REFERENCE = "employees";
FirebaseAuth auth = FirebaseAuth.instance;
String _UNIQUE_ADMIN_DOC_REF = auth.currentUser!.uid;

class AddEmployeesController extends GetxController {
  TextEditingController emailController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  RxBool addingEmployee = false.obs;

  Future<void> addEmployees() async {
    addingEmployee.value = true;

    await _fireStore
        .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
        .doc(_UNIQUE_ADMIN_DOC_REF)
        .collection(DatabaseReferences.EMPLOYEES_COLLECTION_REFERENCE)
        .add({
      "workEmail": emailController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "role": roleController.text
    }).then((value) {
      addingEmployee.value = false;
      Get.snackbar("Employee added successfully", "",
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
