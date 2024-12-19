import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_management_app/constants/database_references.dart';
import 'package:task_management_app/controller/user_activities_controller.dart';

class CreateTaskController extends GetxController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  List<String> employeesToAssign = ["Choose employee", "abc", "bcd", "efg"];

  RxBool isEmployeeAssigned = false.obs;

  RxString assignedTo = "Choose employee".obs;

  List<String> sections = [
    "Choose Section",
    "Section1",
    "Section2",
    "Section3"
  ];

  RxBool isSectionSelected = false.obs;

  RxString selectedSection = "Choose Section".obs;

  RxString taskLabel = "Assigned to".obs;

  List<String> statuses = ["Assigned", "In progress", "Completed", "Hold"];

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

  Future<void> createTaskOfManager() async {
    creatingTask.value = true;

    try {
      print("data[username] ${data["username"]}");

      DocumentReference reference;

      await _fireStore
          .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
          .doc(_userActivitiesController.companyName.value.toUpperCase())
          .collection(DatabaseReferences.MANAGERS_COLLECTION_REFERENCE)
          .where("username", isEqualTo: data["username"])
          .get()
          .then(
        (value) async {
          reference = value.docs.first.reference;

          await _fireStore
              .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
              .doc(_userActivitiesController.companyName.value.toUpperCase())
              .collection(DatabaseReferences.MANAGERS_COLLECTION_REFERENCE)
              .doc(reference.id)
              .collection(DatabaseReferences.TASKS_COLLECTION_REFERENCE)
              .add({
            "taskName": taskNameController.text,
            "status": selectedStatus.value,
            "startDate": startDateEditingController.text,
            "dueDate": dueDateEditingController.text,
            "remainderTime": remainderTimeController.text,
            "remainderDay": setRemainderOptionController.text,
            "priority": selectedPriority.value,
            "tag": selectedTag.value,
            "remarks": remarkController.text,
            "isRepeatedTask": false,
            "repeatTaskDays": [],
          }).onError(
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

              creatingTask.value = false;
              return reference as DocumentReference<Map<String, dynamic>>;
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
  }
}
