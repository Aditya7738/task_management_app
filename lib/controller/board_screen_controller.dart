import 'package:get/get.dart';

class BoardScreenController extends GetxController {
  List<String> boards = [
    "All tasks",
    "Completed",
    "Pending",
  ];

  RxString selectedBoard = "Pending".obs;
}
