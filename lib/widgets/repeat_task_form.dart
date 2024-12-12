import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/constants/fontsizes.dart';
import 'package:task_management_app/controller/repeat_task_controller.dart';

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
                      itemCount: repeatTaskController.listOfDays.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => CheckboxMenuButton(
                            value: repeatTaskController.selectedDays.contains(
                                repeatTaskController.listOfDays[
                                    index]), //repeatTaskController.productsMap[index],

                            onChanged: (value) {
                              repeatTaskController.toggle(repeatTaskController
                                      .listOfDays[
                                  index]); //repeatTaskController.toggle(repeatTaskController.listOfDays[index]);
                            },
                            child: Text(repeatTaskController.listOfDays[index]),
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
        Obx(
          () => YearPicker(
            initialDate: DateTime(2024),
            firstDate: DateTime(2024),
            lastDate: DateTime(2028),
            selectedDate: DateTime(repeatTaskController.selectedYear.value),
            onChanged: (newDate) {
              // Handle date change
              repeatTaskController.selectedYear.value = newDate.year;
            },
          ),
        )
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
            onTap: () {},
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create new copies",
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
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
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  GetBuilder<RepeatTaskController>(
                    builder: (controller) => RadioMenuButton(
                      value: "Do not stop repeating this task",
                      groupValue: controller.selectedOption,
                      onChanged: (value) {
                        controller.updateSelectedOption(value.toString());
                      },
                      child: Text("Do not stop repeating this task"),
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
                                    fontSize: FontSizes.textFormFieldFontSize),
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
                    "Set remainder",
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(

                      // color: Colors.red,
                      height: 45.0,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        controller: repeatTaskController
                            .setRemainderOptionController.value,
                        //keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Select Option",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                            color: const Color(0x7F555770),
                          ),
                          suffix: DropdownButton(
                            borderRadius: BorderRadius.circular(10.0),
                            iconSize: 25.0,
                            icon: Container(
                              margin: const EdgeInsets.only(right: 10.0),
                              child:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                            ),
                            items: repeatTaskController.setRemainderOptions
                                .map<DropdownMenuItem<String>>(
                                    (setRemainderOption) {
                              return DropdownMenuItem<String>(
                                value: setRemainderOption,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  child: Text(setRemainderOption),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              print("RELIGION ${value.toString()}");

                              repeatTaskController.setRemainderOptionController
                                  .value.text = value.toString();

                              print(
                                  " repeatTaskController.setRemainderOptionController.value.text ${repeatTaskController.setRemainderOptionController.value.text}");
                            },
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 221, 221, 221),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                        maxLines: 1,
                      )),
                ]),
          ),
        ),
      ),
    );
  }
}
