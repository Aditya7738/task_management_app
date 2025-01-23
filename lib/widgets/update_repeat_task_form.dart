import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:task_management_app/constants/fontsizes.dart';
import 'package:task_management_app/constants/strings.dart';
import 'package:task_management_app/controller/create_task_controller.dart';
import 'package:task_management_app/controller/repeat_task_controller.dart';
import 'package:task_management_app/controller/update_repeat_task_controller.dart';
import 'package:task_management_app/controller/validation_helper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class UpdateRepeatTaskForm extends StatefulWidget {
  final Map<String, dynamic> data;
  UpdateRepeatTaskForm({super.key, required this.data});
  @override
  State<UpdateRepeatTaskForm> createState() => _UpdateRepeatTaskFormState();
}

class _UpdateRepeatTaskFormState extends State<UpdateRepeatTaskForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    _updateRepeatTaskController.createYearMap();

    print(
        "widget.data[dateToStopRepeatingTask.toString() ${widget.data["dateToStopRepeatingTask"].toString()}");

    if (widget.data["willTaskStopRepeating"]) {
      _updateRepeatTaskController.repeatTaskDateEditingController.value.text =
          widget.data["dateToStopRepeatingTask"].toString();
      _updateRepeatTaskController.updateSelectedOption(
          "On ${_updateRepeatTaskController.repeatTaskDateEditingController.value.text}");
    } else {
      _updateRepeatTaskController
          .updateSelectedOption(CommonStrings.selectedOption);
    }

    // List list = [];
    // list.forEach((element) {

    // },)

    List<String> listOfDays = <String>[];

    if (widget.data["repeatTaskOn"] != null) {
      if (widget.data["repeatTaskOn"].isNotEmpty) {
        widget.data["repeatTaskOn"].forEach(
          (element) {
            listOfDays.add(element.toString());
          },
        );
      }
    }

    switch (widget.data["repeatTaskOnBasisOf"].toString().toLowerCase()) {
      //   ["Daily", "Weekly", "Monthly", "Yearly"]
      case "daily":
        _updateRepeatTaskController.daysMap.forEach(
          (key, value) {
            if (listOfDays.isNotEmpty) {
              if (listOfDays.contains(key)) {
                _updateRepeatTaskController.daysMap[key] = true;
              }
            }
          },
        );
        break;
      case "weekly":
        _updateRepeatTaskController.daysOfWeekMap.forEach(
          (key, value) {
            if (listOfDays.isNotEmpty) {
              if (listOfDays.contains(key)) {
                _updateRepeatTaskController.selectedWeekDays.add(key);
                _updateRepeatTaskController.daysOfWeekMap[key] = true;
              }
            }
          },
        );

        _updateRepeatTaskController.selectNoOfWeek.value =
            widget.data["repeatOnNoOfWeeks"].toString();

        break;
      case "monthly":
        _updateRepeatTaskController.monthsMap.forEach(
          (key, value) {
            if (listOfDays.isNotEmpty) {
              if (listOfDays.contains(key)) {
                _updateRepeatTaskController.monthsMap[key] = true;
              }
            }
          },
        );
        break;
      case "yearly":
        _updateRepeatTaskController.yearsMap.forEach(
          (key, value) {
            if (listOfDays.isNotEmpty) {
              if (listOfDays.contains(key)) {
                _updateRepeatTaskController.yearsMap[key] = true;
              }
            }
          },
        );
        break;
      default:
    }

    _updateRepeatTaskController.remainderTimeController.text =
        widget.data["remainderTimeOfRepeatingTask"].toString();

    // _updateRepeatTaskController.noOfWeeksController.value.text = "1";
  }

  UpdateRepeatTaskController _updateRepeatTaskController =
      Get.put(UpdateRepeatTaskController());

  Future<String> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2025),
        lastDate: DateTime(2026));

    _updateRepeatTaskController.repeatTaskStopDate = picked;

    if (picked != null) {
      print(" DATE ${picked.toLocal().toString()}");
      return "${picked.day}-${picked.month}-${picked.year}";
    } else {
      return "00-00-0000";
    }
  }

  List<Widget> tabBody() => [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("On  "),
                SizedBox(
                  width: Get.width * 0.8,
                  //  width: 200.0,
                  height: 30.0,
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: _updateRepeatTaskController.listOfDays.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => CheckboxMenuButton(
                            value: _updateRepeatTaskController.selectedDays
                                .contains(_updateRepeatTaskController
                                    .listOfDays[index]),
                            onChanged: (value) {
                              _updateRepeatTaskController.toggle(
                                  _updateRepeatTaskController
                                      .listOfDays[index]);

                              // _updateRepeatTaskController.selectedDaysForRepeatingTask.add()
                            },
                            child: Text(
                                _updateRepeatTaskController.listOfDays[index]),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        Column(
          //  mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Every  "),
                // Container(

                //     // color: Colors.red,
                //     height: 50.0,
                //     width: 100.0,
                //     child: TextFormField(
                //       style:
                //           TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                //       controller:
                //           _updateRepeatTaskController.noOfWeeksController.value,
                //       //keyboardType: TextInputType.name,
                //       decoration: InputDecoration(
                //         suffix: DropdownButton(
                //           borderRadius: BorderRadius.circular(10.0),
                //           iconSize: 25.0,
                //           icon: Container(
                //             margin: const EdgeInsets.only(right: 10.0),
                //             child:
                //                 const Icon(Icons.keyboard_arrow_down_rounded),
                //           ),
                //           items: _updateRepeatTaskController.noOfWeeks
                //               .map<DropdownMenuItem<String>>((noOfWeek) {
                //             return DropdownMenuItem<String>(
                //               value: noOfWeek,
                //               child: Padding(
                //                 padding: const EdgeInsets.only(
                //                   left: 10.0,
                //                 ),
                //                 child: Text(noOfWeek),
                //               ),
                //             );
                //           }).toList(),
                //           onChanged: (value) {
                //             print("noOfWeeks ${value.toString()}");

                //             _updateRepeatTaskController.noOfWeeksController.value
                //                 .text = value.toString();

                //             print(
                //                 " _updateRepeatTaskController.noOfWeeksController.value.text ${_updateRepeatTaskController.noOfWeeksController.value.text}");
                //           },
                //         ),
                //         border: const OutlineInputBorder(
                //             borderSide: BorderSide(
                //               color: Color.fromARGB(255, 221, 221, 221),
                //             ),
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(10.0))),
                //       ),
                //       maxLines: 1,
                //     )),

                Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _updateRepeatTaskController.selectNoOfWeek.value,
                      icon: Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.arrow_drop_down_rounded)),
                      items: _updateRepeatTaskController.noOfWeeks
                          .map<DropdownMenuItem<String>>(
                        (noOfWeek) {
                          return DropdownMenuItem(
                              value: noOfWeek,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(noOfWeek),
                              ));
                        },
                      ).toList(),
                      onChanged: (value) {
                        _updateRepeatTaskController.selectNoOfWeek.value =
                            value.toString();
                      },
                    ),
                  ),
                ),
                Text("  week(s)"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("On  "),
                SizedBox(
                  width: Get.width * 0.8,
                  //  width: 200.0,
                  height: 50.0,
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: false,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _updateRepeatTaskController.listOfWeekDays.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => CheckboxMenuButton(
                            value: _updateRepeatTaskController.selectedWeekDays
                                .contains(_updateRepeatTaskController
                                        .listOfWeekDays[
                                    index]), //_updateRepeatTaskController.productsMap[index],

                            onChanged: (value) {
                              _updateRepeatTaskController.toggleWeekDays(
                                  _updateRepeatTaskController.listOfWeekDays[
                                      index]); //_updateRepeatTaskController.toggle(_updateRepeatTaskController.listOfWeekDays[index]);
                            },
                            child: Text(_updateRepeatTaskController
                                .listOfWeekDays[index]),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("On  "),
                SizedBox(
                  width: Get.width * 0.8,
                  //  width: 200.0,
                  height: 30.0,
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: false,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _updateRepeatTaskController.listOfMonths.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => CheckboxMenuButton(
                            value: _updateRepeatTaskController.selectedMonths
                                .contains(_updateRepeatTaskController
                                        .listOfMonths[
                                    index]), //_updateRepeatTaskController.productsMap[index],

                            onChanged: (value) {
                              _updateRepeatTaskController.toggleMonth(
                                  _updateRepeatTaskController.listOfMonths[
                                      index]); //_updateRepeatTaskController.toggle(_updateRepeatTaskController.listOfMonths[index]);
                            },
                            child: Text(_updateRepeatTaskController
                                .listOfMonths[index]),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),

        // CalendarDatePicker(
        //   initialCalendarMode: DatePickerMode.year,
        //   initialDate: DateTime.now(),
        //   firstDate: DateTime(2025),
        //   lastDate: DateTime(2028),
        //   onDateChanged: (newDate) {
        //     // Handle date change
        //   },
        // ),
        // Obx(
        //   () => YearPicker(
        //     initialDate: DateTime(2024),
        //     firstDate: DateTime(2025),
        //     lastDate: DateTime(2028),
        //     selectedDate: DateTime(_updateRepeatTaskController.selectedYear.value),
        //     onChanged: (newDate) {
        //       // Handle date change
        //       _updateRepeatTaskController.selectedYear.value = newDate.year;
        //     },
        //   ),
        // )
        // SfDateRangePicker(
        //   view: DateRangePickerView.year,
        //   selectionMode: DateRangePickerSelectionMode.extendableRange,
        //   initialSelectedDate: DateTime.now(),
        //   onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
        //     // Handle date change
        //     // _updateRepeatTaskController.selectedYear.value = args.value;

        //     print("args.value ${args.value}");
        //   },
        // )

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Scrollbar(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _updateRepeatTaskController.listOfYears.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => CheckboxMenuButton(
                      value: _updateRepeatTaskController.selectedYears.contains(
                          _updateRepeatTaskController.listOfYears[
                              index]), //_updateRepeatTaskController.productsMap[index],

                      onChanged: (value) {
                        _updateRepeatTaskController.toggleYear(
                            _updateRepeatTaskController.listOfYears[
                                index]); //_updateRepeatTaskController.toggle(_updateRepeatTaskController.listOfYears[index]);
                      },
                      child:
                          Text(_updateRepeatTaskController.listOfYears[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ];

  List<String> tabNames = ["Daily", "Weekly", "Monthly", "Yearly"];

  List<Tab> tabs() {
    List<Tab> tabs = [];
    for (var tab in tabNames) {
      tabs.add(
        Tab(
          child: Container(
            child: Text(
              tab,
              style: TextStyle(
                //   color: Theme.of(context).primaryColor,
                fontSize: 13,

                letterSpacing: -0.28,
              ),
            ),
          ),
        ),
      );
    }
    return tabs;
  }
  //  [

  //   Tab(
  //     child: Container(
  //       child: const Text(
  //         'Weekly',
  //         style: TextStyle(
  //           //   color: Theme.of(context).primaryColor,
  //           fontSize: 13,

  //           letterSpacing: -0.28,
  //         ),
  //       ),
  //     ),
  //   ),
  //   Tab(
  //     child: Container(
  //       child: const Text(
  //         'Monthly',
  //         style: TextStyle(
  //           fontSize: 13,
  //         ),
  //       ),
  //     ),
  //   ),
  //   Tab(
  //     child: Container(
  //       child: const Text(
  //         'Yearly',
  //         style: TextStyle(
  //           //   color: Theme.of(context).primaryColor,
  //           fontSize: 13,

  //           letterSpacing: -0.28,
  //         ),
  //       ),
  //     ),
  //   ),
  // ];

  Future<String> selectedTime(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (timeOfDay != null) {
      print(" DATE ${timeOfDay.toString()}");
      return "${timeOfDay.hour}:${timeOfDay.minute}";
    } else {
      return "00:00";
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CreateTaskController createTaskController = Get.put(CreateTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.close_rounded,
            //color: Theme.of(context).primaryColor,
            size: 20.0,
          ),
        ),
        title: Text(
          "Update Repeat Task",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _updateRepeatTaskController.dataSetForRepeatTask.value = true;
                Get.back();
              }
            },
            child: Container(
              // width: 150.64,
              height: 30,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 15.0, top: 5.0, bottom: 5.0),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: ShapeDecoration(
                color: const Color.fromARGB(255, 17, 35, 230),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Update',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 15.0,

                  //height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 17.0, right: 17.0, bottom: 15.0, top: 5.0),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create new copies",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: kToolbarHeight - 18.0,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 218, 218, 218)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3.0)),
                      child: TabBar(
                        tabs: tabs(),
                        onTap: (value) {
                          _updateRepeatTaskController.selectedTab.value =
                              tabNames[value];

                          _updateRepeatTaskController.daysMap.forEach(
                            (key, _) => _updateRepeatTaskController
                                .daysMap[key] = false,
                          );

                          _updateRepeatTaskController.daysOfWeekMap.forEach(
                            (key, _) => _updateRepeatTaskController
                                .daysOfWeekMap[key] = false,
                          );

                          _updateRepeatTaskController.monthsMap.forEach(
                            (key, _) => _updateRepeatTaskController
                                .monthsMap[key] = false,
                          );

                          _updateRepeatTaskController.yearsMap.forEach(
                            (key, _) => _updateRepeatTaskController
                                .yearsMap[key] = false,
                          );
                        },
                        controller: _tabController,
                        labelColor: Colors.white,
                        indicatorColor: const Color.fromARGB(255, 17, 35, 230),
                        //unselectedLabelColor: Colors.black,
                        unselectedLabelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          color: const Color.fromARGB(255, 17, 35, 230),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: Get.width,
                      height: Get.height * 0.4,
                      child: TabBarView(
                        controller: _tabController,
                        children: tabBody(),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "When do you want to stop repeating task?",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    GetBuilder<UpdateRepeatTaskController>(
                      builder: (controller) => RadioMenuButton(
                        value: CommonStrings.selectedOption,
                        groupValue: controller.selectedOption,
                        onChanged: (value) {
                          controller.updateSelectedOption(value.toString());
                          controller
                              .repeatTaskDateEditingController.value.text = "";
                        },
                        child: Text(CommonStrings.selectedOption),
                      ),
                    ),
                    GetBuilder<UpdateRepeatTaskController>(
                      builder: (controller) => RadioMenuButton(
                        value:
                            "On ${controller.repeatTaskDateEditingController.value.text}",
                        //"On",
                        groupValue: controller.selectedOption,
                        onChanged: (value) {
                          controller.updateSelectedOption(value.toString());
                          print("RADIO VALUE $value");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("On "),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                                // height: 50.0,
                                width: (Get.width - 0.5) - 116,
                                // alignment: Alignment.centerLeft,
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize:
                                          FontSizes.textFormFieldFontSize),
                                  validator: (value) {
                                    if (_updateRepeatTaskController
                                                .repeatTaskStopDate !=
                                            null &&
                                        _updateRepeatTaskController
                                                .repeatTaskStopDate !=
                                            "") {
                                      DateTime selected = DateTime.parse(
                                          _updateRepeatTaskController
                                              .repeatTaskStopDate
                                              .toString());
                                      DateTime dueDate = DateTime.parse(
                                          createTaskController.dueDate.value
                                              .toString());
                                      if (dueDate.compareTo(selected) != 1) {
                                        return "Date to stop repeating task should be less than due date";
                                      }
                                    }
                                  },
                                  controller: controller
                                      .repeatTaskDateEditingController.value,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () async {
                                    print("CALENDAR PRESSED");

                                    // print(
                                    //     "controller.selectedOption.contains(On) == false ${controller.selectedOption.contains("On") == false}");
                                    // if (controller.selectedOption
                                    //     .contains("On")) {
                                    //   Get.snackbar(
                                    //       "Please select radio button first",
                                    //       "",
                                    //       backgroundColor: Colors.red,
                                    //       colorText: Colors.white,
                                    //       duration: Duration(seconds: 5),
                                    //       borderRadius: 20.0,
                                    //       snackPosition: SnackPosition.TOP);
                                    // } else {
                                    controller
                                        .repeatTaskDateEditingController
                                        .value
                                        .text = await _selectedDate(context);
                                    // }
                                  },
                                  decoration: InputDecoration(
                                    errorMaxLines: 2,
                                    errorStyle: TextStyle(
                                        fontSize: 15, color: Colors.red),
                                    suffixIcon: const Icon(
                                      Icons.calendar_month_outlined,
                                      size: 20.0,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                  ),
                                  maxLines: 1,
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Text(
                      "Set remainder on same day",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    TextFormField(
                      validator: ValidationHelper.nullOrEmptyString,
                      style:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      controller:
                          _updateRepeatTaskController.remainderTimeController,
                      keyboardType: TextInputType.datetime,
                      onTap: () async {
                        print("CLOCK PRESSED");

                        _updateRepeatTaskController.remainderTimeController
                            .text = await selectedTime(context);
                      },
                      decoration: InputDecoration(
                        // errorStyle:
                        //     TextStyle(fontSize: 15.sp, color: Colors.red),
                        suffixIcon: const Icon(
                          Iconsax.clock_outline,
                          size: 20.0,
                        ),
                        labelStyle: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        labelText: "Select time",
                      ),
                      maxLines: 1,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
