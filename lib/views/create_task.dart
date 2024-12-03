import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_management_app/constants/fontsizes.dart';
import 'package:task_management_app/controller/create_task_controller.dart';
import 'package:task_management_app/controller/validation_helper.dart';
import 'package:task_management_app/widgets/repeat_task_form.dart';
import 'package:task_management_app/widgets/select_option.dart';
import 'package:icons_plus/icons_plus.dart';

class CreateTask extends StatelessWidget {
  CreateTask({super.key});

  CreateTaskController createTaskController = Get.put(CreateTaskController());

  DateTime selectedDate = DateTime.now();

  var taskNameController = TextEditingController();
  var remainderController = TextEditingController();
  var startDateEditingController = TextEditingController();
  var dueDateEditingController = TextEditingController();

  Future<void> showRepeatedTaskDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return SizedBox();
      },
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create New Task",
          style: TextStyle(fontSize: 18.0),
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
                    controller: taskNameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      // focusedBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10.0),
                      //     borderSide:
                      //         BorderSide(color: Colors.blue, width: 2.0))
                      errorStyle: TextStyle(fontSize: 15.0, color: Colors.red),
                    ),
                  ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // Text(
                  //   "Add Task notes",
                  //   style: TextStyle(color: Colors.grey, fontSize: 16.0),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Image.asset(
                  //       "assets/images/add_round_icon.png",
                  //       width: 18.0,
                  //       height: 18.0,
                  //       color: Colors.blue,
                  //     ),
                  //     SizedBox(
                  //       width: 10.0,
                  //     ),
                  //     Text(
                  //       "Add Checklist",
                  //       style: TextStyle(color: Colors.blue, fontSize: 16.0),
                  //     ),
                  //   ],
                  // ),

                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Board & Section",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Sample Board",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Image.asset(
                        "assets/images/filled_thin_chevron_round_right_icon.png",
                        width: 20.0,
                        height: 20.0,
                        color: const Color.fromARGB(255, 222, 222, 222),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      // Text(
                      //   "Choose Section",
                      //   style:
                      //       TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(
                      //   width: 5.0,
                      // ),
                      // Icon(Icons.arrow_drop_down_rounded)
                      Obx(() =>
                          // SelectOption(
                          //   title: "Choose Section",
                          //   items: createTaskController.assignee
                          //       .map<DropdownMenuItem<String>>(
                          //     (assignee) {
                          //       return DropdownMenuItem(
                          //           value: assignee,
                          //           child: Padding(
                          //             padding: EdgeInsets.only(left: 10.0),
                          //             child: Text(assignee),
                          //           ));
                          //     },
                          //   ).toList(),
                          //   onChanged: (value) {
                          //     createTaskController.assignedTo.value =
                          //         value.toString();
                          //   },
                          //   value: createTaskController.assignedTo.value,
                          // ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: createTaskController.selectedSection.value,
                              icon: Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.arrow_drop_down_rounded)),
                              items: createTaskController.sections
                                  .map<DropdownMenuItem<String>>(
                                (section) {
                                  return DropdownMenuItem(
                                      value: section,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(section),
                                      ));
                                },
                              ).toList(),
                              onChanged: (value) {
                                createTaskController.selectedSection.value =
                                    value.toString();
                              },
                            ),
                          )),
                    ],
                  ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),

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
                            },
                          ),
                        ),
                      ),
                    ],
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
                            value: createTaskController.assignedTo.value,
                            icon: Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: Icon(Icons.arrow_drop_down_rounded)),
                            items: createTaskController.assignee
                                .map<DropdownMenuItem<String>>(
                              (assignee) {
                                return DropdownMenuItem(
                                    value: assignee,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        assignee,
                                        // style: TextStyle(
                                        //     fontWeight: FontWeight.normal),
                                      ),
                                    ));
                              },
                            ).toList(),
                            onChanged: (value) {
                              createTaskController.assignedTo.value =
                                  value.toString();
                            },
                          ),
                        ),
                      )
                    ],
                  ),

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
                  Container(
                    width: 150.0,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        //border: Border.all(style: ),
                        color: const Color.fromARGB(255, 234, 234, 234),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/icons8_attachment_100.png",
                          width: 20.0,
                          height: 20.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text("Add Attachment")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  //   Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  //     Icon(
                  //       Icons.calendar_today_outlined,
                  //       size: 15.0,
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

                  Text(
                    "Start date",
                    style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                      height: 50.0,
                      // alignment: Alignment.centerLeft,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        controller: startDateEditingController,
                        keyboardType: TextInputType.datetime,
                        onTap: () async {
                          print("CALENDAR PRESSED");

                          startDateEditingController.text =
                              await _selectedDate(context);
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                        maxLines: 1,
                      )),

                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Due date",
                    style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                      height: 50.0,
                      // alignment: Alignment.centerLeft,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        controller: dueDateEditingController,
                        keyboardType: TextInputType.datetime,
                        onTap: () async {
                          print("CALENDAR PRESSED");

                          dueDateEditingController.text =
                              await _selectedDate(context);
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                        maxLines: 1,
                      )),

                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Remainder",
                    style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                      height: 50.0,
                      // alignment: Alignment.centerLeft,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        controller: remainderController,
                        keyboardType: TextInputType.datetime,
                        onTap: () async {
                          print("CLOCK PRESSED");

                          remainderController.text =
                              await selectedTime(context);
                        },
                        decoration: InputDecoration(
                          // errorStyle:
                          //     TextStyle(fontSize: 15.sp, color: Colors.red),
                          suffixIcon: const Icon(
                            Iconsax.clock_outline,
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
                      )),

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
                            },
                          ),
                        ),
                      )
                    ],
                  ),

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
                    height: 15.0,
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
                        Image.asset("assets/images/refresh.png",
                            width: 15.0, height: 15.0),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("Repeat Task")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "Remarks",
                    style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    maxLines: 4,
                    style: TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                    // controller:
                    //     captureFormController.addressTextEditController.value,
                    keyboardType: TextInputType.multiline,
                    // validator: ValidationHelper.isFullAddress,
                    decoration: InputDecoration(
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
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Assigned by",
                    style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                      height: 50.0,
                      // alignment: Alignment.centerLeft,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        //controller: remainderController,
                        keyboardType: TextInputType.name,
                        // onTap: () async {
                        //   print("CLOCK PRESSED");

                        //   remainderController.text = await selectedTime(context);
                        // },
                        decoration: InputDecoration(
                          // errorStyle:
                          //     TextStyle(fontSize: 15.sp, color: Colors.red),
                          suffixIcon: const Icon(
                            Iconsax.profile_circle_bold,
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
                      )),

                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Clear",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              createTaskController.appointments.add(Appointment(
                                  isAllDay: false,
                                  startTime: DateTime.parse(
                                      startDateEditingController.text),
                                  endTime: DateTime.parse(
                                      dueDateEditingController.text),
                                  color: getColor(),
                                  subject: taskNameController.text));

                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.blue,
                              ),
                              child: Text(
                                "Create",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
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
