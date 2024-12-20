import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/constants/strings.dart';

class RepeatTaskController extends GetxController {
  String _selectedOption = CommonStrings.selectedOption;

  String get selectedOption => _selectedOption;

  void updateSelectedOption(String option) {
    _selectedOption = option;
    update();
  }

  RxBool dataSetForRepeatTask = false.obs;

  //RxString selectedOption = "Do not stop repeating this task".obs;

  RxString selectedDate = "".obs;

  var repeatTaskDateEditingController = TextEditingController().obs;

  var setRemainderOptionController = TextEditingController().obs;

  List<String> setRemainderOptions = [
    // "On due date",
    "1 day before",
    "2 days before",
    "3 days before",
    "1 week before",
    "Custom"
  ];

  // List<String> setRepeatTaskRemainderOptions = [
  //   // "On due date",
  //   "1 day before",
  //   "2 days before",
  //   "3 days before",

  // ];

  List<String> noOfWeeks = [
    "1",
    "2",
    "3",
    "4",
  ];

  RxString selectNoOfWeek = "1".obs;

  RxMap<String, bool> daysMap = <String, bool>{
    "Sun": false,
    "Mon": false,
    "Tue": false,
    "Wed": false,
    "Thu": false,
    "Fri": false,
    "Sat": false,
  }.obs;

  get listOfDays => daysMap.entries.map((e) => e.key).toList();

  void toggle(String day) {
    //   print("CONTROLLER ${_productsMap.length}");
    if (daysMap.containsKey(day)) {
      daysMap[day] = !(daysMap[day] ?? true);
    } else {
      daysMap[day] = true;
    }
    print("CONTROLLER ${daysMap.length}");
  }

  List<String> get selectedDays => daysMap.entries
      .where((element) => element.value)
      .map((e) => e.key)
      .toList();

//////////////////////////////////////////////////////////////////////////////

  RxMap<String, bool> daysOfWeekMap = <String, bool>{
    "Sun": false,
    "Mon": false,
    "Tue": false,
    "Wed": false,
    "Thu": false,
    "Fri": false,
    "Sat": false,
  }.obs;

  get listOfWeekDays => daysOfWeekMap.entries.map((e) => e.key).toList();

  void toggleWeekDays(String day) {
    //   print("CONTROLLER ${_productsMap.length}");
    if (daysOfWeekMap.containsKey(day)) {
      daysOfWeekMap[day] = !(daysOfWeekMap[day] ?? true);
    } else {
      daysOfWeekMap[day] = true;
    }
    print("CONTROLLER ${daysOfWeekMap.length}");
  }

  List<String> get selectedWeekDays => daysOfWeekMap.entries
      .where((element) => element.value)
      .map((e) => e.key)
      .toList();

  ///////////////////////////////////////////////////////////////////

  RxMap<String, bool> monthsMap = <String, bool>{
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

  get listOfMonths => monthsMap.entries.map((e) => e.key).toList();

  void toggleMonth(String month) {
    //   print("CONTROLLER ${_productsMap.length}");
    if (monthsMap.containsKey(month)) {
      monthsMap[month] = !(monthsMap[month] ?? true);
    } else {
      monthsMap[month] = true;
    }
    print("CONTROLLER ${monthsMap.length}");
  }

  List<String> get selectedMonths => monthsMap.entries
      .where((element) => element.value)
      .map((e) => e.key)
      .toList();

  List<int> getYears() {
    final currentYear = DateTime.now().year;

    return List.generate(5 + 1, (index) => currentYear + index);
  }

  RxMap<String, bool> yearsMap = <String, bool>{}.obs;

  void createYearMap() {
    getYears().forEach((element) {
      yearsMap[element.toString()] = false;
    });

    print("YEARS MAP ${yearsMap.length}");
  }

  get listOfYears => yearsMap.entries.map((e) => e.key).toList();

  void toggleYear(String year) {
    //   print("CONTROLLER ${_productsMap.length}");
    if (yearsMap.containsKey(year)) {
      yearsMap[year] = !(yearsMap[year] ?? true);
    } else {
      yearsMap[year] = true;
    }
    print("CONTROLLER ${yearsMap.length}");
  }

  List<String> get selectedYears => yearsMap.entries
      .where((element) => element.value)
      .map((e) => e.key)
      .toList();

  // RxInt selectedYear = 2024.obs;

  RxList selectedDaysForRepeatingTask = [].obs;
  // "Repeat task on ".obs;

  RxString dateToStopRepeatingTask = "".obs;

  RxString remainderDateOfRepeatingTask = "".obs;

  TextEditingController remainderTimeController = TextEditingController();

  //RxString onWhichBasis = "".obs;

  RxString selectedTab = "daily".obs;
}
