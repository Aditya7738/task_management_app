import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:task_management_app/constants/fontsizes.dart';
import 'package:task_management_app/constants/strings.dart';
import 'package:task_management_app/controller/repeat_task_controller.dart';
import 'package:task_management_app/controller/validation_helper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RepeatTaskForm extends StatefulWidget {
  const RepeatTaskForm({super.key});
  @override
  State<RepeatTaskForm> createState() => _RepeatTaskFormState();
}

class _RepeatTaskFormState extends State<RepeatTaskForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    repeatTaskController.createYearMap();
    // repeatTaskController.noOfWeeksController.value.text = "1";
  }

  RepeatTaskController repeatTaskController = Get.put(RepeatTaskController());

  Future<String> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2025));

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
                      itemCount: repeatTaskController.listOfDays.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => CheckboxMenuButton(
                            value: repeatTaskController.selectedDays.contains(
                                repeatTaskController.listOfDays[index]),
                            onChanged: (value) {
                              repeatTaskController.toggle(
                                  repeatTaskController.listOfDays[index]);

                              // repeatTaskController.selectedDaysForRepeatingTask.add()
                            },
                            child: Text(repeatTaskController.listOfDays[index]),
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
                //           repeatTaskController.noOfWeeksController.value,
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
                //           items: repeatTaskController.noOfWeeks
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

                //             repeatTaskController.noOfWeeksController.value
                //                 .text = value.toString();

                //             print(
                //                 " repeatTaskController.noOfWeeksController.value.text ${repeatTaskController.noOfWeeksController.value.text}");
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
                      value: repeatTaskController.selectNoOfWeek.value,
                      icon: Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.arrow_drop_down_rounded)),
                      items: repeatTaskController.noOfWeeks
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
                        repeatTaskController.selectNoOfWeek.value =
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
                      itemCount: repeatTaskController.listOfWeekDays.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => CheckboxMenuButton(
                            value: repeatTaskController.selectedWeekDays
                                .contains(repeatTaskController.listOfWeekDays[
                                    index]), //repeatTaskController.productsMap[index],

                            onChanged: (value) {
                              repeatTaskController.toggle(repeatTaskController
                                      .listOfWeekDays[
                                  index]); //repeatTaskController.toggle(repeatTaskController.listOfWeekDays[index]);
                            },
                            child: Text(
                                repeatTaskController.listOfWeekDays[index]),
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
                      itemCount: repeatTaskController.listOfMonths.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => CheckboxMenuButton(
                            value: repeatTaskController.selectedMonths.contains(
                                repeatTaskController.listOfMonths[
                                    index]), //repeatTaskController.productsMap[index],

                            onChanged: (value) {
                              repeatTaskController.toggleMonth(repeatTaskController
                                      .listOfMonths[
                                  index]); //repeatTaskController.toggle(repeatTaskController.listOfMonths[index]);
                            },
                            child:
                                Text(repeatTaskController.listOfMonths[index]),
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
        //   firstDate: DateTime(2024),
        //   lastDate: DateTime(2028),
        //   onDateChanged: (newDate) {
        //     // Handle date change
        //   },
        // ),
        // Obx(
        //   () => YearPicker(
        //     initialDate: DateTime(2024),
        //     firstDate: DateTime(2024),
        //     lastDate: DateTime(2028),
        //     selectedDate: DateTime(repeatTaskController.selectedYear.value),
        //     onChanged: (newDate) {
        //       // Handle date change
        //       repeatTaskController.selectedYear.value = newDate.year;
        //     },
        //   ),
        // )
        // SfDateRangePicker(
        //   view: DateRangePickerView.year,
        //   selectionMode: DateRangePickerSelectionMode.extendableRange,
        //   initialSelectedDate: DateTime.now(),
        //   onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
        //     // Handle date change
        //     // repeatTaskController.selectedYear.value = args.value;

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
                itemCount: repeatTaskController.listOfYears.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => CheckboxMenuButton(
                      value: repeatTaskController.selectedYears.contains(
                          repeatTaskController.listOfYears[
                              index]), //repeatTaskController.productsMap[index],

                      onChanged: (value) {
                        repeatTaskController.toggleYear(repeatTaskController
                                .listOfYears[
                            index]); //repeatTaskController.toggle(repeatTaskController.listOfYears[index]);
                      },
                      child: Text(repeatTaskController.listOfYears[index]),
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
          "Repeat Task",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                repeatTaskController.dataSetForRepeatTask.value = true;
              }

              //    Get.back();
            },
            child: Container(
              // width: 150.64,
              height: 30,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 15.0, top: 5.0, bottom: 5.0),
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              decoration: ShapeDecoration(
                color: const Color.fromARGB(255, 17, 35, 230),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Save',
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
                          repeatTaskController.selectedTab.value =
                              tabNames[value];

                          repeatTaskController.daysMap.forEach(
                            (key, _) =>
                                repeatTaskController.daysMap[key] = false,
                          );

                          repeatTaskController.daysOfWeekMap.forEach(
                            (key, _) =>
                                repeatTaskController.daysOfWeekMap[key] = false,
                          );

                          repeatTaskController.monthsMap.forEach(
                            (key, _) =>
                                repeatTaskController.monthsMap[key] = false,
                          );

                          repeatTaskController.yearsMap.forEach(
                            (key, _) =>
                                repeatTaskController.yearsMap[key] = false,
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
                    GetBuilder<RepeatTaskController>(
                      builder: (controller) => RadioMenuButton(
                        value: CommonStrings.selectedOption,
                        groupValue: controller.selectedOption,
                        onChanged: (value) {
                          controller.updateSelectedOption(value.toString());
                          repeatTaskController
                              .repeatTaskDateEditingController.value.text = "";
                        },
                        child: Text(CommonStrings.selectedOption),
                      ),
                    ),
                    GetBuilder<RepeatTaskController>(
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
                                height: 50.0,
                                width: 200.0,
                                // alignment: Alignment.centerLeft,
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize:
                                          FontSizes.textFormFieldFontSize),
                                  controller: controller
                                      .repeatTaskDateEditingController.value,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () async {
                                    print("CALENDAR PRESSED");

                                    controller
                                        .repeatTaskDateEditingController
                                        .value
                                        .text = await _selectedDate(context);
                                  },
                                  decoration: InputDecoration(
                                    // errorStyle:
                                    //     TextStyle(fontSize: 15.sp, color: Colors.red),
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
                    // Container(

                    //     // color: Colors.red,
                    //     height: 65.0,
                    //     child: TextFormField(
                    //       validator: ValidationHelper.nullOrEmptyString,
                    //       style: TextStyle(
                    //           fontSize: FontSizes.textFormFieldFontSize),
                    //       controller: repeatTaskController
                    //           .setRemainderOptionController.value,
                    //       //keyboardType: TextInputType.name,
                    //       decoration: InputDecoration(
                    //         hintText: "Select Option",
                    //         hintStyle: TextStyle(
                    //           fontWeight: FontWeight.normal,
                    //           fontSize: 14.0,
                    //           // color: const Color(0x7F555770),
                    //         ),
                    //         suffix: DropdownButton(
                    //           borderRadius: BorderRadius.circular(10.0),
                    //           iconSize: 25.0,
                    //           icon: Container(
                    //             margin: const EdgeInsets.only(right: 10.0),
                    //             child: const Icon(
                    //                 Icons.keyboard_arrow_down_rounded),
                    //           ),
                    //           items: repeatTaskController
                    //               .setRepeatTaskRemainderOptions
                    //               .map<DropdownMenuItem<String>>(
                    //                   (setRemainderOption) {
                    //             return DropdownMenuItem<String>(
                    //               value: setRemainderOption,
                    //               child: Padding(
                    //                 padding: const EdgeInsets.only(
                    //                   left: 10.0,
                    //                 ),
                    //                 child: Text(setRemainderOption),
                    //               ),
                    //             );
                    //           }).toList(),
                    //           onChanged: (value) async {
                    //             // print("RELIGION ${value.toString()}");

                    //             if (value.toString() == "Custom") {
                    //               // createTaskController.setRemainderOptionController
                    //               //     .text =
                    //               //     if (await _selectedDate(context) >) {

                    //               //     }
                    //               //     await _selectedDate(context);

                    //               final DateTime? picked = await showDatePicker(
                    //                   context: context,
                    //                   initialDate: selectedDate,
                    //                   firstDate: DateTime(2024),
                    //                   lastDate: DateTime(2025));

                    //               print("picked != null ${picked != null}");

                    //               if (picked != null) {
                    //                 // if (picked.compareTo(createTaskController.dueDate)  &&
                    //                 //     picked! > createTaskController.startDate) {}

                    //                 print(
                    //                     "picked.compareTo(createTaskController.dueDate.value) !=  ${picked.compareTo(createTaskController.dueDate.value) != 1}");

                    //                 if (picked.compareTo(createTaskController
                    //                         .dueDate.value) !=
                    //                     1) {
                    //                   Get.snackbar("Error",
                    //                       "Remainder date should be grater than start date",
                    //                       backgroundColor: Colors.red,
                    //                       colorText: Colors.white,
                    //                       duration: Duration(seconds: 5),
                    //                       borderRadius: 20.0,
                    //                       snackPosition: SnackPosition.TOP);
                    //                 } else if (picked.compareTo(
                    //                         createTaskController
                    //                             .startDate.value) !=
                    //                     -1) {
                    //                   Get.snackbar("Error",
                    //                       "Remainder date should be less than due date",
                    //                       backgroundColor: Colors.red,
                    //                       colorText: Colors.white,
                    //                       duration: Duration(seconds: 5),
                    //                       borderRadius: 20.0,
                    //                       snackPosition: SnackPosition.TOP);
                    //                 } else {
                    //                   createTaskController
                    //                           .setRemainderOptionController
                    //                           .text =
                    //                       picked
                    //                           .toLocal()
                    //                           .toString()
                    //                           .split(" ")[0];
                    //                 }
                    //               }

                    //               // if (picked != null) {
                    //               //   print(" DATE ${picked.toLocal().toString()}");
                    //               //   // return "${picked.day}-${picked.month}-${picked.year}";
                    //               //   return picked
                    //               //       .toLocal()
                    //               //       .toString()
                    //               //       .split(" ")[0];
                    //               // } else {
                    //               //   return "00-00-0000";
                    //               // }
                    //             } else {
                    //               repeatTaskController
                    //                   .setRemainderOptionController
                    //                   .value
                    //                   .text = value.toString();
                    //             }

                    //             print(
                    //                 " repeatTaskController.setRemainderOptionController.value.text ${repeatTaskController.setRemainderOptionController.value.text}");
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
                    // SizedBox(
                    //   height: 20.0,
                    // ),

                    TextFormField(
                      validator: ValidationHelper.nullOrEmptyString,
                      style:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      controller: repeatTaskController.remainderTimeController,
                      keyboardType: TextInputType.datetime,
                      onTap: () async {
                        print("CLOCK PRESSED");

                        repeatTaskController.remainderTimeController.text =
                            await selectedTime(context);
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
                        // border: const OutlineInputBorder(
                        //     borderSide: BorderSide(
                        //       color: Colors.blue,
                        //     ),
                        //     borderRadius:
                        //         BorderRadius.all(Radius.circular(10.0))),
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
