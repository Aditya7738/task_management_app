import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_management_app/constants/fontsizes.dart';
import 'package:task_management_app/constants/strings.dart';
import 'package:task_management_app/controller/create_task_controller.dart';
import 'package:task_management_app/controller/repeat_task_controller.dart';
import 'package:task_management_app/controller/validation_helper.dart';
import 'package:task_management_app/widgets/button_widget.dart';
import 'package:task_management_app/widgets/leading_back_arrow.dart';
import 'package:task_management_app/widgets/repeat_task_form.dart';
import 'package:task_management_app/widgets/select_option.dart';
import 'package:icons_plus/icons_plus.dart';

class CreateTask extends StatefulWidget {
  final bool forAdmin;
//  DocumentSnapshot<Object?>? specificDocumentOfUser;
  CreateTask({super.key, required this.forAdmin
      //, this.specificDocumentOfUser
      });

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  CreateTaskController createTaskController = Get.put(CreateTaskController());

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    createTaskController.showPriorityError.value = false;
    createTaskController.showSelectedEmpError.value = false;
    createTaskController.showStatusError.value = false;

    createTaskController.getUserList();
  }

  // TextEditingController taskNameController = TextEditingController();
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

  Future<String> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2024),
        lastDate: DateTime(2025));

    if (picked != null) {
      print(" DATE ${picked.toLocal().toString()}");
      // return "${picked.day}-${picked.month}-${picked.year}";
      return picked.toLocal().toString().split(" ")[0];
    } else {
      return "00-00-0000";
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RepeatTaskController repeatTaskController = Get.put(RepeatTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingBackArrow(),
        title: Text(
          "Create New Task",
          style: TextStyle(fontSize: 17.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
                top: 5.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    style: TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                    keyboardType: TextInputType.name,
                    validator: ValidationHelper.nullOrEmptyString,
                    controller: createTaskController.taskNameController,
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      labelText: "Enter task name",
                      // hintText: "Enter task name",
                      // hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),

                      errorStyle: TextStyle(fontSize: 15.0, color: Colors.red),
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Status"),
                      SizedBox(
                        width: 10.0,
                      ),
                      Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: createTaskController.selectedStatus.value,
                            icon: Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: Icon(Icons.arrow_drop_down_rounded)),
                            items: createTaskController.statuses
                                .map<DropdownMenuItem<String>>(
                              (status) {
                                return DropdownMenuItem(
                                    value: status,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(status),
                                    ));
                              },
                            ).toList(),
                            onChanged: (value) {
                              createTaskController.selectedStatus.value =
                                  value.toString();

                              createTaskController.statusUpdated.value = true;

                              if (widget.forAdmin) {
                                switch (value.toString()) {
                                  case "Assigned":
                                    createTaskController.taskLabel.value =
                                        "Assigned to";
                                    break;
                                  case "In progress":
                                    createTaskController.taskLabel.value =
                                        "In progress by";
                                    break;
                                  case "Completed":
                                    createTaskController.taskLabel.value =
                                        "Completed by";
                                    break;
                                  case "Hold":
                                    createTaskController.taskLabel.value =
                                        "Hold by";
                                    break;
                                  default:
                                    createTaskController.taskLabel.value =
                                        "Assigned to";
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (createTaskController.showStatusError.value) {
                      return Text(
                        "You don't have set status of task!",
                        style: TextStyle(fontSize: 14.0, color: Colors.red),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),

                  widget.forAdmin
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.yellow,
                                  ),
                                  child: Image.asset(
                                    "assets/images/icons8_decision_100.png",
                                    color: Colors.white,
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Obx(
                                  () => Text(
                                    createTaskController.taskLabel.value,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                DropdownButtonHideUnderline(
                                  child: Obx(
                                    () => DropdownButton(
                                      value:
                                          createTaskController.assignedTo.value,
                                      icon: Container(
                                          margin: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Icon(
                                              Icons.arrow_drop_down_rounded)),
                                      items: createTaskController
                                          .employeesToAssign
                                          .map<DropdownMenuItem<String>>(
                                        (employee) {
                                          return DropdownMenuItem(
                                              value: employee,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.0),
                                                child: Text(
                                                  employee,
                                                  // style: TextStyle(
                                                  //     fontWeight: FontWeight.normal),
                                                ),
                                              ));
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        createTaskController.assignedTo.value =
                                            value.toString();
                                        createTaskController
                                            .isEmployeeAssigned.value = true;
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),

                            // Text(
                            //   "You don't have set above feild!",
                            //   style:
                            //       TextStyle(fontSize: 15.0, color: Colors.red),
                            // ),
                          ],
                        )
                      : SizedBox(),
                  Obx(() {
                    if (createTaskController.showSelectedEmpError.value) {
                      return Text(
                        "You don't have set above feild!",
                        style: TextStyle(fontSize: 14.0, color: Colors.red),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),

                  // Obx(
                  //   () => SelectOption(
                  //     icon: Container(
                  //       padding: EdgeInsets.all(8.0),
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: Colors.yellow,
                  //       ),
                  //       child: Image.asset(
                  //         "assets/images/icons8_decision_100.png",
                  //         color: Colors.white,
                  //         height: 25.0,
                  //         width: 25.0,
                  //       ),
                  //     ),
                  //     title: "Assigned to",
                  //     items: createTaskController.assignee
                  //         .map<DropdownMenuItem<String>>(
                  //       (assignee) {
                  //         return DropdownMenuItem(
                  //             value: assignee,
                  //             child: Padding(
                  //               padding: EdgeInsets.only(left: 10.0),
                  //               child: Text(assignee),
                  //             ));
                  //       },
                  //     ).toList(),
                  //     onChanged: (value) {
                  //       createTaskController.assignedTo.value = value.toString();
                  //     },
                  //     value: createTaskController.assignedTo.value,
                  //   ),
                  // ),

                  SizedBox(
                    height: 20.0,
                  ),
                  // Container(
                  //   width: 150.0,
                  //   padding: EdgeInsets.all(8.0),
                  //   decoration: BoxDecoration(
                  //       //border: Border.all(style: ),
                  //       color: const Color.fromARGB(255, 234, 234, 234),
                  //       borderRadius: BorderRadius.circular(10.0)),
                  //   child:
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Image.asset(
                  //         "assets/images/icons8_attachment_100.png",
                  //         width: 20.0,
                  //         height: 20.0,
                  //       ),
                  //       SizedBox(
                  //         width: 5.0,
                  //       ),
                  //       Text("Add Attachment")
                  //     ],
                  //   ),
                  // ),

                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  //   Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  //     Icon(
                  //       Icons.calendar_today_outlined,
                  //       size: 20.0,
                  //     ),
                  //     SizedBox(
                  //       width: 10.0,
                  //     ),
                  //     Column(
                  //       // mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "Start date",
                  //           style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  //         )
                  //       ],
                  //     )
                  //   ]),
                  // ]),

                  // Text(
                  //   "Start date",
                  //   style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  // ),
                  // const SizedBox(
                  //   height: 5.0,
                  // ),
                  TextFormField(
                    style: TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                    controller: createTaskController.startDateEditingController,
                    keyboardType: TextInputType.datetime,
                    validator: ValidationHelper.nullOrEmptyString,
                    onTap: () async {
                      print("CALENDAR PRESSED");

                      // createTaskController.startDateEditingController.text =
                      //     await _selectedDate(context);

                      createTaskController.startDate.value =
                          await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2025));

                      if (createTaskController.startDate.value != null) {
                        print(
                            " DATE ${createTaskController.startDate.value.toLocal().toString()}");
                        // return "${ createTaskController.startDate.value.day}-${ createTaskController.startDate.value.month}-${ createTaskController.startDate.value.year}";
                        createTaskController.startDateEditingController.text =
                            createTaskController.startDate.value
                                .toLocal()
                                .toString()
                                .split(" ")[0];
                      } else {
                        createTaskController.startDateEditingController.text =
                            "00-00-0000";
                      }

                      createTaskController.isStartDateSelected.value = true;
                    },
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      labelText: "Enter start date",
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                    maxLines: 1,
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  // Text(
                  //   "Due date",
                  //   style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  // ),
                  // const SizedBox(
                  //   height: 5.0,
                  // ),
                  TextFormField(
                    style: TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                    controller: createTaskController.dueDateEditingController,
                    keyboardType: TextInputType.datetime,
                    validator: ValidationHelper.nullOrEmptyString,
                    onTap: () async {
                      print("CALENDAR PRESSED");

                      // createTaskController.dueDateEditingController.text =
                      //     await _selectedDate(context);

                      createTaskController.dueDate.value = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2025));

                      if (createTaskController.dueDate.value != null) {
                        print(
                            " DATE ${createTaskController.dueDate.value.toLocal().toString()}");
                        // return "${ createTaskController.dueDate.value.day}-${ createTaskController.dueDate.value.month}-${ createTaskController.dueDate.value.year}";
                        createTaskController.dueDateEditingController.text =
                            createTaskController.dueDate.value
                                .toLocal()
                                .toString()
                                .split(" ")[0];
                      } else {
                        createTaskController.dueDateEditingController.text =
                            "00-00-0000";
                      }
                    },
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      labelText: "Enter due date",
                      // errorStyle:
                      //     TextStyle(fontSize: 15.sp, color: Colors.red),
                      suffixIcon: const Icon(
                        Icons.calendar_month_outlined,
                        size: 20.0,
                      ),
                      // border: const OutlineInputBorder(
                      //     borderSide: BorderSide(
                      //       color: Colors.blue,
                      //     ),
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(10.0))),
                    ),
                    maxLines: 1,
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  // Text(
                  //   "Remainder",
                  //   style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  // ),
                  // const SizedBox(
                  //   height: 5.0,
                  // ),
                  Container(
                    height: 75.0,
                    child: TextFormField(
                      validator: ValidationHelper.nullOrEmptyString,
                      style:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      controller:
                          createTaskController.setRemainderOptionController,
                      //keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        labelText: "Set remainder",
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
                          onChanged: (value) async {
                            if (value.toString() == "Custom") {
                              // createTaskController.setRemainderOptionController
                              //     .text =
                              //     if (await _selectedDate(context) >) {

                              //     }
                              //     await _selectedDate(context);

                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2024),
                                  lastDate: DateTime(2025));

                              print("picked != null ${picked != null}");

                              if (picked != null) {
                                // if (picked.compareTo(createTaskController.dueDate)  &&
                                //     picked! > createTaskController.startDate) {}

                                print(
                                    "picked.compareTo(createTaskController.dueDate.value) !=  ${picked.compareTo(createTaskController.dueDate.value) != 1}");

                                if (picked.compareTo(
                                        createTaskController.dueDate.value) !=
                                    1) {
                                  Get.snackbar("Error",
                                      "Remainder date should be grater than start date",
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      duration: Duration(seconds: 5),
                                      borderRadius: 20.0,
                                      snackPosition: SnackPosition.TOP);
                                } else if (picked.compareTo(
                                        createTaskController.startDate.value) !=
                                    -1) {
                                  Get.snackbar("Error",
                                      "Remainder date should be less than due date",
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      duration: Duration(seconds: 5),
                                      borderRadius: 20.0,
                                      snackPosition: SnackPosition.TOP);
                                } else {
                                  createTaskController
                                          .setRemainderOptionController.text =
                                      picked.toLocal().toString().split(" ")[0];
                                }
                              }

                              // if (picked != null) {
                              //   print(" DATE ${picked.toLocal().toString()}");
                              //   // return "${picked.day}-${picked.month}-${picked.year}";
                              //   return picked
                              //       .toLocal()
                              //       .toString()
                              //       .split(" ")[0];
                              // } else {
                              //   return "00-00-0000";
                              // }
                            } else {
                              createTaskController.setRemainderOptionController
                                  .text = value.toString();
                            }
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
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  TextFormField(
                    validator: ValidationHelper.nullOrEmptyString,
                    style: TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                    controller: createTaskController.remainderTimeController,
                    keyboardType: TextInputType.datetime,
                    onTap: () async {
                      print("CLOCK PRESSED");

                      createTaskController.remainderTimeController.text =
                          await selectedTime(context);
                    },
                    decoration: InputDecoration(
                      // errorStyle:
                      //     TextStyle(fontSize: 15.sp, color: Colors.red),
                      suffixIcon: const Icon(
                        Iconsax.clock_outline,
                        size: 20.0,
                      ),
                      labelStyle:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
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

                  SizedBox(
                    height: 30.0,
                  ),

                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        constraints: BoxConstraints.expand(
                            width: Get.width, height: Get.height - 80),
                        //  isDismissible: false,
                        context: context,
                        //showDragHandle: true,
                        isScrollControlled: true,
                        builder: (context) {
                          return RepeatTaskForm();
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/refresh.png",
                          width: 15.0,
                          height: 15.0,
                          color: Get.theme.primaryColor,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Repeat Task",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Get.theme.primaryColor,
                            color: Get.theme.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),

                  Obx(() {
                    if (repeatTaskController.dataSetForRepeatTask.value) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.0,
                          ),
                          Obx(() {
                            String text = "You want to repeat this task ";

                            if (repeatTaskController.selectedTab.value !=
                                "weekly") {
                              if (repeatTaskController
                                  .selectedDays.isNotEmpty) {
                                repeatTaskController.selectedDays.forEach(
                                  (element) {
                                    text += "$element, ";
                                  },
                                );
                              }

                              if (repeatTaskController
                                  .selectedMonths.isNotEmpty) {
                                repeatTaskController.selectedMonths.forEach(
                                  (element) {
                                    text += "$element, ";
                                  },
                                );
                              }

                              if (repeatTaskController.listOfYears.isNotEmpty) {
                                repeatTaskController.listOfYears.forEach(
                                  (element) {
                                    text += "$element, ";
                                  },
                                );
                              }

                              text +=
                                  " on ${repeatTaskController.selectedTab.value} basis";
                            } else {
                              text +=
                                  "every ${repeatTaskController.selectNoOfWeek.value} week(s) on ";

                              if (repeatTaskController
                                  .listOfWeekDays.isNotEmpty) {
                                repeatTaskController.listOfWeekDays.forEach(
                                  (element) {
                                    text += "$element, ";
                                  },
                                );
                              }
                            }

                            return Text(text);
                          }),
                          SizedBox(
                            height: 5.0,
                          ),
                          GetBuilder<RepeatTaskController>(
                            builder: (controller) {
                              if (controller.selectedOption ==
                                  CommonStrings.selectedOption) {
                                return Text(
                                    "You choose to not stop repeating task");
                              } else {
                                return Text(
                                    "This repeating task will stop on ${controller.repeatTaskDateEditingController.value.text}");
                              }
                            },
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Obx(() => Text(
                              "Remainder is set on ${repeatTaskController.setRemainderOptionController.value.text} due date")),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  }),

                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image.asset("assets/images/prioritize.png"),
                      Image.asset(
                        "assets/images/prioritize.png",
                        width: 25.0,
                        height: 25.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Select priority",
                        // style: TextStyle(color: Colors.grey, fontSize: 13.0),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      DropdownButtonHideUnderline(
                        child: Obx(
                          () => DropdownButton(
                            value: createTaskController.selectedPriority.value,
                            icon: Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: Icon(Icons.arrow_drop_down_rounded)),
                            items: createTaskController.priorities
                                .map<DropdownMenuItem<String>>(
                              (priority) {
                                return DropdownMenuItem(
                                    value: priority,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(priority),
                                    ));
                              },
                            ).toList(),
                            onChanged: (value) {
                              createTaskController.selectedPriority.value =
                                  value.toString();
                              createTaskController.isPioritySelected.value =
                                  true;
                            },
                          ),
                        ),
                      )
                    ],
                  ),

                  Obx(() {
                    if (createTaskController.showPriorityError.value) {
                      return Text(
                        "You don't have set priority of task!",
                        style: TextStyle(fontSize: 14.0, color: Colors.red),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image.asset("assets/images/prioritize.png"),
                      Image.asset(
                        "assets/images/tag.png",
                        width: 17.0,
                        height: 17.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Select Tags",
                        // style: TextStyle(color: Colors.grey, fontSize: 13.0),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      DropdownButtonHideUnderline(
                        child: Obx(
                          () => DropdownButton(
                            value: createTaskController.selectedTag.value,
                            icon: Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: Icon(Icons.arrow_drop_down_rounded)),
                            items: createTaskController.tags
                                .map<DropdownMenuItem<String>>(
                              (tag) {
                                return DropdownMenuItem(
                                    value: tag,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(tag),
                                    ));
                              },
                            ).toList(),
                            onChanged: (value) {
                              createTaskController.selectedTag.value =
                                  value.toString();
                            },
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 25.0,
                  ),
                  // Text(
                  //   "Remarks",
                  //   style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  // ),
                  // SizedBox(
                  //   height: 5.0,
                  // ),
                  TextFormField(
                    maxLines: 4,
                    style: TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                    controller: createTaskController.remarkController,
                    keyboardType: TextInputType.multiline,
                    // validator: ValidationHelper.isFullAddress,
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      labelText: "Remarks",
                      // errorStyle: TextStyle(
                      //     fontSize: Fontsizes.errorTextSize, color: Colors.red),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),

                  // SizedBox(
                  //   height: 15.0,
                  // ),

                  // TextFormField(
                  //   style: TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                  //   validator: ValidationHelper.nullOrEmptyString,
                  //   controller: createTaskController.assignedByController,
                  //   keyboardType: TextInputType.name,
                  //   // onTap: () async {
                  //   //   print("CLOCK PRESSED");

                  //   //   remainderTimeController.text = await selectedTime(context);
                  //   // },
                  //   decoration: InputDecoration(
                  //     labelStyle:
                  //         TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                  //     labelText: "Assigned by",
                  //     // errorStyle:
                  //     //     TextStyle(fontSize: 15.sp, color: Colors.red),
                  //     suffixIcon: const Icon(
                  //       Iconsax.profile_circle_bold,
                  //       size: 20.0,
                  //     ),
                  //     border: const OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: Colors.blue,
                  //         ),
                  //         borderRadius:
                  //             BorderRadius.all(Radius.circular(10.0))),
                  //   ),
                  //   maxLines: 1,
                  // ),

                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        //  width: 170.0,
                        decoration: BoxDecoration(
                            // border: border,
                            color: const Color.fromARGB(255, 234, 234, 234),
                            borderRadius: BorderRadius.circular(15.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/icons8_attachment_100.png",
                              width: 21.0,
                              height: 21.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "Add Attachment",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: ButtonWidget(
                                  isLoading: false,
                                  width: 81.0,
                                  color: Colors.white,
                                  textColor: Get.theme.primaryColor,
                                  // borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Get.theme.primaryColor,
                                  ),
                                  text: "Cancel")
                              //  Container(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: 15.0, vertical: 8.0),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(5.0),
                              //     border: Border.all(color: Colors.blue),
                              //   ),
                              //   child: Text(
                              //     "Cancel",
                              //     style: TextStyle(color: Colors.blue),
                              //   ),
                              // ),
                              ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Obx(
                            () => GestureDetector(
                                onTap: () {
                                  if (createTaskController
                                          .isPioritySelected.value ==
                                      false) {
                                    createTaskController
                                        .showPriorityError.value = true;
                                  }

                                  if (createTaskController
                                          .statusUpdated.value ==
                                      false) {
                                    createTaskController.showStatusError.value =
                                        true;
                                  }

                                  if (createTaskController
                                          .isEmployeeAssigned.value ==
                                      false) {
                                    createTaskController
                                        .showSelectedEmpError.value = true;
                                  }

                                  if (_formKey.currentState!.validate()) {
                                    // createTaskController.appointments.add(
                                    //     Appointment(
                                    //         isAllDay: false,
                                    //         startTime: DateTime.parse(
                                    //             createTaskController
                                    //                 .startDateEditingController
                                    //                 .text),
                                    //         endTime: DateTime.parse(
                                    //             createTaskController
                                    //                 .dueDateEditingController
                                    //                 .text),
                                    //         color: getColor(),
                                    //         subject: createTaskController
                                    //             .taskNameController.text));

                                    //  Get.back();

                                    /////////////////////////////////////

                                    // if (forAdmin) {
                                    //   switch (createTaskController
                                    //       .selectedStatus.value) {
                                    //     case "Assigned":
                                    //       createTaskController.taskLabel.value =
                                    //           "Assigned to";
                                    //       break;
                                    //     case "In progress":
                                    //       createTaskController.taskLabel.value =
                                    //           "In progress by";
                                    //       break;
                                    //     case "Completed":
                                    //       createTaskController.taskLabel.value =
                                    //           "Completed by";
                                    //       break;
                                    //     case "Hold":
                                    //       createTaskController.taskLabel.value =
                                    //           "Hold by";
                                    //       break;
                                    //     default:
                                    //       createTaskController.taskLabel.value =
                                    //           "Assigned to";
                                    //   }
                                    // }

                                    ////////////////////////////////////////////////

                                    //   createTaskController.createTaskOfManager();
                                  }
                                },
                                child: ButtonWidget(
                                    isLoading:
                                        createTaskController.creatingTask.value,
                                    width: 77.0,
                                    text: "Create",
                                    textColor: Colors.white,
                                    color: Get.theme.primaryColor)),
                          )
                        ],
                      ),
                    ],
                  )

                  //   ],
                  // )
                ],
              ),
            )),
      ),
    );
  }

  Color getColor() {
    switch (createTaskController.selectedPriority.value) {
      case "High":
        return Colors.red;
      case "Medium":
        return Colors.yellow;
      case "Low":
        return Colors.green;
      default:
        return Colors.red;
    }
  }
}

class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Appointment> source) {
    appointments = source;
  }
}
