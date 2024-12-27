import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:task_management_app/constants/database_references.dart';
import 'package:task_management_app/controller/user_activities_controller.dart';

class TasksOverviewController extends GetxController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  RxInt touchedGroupIndex = (-1).obs;

  UserActivitiesController _userActivitiesController =
      Get.put(UserActivitiesController());

  RxList assignedTasks = [].obs;

  RxBool fetchingAllTasks = false.obs;

  RxInt assignTaskListLength = 0.obs;
  RxInt inProgressTaskListLength = 0.obs;
  RxInt onHoldTaskListLength = 0.obs;
  RxInt completedTaskListLength = 0.obs;

  Future getAllTasks() async {
    fetchingAllTasks.value = true;

    await getTasks("Assigned");
    await getTasks("In progress");
    await getTasks("Completed");
    await getTasks("Hold");

    fetchingAllTasks.value = false;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getTasks(
      String typeOfTask) async {
    String adminTaskReference = "";
    switch (typeOfTask) {
      case "Assigned":
        adminTaskReference =
            DatabaseReferences.ADMINS_ASSIGNED_TASKS_COLLECTION_REFERENCE;
        break;
      case "In progress":
        adminTaskReference =
            DatabaseReferences.ADMIN_INPROGRESS_TASKS_COLLECTION_REFERENCE;
        break;
      case "Completed":
        adminTaskReference =
            DatabaseReferences.ADMIN_COMPLETED_TASKS_COLLECTION_REFERENCE;
        break;
      case "Hold":
        adminTaskReference =
            DatabaseReferences.ADMIN_HOLD_TASKS_COLLECTION_REFERENCE;
        break;
      default:
    }

    DocumentReference adminReference;
    QuerySnapshot<Map<String, dynamic>> map = await _fireStore
        .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
        .doc(_userActivitiesController.companyName.value.toUpperCase())
        .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
        .where("workEmail",
            isEqualTo: _userActivitiesController.workEmail.value)
        .get();

    adminReference = map.docs.first.reference;
    QuerySnapshot<Map<String, dynamic>> tasks = await _fireStore
        .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
        .doc(_userActivitiesController.companyName.value.toUpperCase())
        .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
        .doc(adminReference.id)
        .collection(adminTaskReference)
        .get()
        .onError(
      (error, stackTrace) {
        print("Firebase Error: $error");

        String cleanedError =
            error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();
        //cleanedText.trim();

        Get.snackbar("Assigned tasks error", cleanedError,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 5),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
        throw Exception("Failed to fetch assigned tasks: $cleanedError");
      },
    );

    switch (typeOfTask) {
      case "Assigned":
        assignTaskListLength.value = tasks.docs.length;
        break;
      case "In progress":
        inProgressTaskListLength.value = tasks.docs.length;
        break;
      case "Completed":
        completedTaskListLength.value = tasks.docs.length;
        break;
      case "Hold":
        onHoldTaskListLength.value = tasks.docs.length;
        break;
      default:
    }

    return tasks;
  }

  // Future<void> getAssignedTask() async {
  //   String adminTaskReference = "";
  //   switch (typeOfTask) {
  //     case "Assigned":
  //       adminTaskReference =
  //           DatabaseReferences.ADMINS_ASSIGNED_TASKS_COLLECTION_REFERENCE;
  //       break;
  //     case "In progress":
  //       adminTaskReference =
  //           DatabaseReferences.ADMIN_INPROGRESS_TASKS_COLLECTION_REFERENCE;
  //       break;
  //     case "Completed":
  //       adminTaskReference =
  //           DatabaseReferences.ADMIN_COMPLETED_TASKS_COLLECTION_REFERENCE;
  //       break;
  //     case "Hold":
  //       adminTaskReference =
  //           DatabaseReferences.ADMIN_HOLD_TASKS_COLLECTION_REFERENCE;
  //       break;
  //     default:
  //   }

  //   DocumentReference adminReference;
  //   QuerySnapshot<Map<String, dynamic>> map = await _fireStore
  //       .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
  //       .doc(_userActivitiesController.companyName.value.toUpperCase())
  //       .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
  //       .where("workEmail",
  //           isEqualTo: _userActivitiesController.workEmail.value)
  //       .get();

  //   adminReference = map.docs.first.reference;
  //   QuerySnapshot<Map<String, dynamic>> tasks = await _fireStore
  //       .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
  //       .doc(_userActivitiesController.companyName.value.toUpperCase())
  //       .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
  //       .doc(adminReference.id)
  //       .collection(adminTaskReference)
  //       .get()
  //       .onError(
  //     (error, stackTrace) {
  //       print("Firebase Error: $error");

  //       String cleanedError =
  //           error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();
  //       //cleanedText.trim();

  //       Get.snackbar("Assigned tasks error", cleanedError,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white,
  //           duration: Duration(seconds: 5),
  //           borderRadius: 20.0,
  //           snackPosition: SnackPosition.TOP);
  //       throw Exception("Failed to fetch assigned tasks: $cleanedError");
  //     },
  //   );

  //   return tasks;
  // }
}
