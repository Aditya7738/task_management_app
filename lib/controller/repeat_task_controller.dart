import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepeatTaskController extends GetxController {
  String _selectedOption = "Do not stop repeating this task";

  String get selectedOption => _selectedOption;

  void updateSelectedOption(String option) {
    _selectedOption = option;
    update();
  }

  //RxString selectedOption = "Do not stop repeating this task".obs;

  RxString selectedDate = "".obs;

  var repeatTaskDateEditingController = TextEditingController().obs;

  var setRemainderOptionController = TextEditingController().obs;

  List<String> setRemainderOptions = [
    "On due date",
    "1 day before",
    "2 days before",
    "3 days before",
    "1 week before",
    "Custom"
  ];

  List<String> noOfWeeks = [
    "1",
    "2",
    "3",
    "4",
  ];

  RxString selectNoOfWeek = "1".obs;

  RxMap<String, bool> _daysMap = <String, bool>{
    "Sun": false,
    "Mon": false,
    "Tue": false,
    "Wed": false,
    "Thu": false,
    "Fri": false,
    "Sat": false,
  }.obs;

  get listOfDays => _daysMap.entries.map((e) => e.key).toList();

  void toggle(String day) {
    //   print("CONTROLLER ${_productsMap.length}");
    if (_daysMap.containsKey(day)) {
      _daysMap[day] = !(_daysMap[day] ?? true);
    } else {
      _daysMap[day] = true;
    }
    print("CONTROLLER ${_daysMap.length}");
  }

  List<String> get selectedDays => _daysMap.entries
      .where((element) => element.value)
      .map((e) => e.key)
      .toList();

  RxMap<String, bool> _monthsMap = <String, bool>{
    "Jan": false,
    "Feb": false,
    "Mar": false,
    "Apr": false,
    "May": false,
    "Jun": false,
    "Jul": false,
    "Aug": false,
    "Sep": false,
    "Oct": false,
    "Nov": false,
    "Dec": false,
  }.obs;

  get listOfMonths => _monthsMap.entries.map((e) => e.key).toList();

  void toggleMonth(String month) {
    //   print("CONTROLLER ${_productsMap.length}");
    if (_monthsMap.containsKey(month)) {
      _monthsMap[month] = !(_monthsMap[month] ?? true);
    } else {
      _monthsMap[month] = true;
    }
    print("CONTROLLER ${_monthsMap.length}");
  }

  get selectedMonths => _monthsMap.entries
      .where((element) => element.value)
      .map((e) => e.key)
      .toList();

  RxInt selectedYear = 2024.obs;

  RxList selectedDaysForRepeatingTask = [].obs;
  // "Repeat task on ".obs;

  RxString dateToStopRepeatingTask = "".obs;

  RxString remainderDateOfRepeatingTask = "".obs;

  //RxString onWhichBasis = "".obs;

  RxString selectedTab = "daily".obs;
}
