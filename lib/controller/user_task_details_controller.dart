import 'package:get/get.dart';

class UserTaskDetailsController extends GetxController {
  RxInt touchedGroupIndex = (-1).obs;

  List<String> taskCategories = [
    "All tasks",
    "Completed",
    "Pending",
  ];

  RxString selectedTaskCategory = "Pending".obs;
}
