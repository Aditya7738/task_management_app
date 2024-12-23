import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/constants/database_references.dart';
import 'package:task_management_app/controller/user_activities_controller.dart';

class TaskScreenController extends GetxController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  // RxString selectedTask = "Assigned".obs;

  UserActivitiesController _userActivitiesController =
      Get.put(UserActivitiesController());

  RxBool fetchAssignedTaskToEmp = false.obs;

  Future<QuerySnapshot<Map<String, dynamic>>> getAssignedTasklist(
      bool ofManager, String username) async {
    fetchAssignedTaskToEmp.value = true;
    DocumentReference empRef;

    // QuerySnapshot<Map<String, dynamic>> assignedTasks;

    String collectionReference = ofManager
        ? DatabaseReferences.MANAGERS_COLLECTION_REFERENCE
        : DatabaseReferences.EMPLOYEES_COLLECTION_REFERENCE;

    await _fireStore
        .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
        .doc(_userActivitiesController.companyName.value.toUpperCase())
        .collection(collectionReference)
        .where("username", isEqualTo: username)
        .get()
        .then(
      (value) async {
        empRef = value.docs.first.reference;

        await _fireStore
            .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
            .doc(_userActivitiesController.companyName.value.toUpperCase())
            .collection(collectionReference)
            .doc(empRef.id)
            .collection(DatabaseReferences.MANAGERS_TASKS_COLLECTION_REFERENCE)
            .get()
            .then(
          (value) {
            return value;
          },
        ).onError(
          (error, stackTrace) {
            print("Firestore Error: $error");

            fetchAssignedTaskToEmp.value = false;

            String cleanedError =
                error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

            Get.snackbar("Error", cleanedError,
                colorText: Colors.white,
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
                borderRadius: 20.0,
                snackPosition: SnackPosition.TOP);

            throw Exception(cleanedError);
          },
        ).onError(
          (error, stackTrace) {
            print("Firestore Error: $error");

            fetchAssignedTaskToEmp.value = false;

            String cleanedError =
                error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

            Get.snackbar("Error", cleanedError,
                colorText: Colors.white,
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
                borderRadius: 20.0,
                snackPosition: SnackPosition.TOP);

            throw Exception(cleanedError);
          },
        );
      },
    ).onError(
      (error, stackTrace) {
        print("Firestore Error: $error");

        fetchAssignedTaskToEmp.value = false;

        String cleanedError =
            error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

        Get.snackbar("Error", cleanedError,
            colorText: Colors.white,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);

        throw Exception(cleanedError);
      },
    );

    return Future.error("Failed to fetch assigned tasks");

    //   try {
    //     await _fireStore
    //         .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
    //         .doc(_userActivitiesController.companyName.value.toUpperCase())
    //         .collection(collectionReference)
    //         .where("workEmail",
    //             isEqualTo: _userActivitiesController.workEmail.value)
    //         .get()
    //         .then(
    //       (value) async {
    //         adminReference = value.docs.first.reference;

    //         await _fireStore
    //             .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
    //             .doc(_userActivitiesController.companyName.value.toUpperCase())
    //             .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
    //             .doc(adminReference.id)
    //             .collection(
    //                 DatabaseReferences.ADMINS_ASSIGNED_TASKS_COLLECTION_REFERENCE)
    //             .get()
    //             .then(
    //           (value) {
    //             fetchAssignedTaskToEmp.value = false;

    //             Get.snackbar("Tasks fetched successfully", "",
    //                 colorText: Colors.white,
    //                 backgroundColor: Get.theme.primaryColor,
    //                 duration: Duration(seconds: 4),
    //                 borderRadius: 20.0,
    //                 snackPosition: SnackPosition.TOP);

    //             //     assignedTasks = value;

    //             return value;
    //           },
    //         ).onError(
    //           (error, stackTrace) {
    //             print("FirestoreAdmin Error: $error");

    //             fetchAssignedTaskToEmp.value = false;

    //             String cleanedError =
    //                 error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

    //             Get.snackbar("Error", cleanedError,
    //                 colorText: Colors.white,
    //                 backgroundColor: Colors.red,
    //                 duration: Duration(seconds: 5),
    //                 borderRadius: 20.0,
    //                 snackPosition: SnackPosition.TOP);

    //             throw Exception(cleanedError);
    //           },
    //         );
    //       },
    //     ).onError(
    //       (error, stackTrace) {
    //         print("FirestoreManager Error: $error");

    //         fetchAssignedTaskToEmp.value = false;

    //         String cleanedError =
    //             error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

    //         Get.snackbar("Error", cleanedError,
    //             colorText: Colors.white,
    //             backgroundColor: Colors.red,
    //             duration: Duration(seconds: 5),
    //             borderRadius: 20.0,
    //             snackPosition: SnackPosition.TOP);

    //         //  throw Exception(cleanedError);
    //       },
    //     );

    //     // doc.get().then(
    //     //       (value) {
    //     //         value.reference.i
    //     //       },
    //     //     );
    //   } catch (e) {
    //     print("Error: $e");

    //     fetchAssignedTaskToEmp.value = true;

    //     String cleanedError =
    //         e.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

    //     Get.snackbar("Error", cleanedError,
    //         colorText: Colors.white,
    //         backgroundColor: Colors.red,
    //         duration: Duration(seconds: 5),
    //         borderRadius: 20.0,
    //         snackPosition: SnackPosition.TOP);
    //     //  throw Exception("Failed to fetch assigned tasks");
    //   }
    //   return Future.error("Failed to fetch assigned tasks");
    // }
  }
}
