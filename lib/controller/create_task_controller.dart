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
  TextEditingController remainderController = TextEditingController();
  TextEditingController startDateEditingController = TextEditingController();
  TextEditingController dueDateEditingController = TextEditingController();

  TextEditingController setRemainderOptionController = TextEditingController();

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

  Future<void> createTaskOfManager(
      DocumentSnapshot<Object?>? specificDocumentOfUser) async {
    creatingTask.value = true;
    String name = "";
    await specificDocumentOfUser?.reference.get().then(
      (value) {
        Map<String, dynamic> data = value.data()! as Map<String, dynamic>;
        name = data["firstName"].toString() + data["lastName"].toString();

        print("Name: $name");
      },
    );

    //error

    await _fireStore
        .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
        .doc(_userActivitiesController.companyName.value.toUpperCase())
        .collection(DatabaseReferences.MANAGERS_COLLECTION_REFERENCE)
        .doc(specificDocumentOfUser!.id)
        .collection(DatabaseReferences.TASKS_COLLECTION_REFERENCE)
        .add({
      "taskName": taskNameController.text,
      "status": selectedStatus.value,
      "startDate": startDateEditingController.text,
      "dueDate": dueDateEditingController.text,
      "remainder": remainderController.text,
      "remainderTime": setRemainderOptionController.text,
      "priority": selectedPriority.value,
      "tag": selectedTag.value,
      "remarks": remainderController.text,
    }).then((value) {
      creatingTask.value = false;

      Get.back();

      Get.snackbar("Task assigned to $name successfully", "",
          colorText: Colors.white,
          backgroundColor: Get.theme.primaryColor,
          duration: Duration(seconds: 5),
          borderRadius: 20.0,
          snackPosition: SnackPosition.TOP);
    }).onError((error, stackTrace) {
      print("FirestoreEmp Error: $error");

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
  }
}
