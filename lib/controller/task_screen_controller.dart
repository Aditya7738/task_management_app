import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/constants/database_references.dart';
import 'package:task_management_app/controller/dashboard_controller.dart';
import 'package:task_management_app/controller/user_activities_controller.dart';
import 'package:task_management_app/views/admin_dash_board.dart';
import 'package:task_management_app/views/tasks_screen.dart';
import 'package:task_management_app/views/users_activities.dart';

class TaskScreenController extends GetxController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  // RxString selectedTask = "Assigned".obs;

  UserActivitiesController _userActivitiesController =
      Get.put(UserActivitiesController());

  RxBool fetchAssignedTaskToEmp = false.obs;

  DashboardController _dashboardController = Get.put(DashboardController());

  Future<QuerySnapshot<Map<String, dynamic>>> getTasklist(
      bool ofManager, String username, String typeOfTasks) async {
    //  fetchAssignedTaskToEmp.value = true;
    DocumentReference empRef;

    // QuerySnapshot<Map<String, dynamic>> assignedTasks;

    String taskCollectionRef = "";

    switch (typeOfTasks) {
      case "Assigned":
        taskCollectionRef =
            DatabaseReferences.MANAGERS_TASKS_COLLECTION_REFERENCE;
        break;
      case "In progress":
        taskCollectionRef =
            DatabaseReferences.MANAGERS_INPROGRESS_TASKS_COLLECTION_REFERENCE;
        break;
      case "Completed":
        taskCollectionRef =
            DatabaseReferences.MANAGERS_COMPLETED_TASKS_COLLECTION_REFERENCE;
        break;
      case "Hold":
        taskCollectionRef =
            DatabaseReferences.MANAGERS_HOLD_TASKS_COLLECTION_REFERENCE;
        break;
      default:
    }

    print("Task Collection Ref: $taskCollectionRef");

    String collectionReference = ofManager
        ? DatabaseReferences.MANAGERS_COLLECTION_REFERENCE
        : DatabaseReferences.EMPLOYEES_COLLECTION_REFERENCE;

    String companyName = "";

    print("ofManager: $ofManager");

    if (ofManager) {
      print("username ${_dashboardController.companyName.value}");
      companyName = _dashboardController.companyName.value.toUpperCase();
    } else {
      companyName = _userActivitiesController.companyName.value.toUpperCase();
    }

    print("Company Name: $companyName");

    QuerySnapshot<Map<String, dynamic>> map = await _fireStore
        .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
        .doc(companyName)
        .collection(collectionReference)
        .where("username", isEqualTo: username)
        .get();

    empRef = map.docs.first.reference;

    print("EmpRef: ${empRef.id}");
    QuerySnapshot<Map<String, dynamic>> tasks = await _fireStore
        .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
        .doc(companyName)
        .collection(collectionReference)
        .doc(empRef.id
            //"UiCrFsXSwx6Fqxr1VeQS"
            )
        .collection(taskCollectionRef
            //DatabaseReferences.MANAGERS_TASKS_COLLECTION_REFERENCE
            )
        .get();

    return tasks;
  }

  // dynamic map;

  // RxBool gettingUsernameOfEmp = false.obs;

  // Future<void> getMap(String collectionReference, String username) async {
  //   gettingUsernameOfEmp.value = true;
  //   map = await _fireStore
  //       .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
  //       .doc(_userActivitiesController.companyName.value.toUpperCase())
  //       .collection(collectionReference)
  //       .where("username", isEqualTo: username)
  //       .get()
  //       .then(
  //     (value) {
  //       gettingUsernameOfEmp.value = false;
  //       //return gettingUsernameOfEmp.value;
  //     },
  //   ).onError(
  //     (error, stackTrace) {
  //       Get.snackbar("Error", "Cannot find user with username $username",
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white,
  //           duration: Duration(seconds: 5),
  //           borderRadius: 20.0,
  //           snackPosition: SnackPosition.TOP);
  //       gettingUsernameOfEmp.value = false;

  //       //  return gettingUsernameOfEmp.value;
  //     },
  //   );
  //   //return gettingUsernameOfEmp.value; // Add this line to ensure a boolean value is always returned
  // }

  // Stream<QuerySnapshot<Map<String, dynamic>>>? getTasklist(
  //     bool ofManager, String username, String typeOfTasks) {
  //   //  fetchAssignedTaskToEmp.value = true;
  //   DocumentReference empRef;

  //   // QuerySnapshot<Map<String, dynamic>> assignedTasks;

  //   String taskCollectionRef = "";

  //   switch (typeOfTasks) {
  //     case "Assigned":
  //       taskCollectionRef =
  //           DatabaseReferences.MANAGERS_TASKS_COLLECTION_REFERENCE;
  //       break;
  //     case "In progress":
  //       taskCollectionRef =
  //           DatabaseReferences.MANAGERS_INPROGRESS_TASKS_COLLECTION_REFERENCE;
  //       break;
  //     case "Completed":
  //       taskCollectionRef =
  //           DatabaseReferences.MANAGERS_COMPLETED_TASKS_COLLECTION_REFERENCE;
  //       break;
  //     case "Hold":
  //       taskCollectionRef =
  //           DatabaseReferences.MANAGERS_HOLD_TASKS_COLLECTION_REFERENCE;
  //       break;
  //     default:
  //   }

  //   print("Task Collection Ref: $taskCollectionRef");

  //   String collectionReference = ofManager
  //       ? DatabaseReferences.MANAGERS_COLLECTION_REFERENCE
  //       : DatabaseReferences.EMPLOYEES_COLLECTION_REFERENCE;

  //   // QuerySnapshot<Map<String, dynamic>> map =
  //   //     getMap(collectionReference, username);
  //   //as QuerySnapshot<Map<String, dynamic>>;

  //   print("map != null ${map != null}");
  //   empRef = map.docs.first.reference;

  //   print("EmpRef: ${empRef.id}");
  //   return _fireStore
  //       .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
  //       .doc(_userActivitiesController.companyName.value.toUpperCase())
  //       .collection(collectionReference)
  //       .doc(empRef.id)
  //       .collection(taskCollectionRef
  //           //DatabaseReferences.MANAGERS_TASKS_COLLECTION_REFERENCE
  //           )
  //       .snapshots();

  //   //   return managerTasks;
  // }

  RxBool deletingTask = false.obs;

  RxString selectedTaskTab = "Assigned".obs;

  Future<void> deleteFromAdminSideTask(String taskName) async {
    String adminTaskTypeReference = "";

    switch (selectedTaskTab.value) {
      case "Assigned":
        adminTaskTypeReference =
            DatabaseReferences.ADMINS_ASSIGNED_TASKS_COLLECTION_REFERENCE;
        break;
      case "In progress":
        adminTaskTypeReference =
            DatabaseReferences.ADMIN_INPROGRESS_TASKS_COLLECTION_REFERENCE;
        break;
      case "Completed":
        adminTaskTypeReference =
            DatabaseReferences.ADMIN_COMPLETED_TASKS_COLLECTION_REFERENCE;
        break;
      case "On hold":
        adminTaskTypeReference =
            DatabaseReferences.ADMIN_HOLD_TASKS_COLLECTION_REFERENCE;
        break;
      default:
    }
    DocumentReference taskReference;

    DocumentReference adminReference;

    try {
      await _fireStore
          .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
          .doc(_userActivitiesController.companyName.value.toUpperCase())
          .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
          .where("workEmail",
              isEqualTo: _userActivitiesController.workEmail.value)
          .get()
          .then((value) async {
        adminReference = value.docs.first.reference;

        print("taskName $taskName");

        await _fireStore
            .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
            .doc(_userActivitiesController.companyName.value.toUpperCase())
            .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
            .doc(adminReference.id)
            .collection(adminTaskTypeReference)
            .where("taskName", isEqualTo: taskName)
            .get()
            .then((value) async {
          taskReference = value.docs.first.reference;

          await _fireStore
              .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
              .doc(_userActivitiesController.companyName.value.toUpperCase())
              .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
              .doc(adminReference.id)
              .collection(adminTaskTypeReference)
              .doc(taskReference.id)
              .delete()
              .then(
            (value) {
              Get.snackbar(
                  "Selected task deleted from Admin side successfully", "",
                  colorText: Colors.white,
                  backgroundColor: Get.theme.primaryColor,
                  duration: Duration(seconds: 3),
                  borderRadius: 20.0,
                  snackPosition: SnackPosition.TOP);
            },
          ).onError(
            (error, stackTrace) {
              print("FirestoreAdmin Error: $error");

              String cleanedError =
                  error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

              Get.snackbar("Error", cleanedError,
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                  borderRadius: 20.0,
                  snackPosition: SnackPosition.TOP);
            },
          );
        }).onError(
          (error, stackTrace) {
            print("FirestoreManager Error: $error");

            String cleanedError =
                error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

            Get.snackbar("Task not found", cleanedError,
                colorText: Colors.white,
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
                borderRadius: 20.0,
                snackPosition: SnackPosition.TOP);
          },
        );
      }).onError(
        (error, stackTrace) {
          print("FirestoreAdmin Error: $error");

          String cleanedError =
              error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

          Get.snackbar("Admin not found", cleanedError,
              colorText: Colors.white,
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
              borderRadius: 20.0,
              snackPosition: SnackPosition.TOP);
        },
      );
    } catch (e) {
      print("Error: $e");

      String cleanedError =
          e.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

      Get.snackbar("Error", cleanedError,
          colorText: Colors.white,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          borderRadius: 20.0,
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> deleteTask(
      DocumentSnapshot<Object?> document,
      String? appTitle,
      String username,
      bool forManager,
      bool forAdmin,
      bool forTaskOverview) async {
    deletingTask.value = true;
    await document.reference.delete().then(
      (value) async {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

        await deleteFromAdminSideTask(data["taskName"]);

        deletingTask.value = false;
        Get.offUntil(MaterialPageRoute(builder: (_) => AdminDashboardScreen()),
            (route) => false);

        if (!forTaskOverview) {
          Get.to(() => TasksScreen(
                appTitle: appTitle,
                username: username,
                forManager: forManager,
                forAdmin: forAdmin,
              ));
        }

        Get.snackbar("Selected task deleted successfully", "",
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

      deletingTask.value = false;
      Get.snackbar("Error", cleanedError,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          borderRadius: 20.0,
          snackPosition: SnackPosition.TOP);
    });
  }
}
