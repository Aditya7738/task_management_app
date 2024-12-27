import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_management_app/constants/database_references.dart';
import 'package:task_management_app/constants/strings.dart';
import 'package:task_management_app/controller/repeat_task_controller.dart';
import 'package:task_management_app/controller/user_activities_controller.dart';

class CreateTaskController extends GetxController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  RxList<String> employeesToAssign = <String>[].obs;

  RxBool isEmployeeAssigned = false.obs;

  RxString assignedTo = "".obs;

  setAssignedTo(String value) {
    assignedTo.value = value;

    update();
  }

  List<String> sections = [
    "Choose Section",
    "Section1",
    "Section2",
    "Section3"
  ];

  RxString taskLabel = "Assigned to".obs;

  List<String> statuses = ["Assigned", "In progress", "Completed", "On hold"];

  RxString selectedStatus = "Assigned".obs;

  List<String> priorities = ["High", "Medium", "Low"];

  RxString selectedPriority = "High".obs;

  List<String> tags = ["No tags added", "Development", "Sales", "Testing"];

  RxString selectedTag = "No tags added".obs;

  RxBool statusUpdated = false.obs;

  TextEditingController taskNameController = TextEditingController();
  TextEditingController remainderTimeController = TextEditingController();
  TextEditingController startDateEditingController = TextEditingController();
  TextEditingController dueDateEditingController = TextEditingController();

  TextEditingController setRemainderOptionController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  dynamic startDate = DateTime.now().obs;
  dynamic dueDate = DateTime.now().obs;

  // RxString startDate = "Not set yet".obs;

  // List<String> assignee = ["Unassigned", "abc", "bcd", "efg"];

  RxList<Appointment> appointments = <Appointment>[].obs;

  RxBool isStartDateSelected = false.obs;

  RxBool isPioritySelected = false.obs;

  RxBool showPriorityError = false.obs;

  RxBool showStatusError = false.obs;

  UserActivitiesController _userActivitiesController =
      Get.put(UserActivitiesController());

  RxBool creatingTask = false.obs;

  RxMap<String, dynamic> data = <String, dynamic>{}.obs;

  RepeatTaskController repeatTaskController = Get.put(RepeatTaskController());

  List<String> getSelectedOptionsList() {
    if (repeatTaskController.selectedDays.isNotEmpty) {
      return repeatTaskController.selectedDays;
    } else if (repeatTaskController.selectedWeekDays.isNotEmpty) {
      return repeatTaskController.selectedWeekDays;
    } else if (repeatTaskController.selectedMonths.isNotEmpty) {
      return repeatTaskController.selectedMonths;
    } else if (repeatTaskController.selectedYears.isNotEmpty) {
      return repeatTaskController.selectedYears;
    } else {
      return [];
    }
  }

  bool isRepeatingTask() {
    if (repeatTaskController.selectedOption == CommonStrings.selectedOption) {
      return true;
    } else {
      return false;
    }
  }

  RxBool showSelectedEmpError = false.obs;

  TextEditingController assignedByController = TextEditingController();

  RxBool gettingUsers = false.obs;

  Future getUserList(bool forManager) async {
    gettingUsers.value = true;

    //employeesToAssign.clear();

    print("employeesToAssign.length ${employeesToAssign.length}");

    employeesToAssign.value.add("Choose employee");

    employeesToAssign.value.forEach(
      (element) {
        print("element $element");
      },
    );

    print("employeesToAssign.length ${employeesToAssign.value.length}");

    String collectionReference = forManager
        ? DatabaseReferences.MANAGERS_COLLECTION_REFERENCE
        : DatabaseReferences.EMPLOYEES_COLLECTION_REFERENCE;

    await _fireStore
        .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
        .doc(_userActivitiesController.companyName.value.toUpperCase())
        .collection(collectionReference)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          employeesToAssign.value
              .add(data["firstName"] + " " + data["lastName"]);
        });
      }

      gettingUsers.value = false;
    }).onError(
      (error, stackTrace) {
        print("Firebase Error: $error");

        gettingUsers.value = false;

        String cleanedError =
            error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();
        //cleanedText.trim();

        //  logingAccount.value = false;
        Get.snackbar("Error", cleanedError,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 5),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
      },
    );

    employeesToAssign.value.forEach(
      (element) {
        print("element 2 $element");
      },
    );

    // await _fireStore
    //     .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
    //     .doc(_userActivitiesController.companyName.value.toUpperCase())
    //     .collection(DatabaseReferences.EMPLOYEES_COLLECTION_REFERENCE)
    //     .get()
    //     .then((value) {
    //   if (value.docs.isNotEmpty) {
    //     value.docs.forEach((DocumentSnapshot document) {
    //       Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    //       employeesToAssign.add(data["firstName"] + " " + data["lastName"]);
    //     });
    //   }

    //   gettingUsers.value = false;
    // }).onError(
    //   (error, stackTrace) {
    //     print("Firebase Error: $error");
    //     gettingUsers.value = false;
    //     String cleanedError =
    //         error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();
    //     //cleanedText.trim();

    //     //  logingAccount.value = false;
    //     Get.snackbar("Error", cleanedError,
    //         backgroundColor: Colors.red,
    //         colorText: Colors.white,
    //         duration: Duration(seconds: 5),
    //         borderRadius: 20.0,
    //         snackPosition: SnackPosition.TOP);
    //   },
    // );

    print("employeesToAssign.length ${employeesToAssign.value.length}");

    update();
  }

  SupabaseClient supabase = Supabase.instance.client;

  // CreateTaskController createTaskController = Get.put(CreateTaskController());

  Future<void> uploadDocument() async {
    try {
      // final String bucketId =
      //     await supabase.storage.createBucket(DatabaseReferences.bucketId);

      //    print("bucketId $bucketId");

      if (await Permission.storage.isGranted) {
        FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null && result.files.single.path != null) {
          // File file = File(result.files.single.path!);

          PlatformFile _platformFile = result.files.first;

          File _file = File(result.files.single.path!);

          print("File path: ${_file.path}");
          //   //String fullPath =
          //   await supabase.storage
          //       .from(DatabaseReferences.bucketId)
          //       .upload(
          //           "${_userActivitiesController.companyName.value}/${assignedTo.value}/documents",
          //           file,
          //           fileOptions: FileOptions(cacheControl: '3600', upsert: false),
          //           retryAttempts: 2)
          //       .then(
          //     (value) {
          //       Get.snackbar("Document uploaded successfully", "",
          //           colorText: Colors.white,
          //           backgroundColor: Get.theme.primaryColor,
          //           duration: Duration(seconds: 4),
          //           borderRadius: 20.0,
          //           snackPosition: SnackPosition.TOP);
          //     },
          //   ).onError(
          //     (error, stackTrace) {
          //       print("SUPABASE Error: $error");

          //       //  creatingTask.value = false;

          //       String cleanedError =
          //           error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

          //       Get.snackbar("Error", cleanedError,
          //           colorText: Colors.white,
          //           backgroundColor: Colors.red,
          //           duration: Duration(seconds: 5),
          //           borderRadius: 20.0,
          //           snackPosition: SnackPosition.TOP);
          //     },
          //   );
        } else {
          // User canceled the picker
        }
      }
    } catch (e) {
      print("SUPABASE OR FILEPICKER Error: $e");
    }
  }

  var descriptionController = TextEditingController();

  Future<void> createTask(bool forManager) async {
    creatingTask.value = true;
    String collectionReference = forManager
        ? DatabaseReferences.MANAGERS_COLLECTION_REFERENCE
        : DatabaseReferences.EMPLOYEES_COLLECTION_REFERENCE;

    print(
        "FieldValue.serverTimestamp().toString() ${Timestamp.now().toDate().toString()}");

    String taskCollectionRef = "";

    String adminTaskReference = "";

    switch (selectedStatus.value) {
      case "Assigned":
        taskCollectionRef =
            DatabaseReferences.MANAGERS_TASKS_COLLECTION_REFERENCE;
        adminTaskReference =
            DatabaseReferences.ADMINS_ASSIGNED_TASKS_COLLECTION_REFERENCE;
        break;
      case "In progress":
        taskCollectionRef =
            DatabaseReferences.MANAGERS_INPROGRESS_TASKS_COLLECTION_REFERENCE;
        adminTaskReference =
            DatabaseReferences.ADMIN_INPROGRESS_TASKS_COLLECTION_REFERENCE;
        break;
      case "Completed":
        taskCollectionRef =
            DatabaseReferences.MANAGERS_COMPLETED_TASKS_COLLECTION_REFERENCE;
        adminTaskReference =
            DatabaseReferences.ADMIN_COMPLETED_TASKS_COLLECTION_REFERENCE;
        break;
      case "On hold":
        taskCollectionRef =
            DatabaseReferences.MANAGERS_HOLD_TASKS_COLLECTION_REFERENCE;
        adminTaskReference =
            DatabaseReferences.ADMIN_HOLD_TASKS_COLLECTION_REFERENCE;
        break;
      default:
    }

    try {
      print("data[username] ${data["username"]}");

      DocumentReference reference;

      await _fireStore
          .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
          .doc(_userActivitiesController.companyName.value.toUpperCase())
          .collection(collectionReference)
          .where("username", isEqualTo: data["username"])
          .get()
          .then(
        (value) async {
          reference = value.docs.first.reference;

          print("taskNameController.text ${taskNameController.text}");
          print("selectedStatus.text ${selectedStatus.value}");
          print(
              "startDateEditingController.text ${startDateEditingController.text}");
          print(
              "dueDateEditingController.text ${dueDateEditingController.text}");

          await _fireStore
              .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
              .doc(_userActivitiesController.companyName.value.toUpperCase())
              .collection(collectionReference)
              .doc(reference.id)
              .collection(taskCollectionRef)
              .add({
            "taskName": taskNameController.text,
            "description": descriptionController.text,
            "assignedTo": assignedTo.value,
            "status": selectedStatus.value,
            "startDate": startDateEditingController.text,
            "dueDate": dueDateEditingController.text,
            "remainderTime": remainderTimeController.text,
            "remainderDay": setRemainderOptionController.text,
            "priority": selectedPriority.value,
            "tag": selectedTag.value,
            "remarks": remarkController.text,
            "isTaskRepeated": repeatTaskController.dataSetForRepeatTask.value,
            "repeatTaskOn": getSelectedOptionsList(),
            "willTaskStopRepeating": repeatTaskController.selectedOption !=
                CommonStrings.selectedOption,
            "dateToStopRepeatingTask":
                repeatTaskController.repeatTaskDateEditingController.value.text,
            // "remainderDateOfRepeatingTask": "",
            "remainderTimeOfRepeatingTask":
                repeatTaskController.remainderTimeController.text,
            "timeStamp": Timestamp.now().toDate().toString(),
            //"assignedBy": ,
          }).then(
            (value) {
              // creatingTask.value = false;
              Get.back();

              Get.snackbar("Task stored successfully in user's database", "",
                  colorText: Colors.white,
                  backgroundColor: Get.theme.primaryColor,
                  duration: Duration(seconds: 4),
                  borderRadius: 20.0,
                  snackPosition: SnackPosition.TOP);
            },
          ).onError(
            (error, stackTrace) {
              print("FirestoreManager Task Error: $error");

              creatingTask.value = false;

              String cleanedError =
                  error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

              Get.snackbar("Error", cleanedError,
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                  borderRadius: 20.0,
                  snackPosition: SnackPosition.TOP);

              creatingTask.value = false;
            },
          );
        },
      ).onError((error, stackTrace) {
        print("FirestoreManager Error: $error");

        creatingTask.value = false;

        String cleanedError =
            error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

        Get.snackbar("Error", cleanedError,
            colorText: Colors.white,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
            borderRadius: 20.0,
            snackPosition: SnackPosition.TOP);
      });
    } catch (e) {
      print("Error: $e");

      creatingTask.value = false;

      String cleanedError =
          e.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

      Get.snackbar("Error", cleanedError,
          colorText: Colors.white,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          borderRadius: 20.0,
          snackPosition: SnackPosition.TOP);
    }

    DocumentReference adminReference;

    try {
      await _fireStore
          .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
          .doc(_userActivitiesController.companyName.value.toUpperCase())
          .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
          .where("workEmail",
              isEqualTo: _userActivitiesController.workEmail.value)
          .get()
          .then(
        (value) async {
          adminReference = value.docs.first.reference;

          await _fireStore
              .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
              .doc(_userActivitiesController.companyName.value.toUpperCase())
              .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
              .doc(adminReference.id)
              .collection(adminTaskReference)
              .add({
            "taskName": taskNameController.text,
            "description": descriptionController.text,
            "assignedTo": assignedTo.value,
            "status": selectedStatus.value,
            "startDate": startDateEditingController.text,
            "dueDate": dueDateEditingController.text,
            "remainderTime": remainderTimeController.text,
            "remainderDay": setRemainderOptionController.text,
            "priority": selectedPriority.value,
            "tag": selectedTag.value,
            "remarks": remarkController.text,
            "isTaskRepeated": repeatTaskController.dataSetForRepeatTask.value,
            "repeatTaskOn": getSelectedOptionsList(),
            "willTaskStopRepeating": repeatTaskController.selectedOption !=
                CommonStrings.selectedOption,
            "dateToStopRepeatingTask":
                repeatTaskController.repeatTaskDateEditingController.value.text,
            // "remainderDateOfRepeatingTask": "",
            "remainderTimeOfRepeatingTask":
                repeatTaskController.remainderTimeController.text,
            "timeStamp": Timestamp.now().toDate().toString(),
          }).then(
            (value) {
              creatingTask.value = false;

              Get.snackbar("Task stored successfully in Admin's database", "",
                  colorText: Colors.white,
                  backgroundColor: Get.theme.primaryColor,
                  duration: Duration(seconds: 4),
                  borderRadius: 20.0,
                  snackPosition: SnackPosition.TOP);
            },
          ).onError(
            (error, stackTrace) {
              print("FirestoreAdmin Error: $error");

              creatingTask.value = false;

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
        },
      ).onError(
        (error, stackTrace) {
          print("FirestoreManager Error: $error");

          creatingTask.value = false;

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
    } catch (e) {
      print("Error: $e");

      creatingTask.value = false;

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
}
