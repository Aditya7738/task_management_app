import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CreateTaskController extends GetxController {
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

  List<String> tags = ["No tags added", "tag1", "tag2", "tag3"];

  RxString selectedTag = "No tags added".obs;

  var startDateEditingController = TextEditingController().obs;
  var dueDateEditingController = TextEditingController().obs;

  // RxString startDate = "Not set yet".obs;

  // List<String> assignee = ["Unassigned", "abc", "bcd", "efg"];

  RxList<Appointment> appointments = <Appointment>[].obs;

  RxBool isStartDateSelected = false.obs;

  RxBool isPioritySelected = false.obs;
}
