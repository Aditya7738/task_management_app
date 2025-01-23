import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_management_app/constants/database_references.dart';
import 'package:task_management_app/constants/fontsizes.dart';
import 'package:task_management_app/constants/strings.dart';
import 'package:task_management_app/controller/create_task_controller.dart';
import 'package:task_management_app/controller/repeat_task_controller.dart';
import 'package:task_management_app/controller/update_repeat_task_controller.dart';
import 'package:task_management_app/controller/update_task_controller.dart';
import 'package:task_management_app/controller/user_activities_controller.dart';
import 'package:task_management_app/controller/validation_helper.dart';
import 'package:task_management_app/widgets/button_widget.dart';
import 'package:task_management_app/widgets/leading_back_arrow.dart';
import 'package:task_management_app/widgets/repeat_task_form.dart';
import 'package:task_management_app/widgets/select_option.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:task_management_app/widgets/update_repeat_task_form.dart';

class UpdateTask extends StatefulWidget {
  final bool forAdmin;
  final bool forEmp;
  final String username;
  final DocumentSnapshot document;
  final String? appTitle;
  final bool forTaskOverview;
  final bool forUsersProfile;

  UpdateTask(
      {super.key,
      required this.forAdmin,
      required this.forEmp,
      //required this.data,
      required this.document,
      required this.username,
      required this.forTaskOverview,
      this.appTitle,
      required this.forUsersProfile});

  @override
  State<UpdateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<UpdateTask> {
  // _updateTaskController _updateTaskController = Get.put(_updateTaskController());

  UpdateTaskController _updateTaskController = Get.put(UpdateTaskController());

  DateTime selectedDate = DateTime.now();

  UpdateRepeatTaskController _updateRepeatTaskController =
      Get.put(UpdateRepeatTaskController());

  Map<String, dynamic> data = <String, dynamic>{};
  // widget. document.data()! as Map<String, dynamic>;

  UserActivitiesController _userActivitiesController =
      Get.put(UserActivitiesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data = widget.document.data()! as Map<String, dynamic>;

    //_updateTaskController.employeesToAssign.clear();
    _updateTaskController.showPriorityError.value = false;
    _updateTaskController.showSelectedEmpError.value = false;
    _updateTaskController.showStatusError.value = false;

    _updateTaskController.taskNameController.text = data["taskName"].toString();

    _updateTaskController.descriptionController.text =
        data["description"].toString();

    _updateTaskController.selectedStatus.value = data["status"].toString();

    _updateTaskController.startDateEditingController.text =
        data["startDate"].toString();

    _updateTaskController.dueDateEditingController.text =
        data["dueDate"].toString();

    _updateTaskController.setRemainderOptionController.text =
        data["remainderDay"].toString();

    _updateTaskController.remainderTimeController.text =
        data["remainderTime"].toString();

    _updateTaskController.selectedPriority.value = data["priority"].toString();

    _updateTaskController.selectedTag.value = data["tag"].toString();

    _updateTaskController.remarkController.text = data["remarks"].toString();

    if (widget.forAdmin) {
    } else {
      _updateTaskController.employeesToAssign.clear();
      _updateTaskController.getUserList(widget.forEmp, widget.forUsersProfile);
      _updateTaskController.assignedTo.value =
          _updateTaskController.employeesToAssign.isNotEmpty
              ? _updateTaskController.employeesToAssign[0]
              : "Choose employee";
    }
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
        initialDate: DateTime.now(),
        firstDate: DateTime(2025),
        lastDate: DateTime(2026));

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
    return WillPopScope(
      onWillPop: () async {
        Get.back();

        print("onWillPop CALLED");

        if (widget.forAdmin) {
        } else {
          _updateTaskController.employeesToAssign.clear();
          // _updateTaskController.getUserList(widget.forEmp);
          _updateTaskController.assignedTo.value =
              _updateTaskController.employeesToAssign.isNotEmpty
                  ? _updateTaskController.employeesToAssign[0]
                  : "Choose employee";
        }

        // print(
        //     "_updateTaskController.assignedTo.value ${_updateTaskController.assignedTo.value}");

        _updateTaskController.taskNameController.clear();

        _updateTaskController.startDateEditingController.clear();

        _updateTaskController.dueDateEditingController.clear();

        _updateTaskController.remainderTimeController.clear();

        _updateTaskController.setRemainderOptionController.clear();

        _updateTaskController.selectedStatus.value = "Assigned";

        _updateTaskController.selectedPriority.value = "High";
        _updateTaskController.selectedTag.value = "No tags added";

        _updateTaskController.remarkController.clear();

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: LeadingBackArrow(),
          title: Text(
            "Update Task",
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
                  top: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      style:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      keyboardType: TextInputType.name,
                      validator: ValidationHelper.nullOrEmptyString,
                      controller: _updateTaskController.taskNameController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        labelText: "Update task name",
                        // hintText: widget.data["taskName"].toString(),
                        // hintStyle: TextStyle(
                        //   fontSize: FontSizes.textFormFieldFontSize,
                        // ),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        errorStyle:
                            TextStyle(fontSize: 15.0, color: Colors.red),
                      ),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      minLines: 2,
                      maxLines: 4,
                      style:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      keyboardType: TextInputType.multiline,
                      validator: ValidationHelper.nullOrEmptyString,
                      controller: _updateTaskController.descriptionController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        labelText: "Update task description",
                        // hintText: "Update task name",
                        // hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),

                        errorStyle:
                            TextStyle(fontSize: 15.0, color: Colors.red),
                      ),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Update status"),
                        SizedBox(
                          width: 10.0,
                        ),
                        Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _updateTaskController.selectedStatus.value,
                              icon: Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.arrow_drop_down_rounded)),
                              items: _updateTaskController.statuses
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
                                _updateTaskController.selectedStatus.value =
                                    value.toString();

                                _updateTaskController.statusUpdated.value =
                                    true;

                                if (widget.forAdmin) {
                                  switch (value.toString()) {
                                    case "Assigned":
                                      _updateTaskController.taskLabel.value =
                                          "Assigned to";
                                      break;
                                    case "In progress":
                                      _updateTaskController.taskLabel.value =
                                          "In progress by";
                                      break;
                                    case "Completed":
                                      _updateTaskController.taskLabel.value =
                                          "Completed by";
                                      break;
                                    case "Hold":
                                      _updateTaskController.taskLabel.value =
                                          "Hold by";
                                      break;
                                    default:
                                      _updateTaskController.taskLabel.value =
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
                      if (_updateTaskController.showStatusError.value) {
                        return Text(
                          "You don't have set status of task!",
                          style: TextStyle(fontSize: 14.0, color: Colors.red),
                        );
                      } else {
                        return SizedBox();
                      }
                    }),

                    widget.forAdmin == false
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
                                      _updateTaskController.taskLabel.value,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: GetBuilder<UpdateTaskController>(
                                        builder: (controller) {
                                      print(
                                          "DDL controller.assignedTo.value ${controller.assignedTo.value}");
                                      return DropdownButton(
                                        value: controller.assignedTo.value,
                                        icon: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Icon(
                                                Icons.arrow_drop_down_rounded)),
                                        items: controller.employeesToAssign
                                            .map<DropdownMenuItem<String>>(
                                          (employee) {
                                            print("employee DDL $employee");
                                            return DropdownMenuItem(
                                                value: employee,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                  child: Text(
                                                    employee,
                                                    // style: TextStyle(
                                                    //     fontWeight: FontWeight.normal),
                                                  ),
                                                ));
                                          },
                                        ).toList(),
                                        onChanged: (value) {
                                          // controller.assignedTo.value =
                                          //     value.toString();
                                          // controller.isEmployeeAssigned.value =
                                          //     true;
                                          controller
                                              .setAssignedTo(value.toString());

                                          controller.isEmployeeAssigned.value =
                                              true;

                                          print(
                                              "controller.assignedTo.value ${controller.assignedTo.value}");
                                        },
                                      );
                                    }),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Obx(() {
                                    if (_updateTaskController
                                        .gettingUsers.value) {
                                      return SizedBox(
                                        width: 15.0,
                                        height: 15.0,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          color: Get.theme.primaryColor,
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  })
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
                      if (_updateTaskController.showSelectedEmpError.value) {
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
                    //     items: _updateTaskController.assignee
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
                    //       _updateTaskController.assignedTo.value = value.toString();
                    //     },
                    //     value: _updateTaskController.assignedTo.value,
                    //   ),
                    // ),

                    SizedBox(
                      height: 30.0,
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
                      style:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      controller:
                          _updateTaskController.startDateEditingController,
                      keyboardType: TextInputType.datetime,
                      validator: ValidationHelper.nullOrEmptyString,
                      onTap: () async {
                        print("CALENDAR PRESSED");

                        // _updateTaskController.startDateEditingController.text =
                        //     await _selectedDate(context);

                        _updateTaskController.startDate.value =
                            await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2025),
                                lastDate: DateTime(2026));

                        if (_updateTaskController.startDate.value != null) {
                          print(
                              " DATE ${_updateTaskController.startDate.value.toLocal().toString()}");
                          // return "${ _updateTaskController.startDate.value.day}-${ _updateTaskController.startDate.value.month}-${ _updateTaskController.startDate.value.year}";
                          _updateTaskController
                                  .startDateEditingController.text =
                              _updateTaskController.startDate.value
                                  .toLocal()
                                  .toString()
                                  .split(" ")[0];
                        } else {
                          _updateTaskController
                              .startDateEditingController.text = "00-00-0000";
                        }

                        _updateTaskController.isStartDateSelected.value = true;
                      },
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        labelText: "Update start date",
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
                      style:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      controller:
                          _updateTaskController.dueDateEditingController,
                      keyboardType: TextInputType.datetime,
                      validator: ValidationHelper.nullOrEmptyString,
                      onTap: () async {
                        print("CALENDAR PRESSED");

                        // _updateTaskController.dueDateEditingController.text =
                        //     await _selectedDate(context);

                        _updateTaskController.dueDate.value =
                            await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2025),
                                lastDate: DateTime(2026));

                        if (_updateTaskController.dueDate.value != null) {
                          print(
                              " DATE ${_updateTaskController.dueDate.value.toLocal().toString()}");
                          // return "${ _updateTaskController.dueDate.value.day}-${ _updateTaskController.dueDate.value.month}-${ _updateTaskController.dueDate.value.year}";
                          _updateTaskController.dueDateEditingController.text =
                              _updateTaskController.dueDate.value
                                  .toLocal()
                                  .toString()
                                  .split(" ")[0];
                        } else {
                          _updateTaskController.dueDateEditingController.text =
                              "00-00-0000";
                        }
                      },
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        labelText: "Update due date",
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
                        style: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        controller:
                            _updateTaskController.setRemainderOptionController,
                        //keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: FontSizes.textFormFieldFontSize),
                          labelText: "Update remainder date",
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
                                // _updateTaskController.setRemainderOptionController
                                //     .text =
                                //     if (await _selectedDate(context) >) {

                                //     }
                                //     await _selectedDate(context);

                                final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2025),
                                    lastDate: DateTime(2026));

                                print("picked != null ${picked != null}");

                                if (picked != null) {
                                  // if (picked.compareTo(_updateTaskController.dueDate)  &&
                                  //     picked! > _updateTaskController.startDate) {}

                                  print(
                                      "picked.compareTo(_updateTaskController.dueDate.value) !=  ${picked.compareTo(_updateTaskController.dueDate.value) != 1}");

                                  if (picked.compareTo(_updateTaskController
                                          .dueDate.value) !=
                                      1) {
                                    // Get.snackbar("Error",
                                    //     "Remainder date should be grater than start date",
                                    //     backgroundColor: Colors.red,
                                    //     colorText: Colors.white,
                                    //     duration: Duration(seconds: 5),
                                    //     borderRadius: 20.0,
                                    //     snackPosition: SnackPosition.TOP);
                                    print(
                                        "setRemainderOptionController DATE ${picked.toLocal().toString()}");
                                    _updateTaskController
                                            .setRemainderOptionController.text =
                                        picked
                                            .toLocal()
                                            .toString()
                                            .split(" ")[0];
                                  } else if (picked.compareTo(
                                          _updateTaskController
                                              .startDate.value) !=
                                      -1) {
                                    //  _updateTaskController.startDateEditingController.text =
                                    //                           _updateTaskController.startDate.value
                                    //                               .toLocal()
                                    //                               .toString()
                                    //                               .split(" ")[0];

                                    // _updateTaskController
                                    //         .setRemainderOptionController.text =
                                    //     picked.toLocal().toString().split(" ")[0];

                                    //  _updateTaskController.startDate.value =
                                    //                         await showDatePicker(
                                    //                             context: context,
                                    //                             initialDate: DateTime.now(),
                                    //                             firstDate: DateTime(2025),
                                    //                             lastDate: DateTime(2026));

                                    Get.snackbar("Error",
                                        "Remainder date should be less than due date",
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                        duration: Duration(seconds: 5),
                                        borderRadius: 20.0,
                                        snackPosition: SnackPosition.TOP);
                                  } else {
                                    print(
                                        "setRemainderOptionController DATE ${picked.toLocal().toString()}");
                                    _updateTaskController
                                            .setRemainderOptionController.text =
                                        picked
                                            .toLocal()
                                            .toString()
                                            .split(" ")[0];
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
                                _updateTaskController
                                    .setRemainderOptionController
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
                      style:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      controller: _updateTaskController.remainderTimeController,
                      keyboardType: TextInputType.datetime,
                      onTap: () async {
                        print("CLOCK PRESSED");

                        _updateTaskController.remainderTimeController.text =
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
                        labelText: "Update remainder time",
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

                    // Obx(() {
                    //   if (repeatTaskController.dataSetForRepeatTask.value) {
                    //     return
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.0,
                        ),

                        // Obx(() {
                        //   String text = "You want to repeat this task ";

                        //   print(
                        //       "repeatTaskController.selectedTab.value != weekly ${repeatTaskController.selectedTab.value != "Weekly"}");
                        //   if (repeatTaskController.selectedTab.value !=
                        //       "Weekly") {
                        //     if (repeatTaskController.selectedDays.isNotEmpty) {
                        //       repeatTaskController.selectedDays.forEach(
                        //         (element) {
                        //           text += "$element, ";
                        //         },
                        //       );
                        //     }

                        //     if (repeatTaskController
                        //         .selectedMonths.isNotEmpty) {
                        //       repeatTaskController.selectedMonths.forEach(
                        //         (element) {
                        //           text += "$element, ";
                        //         },
                        //       );
                        //     }

                        //     if (repeatTaskController.selectedYears.isNotEmpty) {
                        //       repeatTaskController.selectedYears.forEach(
                        //         (element) {
                        //           text += "$element, ";
                        //         },
                        //       );
                        //     }

                        //     text +=
                        //         " on ${repeatTaskController.selectedTab.value} basis";
                        //   } else {
                        //     text +=
                        //         "every ${repeatTaskController.selectNoOfWeek.value} week(s) on ";

                        //     if (repeatTaskController
                        //         .selectedWeekDays.isNotEmpty) {
                        //       repeatTaskController.selectedWeekDays.forEach(
                        //         (element) {
                        //           text += "$element, ";
                        //         },
                        //       );
                        //     }
                        //   }

                        //   return Text(text);
                        // }),

                        Obx(
                          () {
                            if (_updateRepeatTaskController
                                .dataSetForRepeatTask.value) {
                              Widget textWidget1;

                              String text = "You want to repeat this task ";

                              print(
                                  "_updateRepeatTaskController.selectedTab.value != weekly ${_updateRepeatTaskController.selectedTab.value != "Weekly"}");
                              if (_updateRepeatTaskController
                                      .selectedTab.value !=
                                  "Weekly") {
                                if (_updateRepeatTaskController
                                    .selectedDays.isNotEmpty) {
                                  _updateRepeatTaskController.selectedDays
                                      .forEach(
                                    (element) {
                                      text += "$element, ";
                                    },
                                  );
                                }

                                if (_updateRepeatTaskController
                                    .selectedMonths.isNotEmpty) {
                                  _updateRepeatTaskController.selectedMonths
                                      .forEach(
                                    (element) {
                                      text += "$element, ";
                                    },
                                  );
                                }

                                if (_updateRepeatTaskController
                                    .selectedYears.isNotEmpty) {
                                  _updateRepeatTaskController.selectedYears
                                      .forEach(
                                    (element) {
                                      text += "$element, ";
                                    },
                                  );
                                }

                                text +=
                                    " on ${_updateRepeatTaskController.selectedTab.value} basis";
                              } else {
                                text +=
                                    "every ${_updateRepeatTaskController.selectNoOfWeek.value} week(s) on ";

                                if (_updateRepeatTaskController
                                    .selectedWeekDays.isNotEmpty) {
                                  _updateRepeatTaskController.selectedWeekDays
                                      .forEach(
                                    (element) {
                                      text += "$element, ";
                                    },
                                  );
                                }
                              }

                              textWidget1 = Text(text);

                              Widget textWidget2;

                              if (_updateRepeatTaskController.selectedOption ==
                                  CommonStrings.selectedOption) {
                                textWidget2 = Text(
                                    "You choose to not stop repeating task");
                              } else {
                                textWidget2 = Text(
                                    "This repeating task will stop on ${_updateRepeatTaskController.repeatTaskDateEditingController.value.text}");
                              }

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWidget1,
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  textWidget2
                                ],
                              );
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Builder(builder: (context) {
                                    //  String repeatTaskOn = "";

                                    String text =
                                        "You want to repeat this task ";

                                    if (data["isRepeatTaskWeekBasis"] == true) {
                                      text +=
                                          "every ${data["repeatOnNoOfWeeks"]} week(s) on ";
                                      data["repeatTaskOn"].forEach((element) {
                                        text += "$element, ";
                                      });
                                    } else {
                                      data["repeatTaskOn"].forEach((element) {
                                        text += "$element, ";
                                      });
                                      text +=
                                          "on ${data["repeatTaskOnBasisOf"]} basis";
                                    }

                                    return Text(text);
                                  }),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Builder(
                                    builder: (context) {
                                      String date = "";
                                      if (data["dateToStopRepeatingTask"] !=
                                              null &&
                                          data["dateToStopRepeatingTask"] !=
                                              "") {
                                        print(
                                            "dateToStopRepeatingTask ${data["dateToStopRepeatingTask"]}");
                                        DateTime dateToStopRepeatingTask =
                                            DateTime.parse(
                                                data["dateToStopRepeatingTask"]
                                                    .toString());

                                        date =
                                            "${dateToStopRepeatingTask.day}-${dateToStopRepeatingTask.month}-${dateToStopRepeatingTask.year}";
                                      }

                                      if (data["willTaskStopRepeating"]) {
                                        return Text(
                                            "This repeating task will stop on $date");
                                      } else {
                                        return Text(
                                            "You choose to not stop repeating task");
                                      }
                                    },
                                  ),
                                ],
                              );
                            }
                          },
                        )

                        // GetBuilder<RepeatTaskController>(
                        //   builder: (controller) {
                        //     if (controller.selectedOption ==
                        //         CommonStrings.selectedOption) {
                        //       return Text(
                        //           "You choose to not stop repeating task");
                        //     } else {
                        //       return Text(
                        //           "This repeating task will stop on ${controller.repeatTaskDateEditingController.value.text}");
                        //     }
                        //   },
                        // ),

                        // SizedBox(
                        //   height: 5.0,
                        // ),
                        // Obx(() => Text(
                        //     "Remainder is set at ${repeatTaskController.remainderTimeController.text} on due date")),
                      ],
                    ),
                    //   } else {
                    //     return SizedBox();
                    //   }
                    // }),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (mounted) {
                          showModalBottomSheet(
                            enableDrag: false,
                            constraints: BoxConstraints.expand(
                                width: Get.width, height: Get.height - 80),
                            //  isDismissible: false,
                            context: context,
                            //showDragHandle: true,
                            isScrollControlled: true,
                            builder: (context) {
                              return UpdateRepeatTaskForm(
                                data: data,
                              );
                            },
                          );
                        }
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
                            "Update Repeat Task",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Get.theme.primaryColor,
                              color: Get.theme.primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),

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
                          "Update priority",
                          // style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        DropdownButtonHideUnderline(
                          child: Obx(
                            () => DropdownButton(
                              value:
                                  _updateTaskController.selectedPriority.value,
                              icon: Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.arrow_drop_down_rounded)),
                              items: _updateTaskController.priorities
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
                                _updateTaskController.selectedPriority.value =
                                    value.toString();
                                _updateTaskController.isPioritySelected.value =
                                    true;
                              },
                            ),
                          ),
                        )
                      ],
                    ),

                    Obx(() {
                      if (_updateTaskController.showPriorityError.value) {
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
                          "Update Tags",
                          // style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        DropdownButtonHideUnderline(
                          child: Obx(
                            () => DropdownButton(
                              value: _updateTaskController.selectedTag.value,
                              icon: Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.arrow_drop_down_rounded)),
                              items: _updateTaskController.tags
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
                                _updateTaskController.selectedTag.value =
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
                      style:
                          TextStyle(fontSize: FontSizes.textFormFieldFontSize),
                      controller: _updateTaskController.remarkController,
                      keyboardType: TextInputType.multiline,
                      // validator: ValidationHelper.isFullAddress,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: FontSizes.textFormFieldFontSize),
                        labelText: "Update remarks",
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
                    //   controller: _updateTaskController.assignedByController,
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

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         // if (await Permission.storage.isGranted) {
                    //         //   FilePickerResult? result =
                    //         //       await FilePicker.platform.pickFiles();

                    //         //   if (result != null) {
                    //         //     File file = File(result.files.single.path!);
                    //         //     String fullPath = await supabase.storage
                    //         //         .from(DatabaseReferences.bucketId)
                    //         //         .upload(
                    //         //             "${_userActivitiesController.companyName.value}/${_updateTaskController.assignedTo.value}/documents",
                    //         //             file,
                    //         //             fileOptions: FileOptions(
                    //         //                 cacheControl: '3600', upsert: false),
                    //         //             retryAttempts: 2);
                    //         //   } else {
                    //         //     // User canceled the picker
                    //         //   }
                    //         // }
                    //         _updateTaskController.uploadDocument();
                    //       },
                    //       child: Container(
                    //         //  width: 170.0,
                    //         decoration: BoxDecoration(
                    //             // border: border,
                    //             color: const Color.fromARGB(255, 234, 234, 234),
                    //             borderRadius: BorderRadius.circular(15.0)),
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 10.0, horizontal: 10.0),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Image.asset(
                    //               "assets/images/icons8_attachment_100.png",
                    //               width: 21.0,
                    //               height: 21.0,
                    //             ),
                    //             SizedBox(
                    //               width: 5.0,
                    //             ),
                    //             Text(
                    //               "Update Attachment",
                    //               style: TextStyle(
                    //                 fontSize: 15,
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),

                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.end,
                    //       children: [
                    //         GestureDetector(
                    //             onTap: () {
                    //               Get.back();
                    //             },
                    //             child: ButtonWidget(
                    //                 isLoading: false,
                    //                 width: 81.0,
                    //                 color: Colors.white,
                    //                 textColor: Get.theme.primaryColor,
                    //                 // borderRadius: BorderRadius.circular(5.0),
                    //                 border: Border.all(
                    //                   color: Get.theme.primaryColor,
                    //                 ),
                    //                 text: "Cancel")
                    //             //  Container(
                    //             //   padding: EdgeInsets.symmetric(
                    //             //       horizontal: 15.0, vertical: 8.0),
                    //             //   decoration: BoxDecoration(
                    //             //     borderRadius: BorderRadius.circular(5.0),
                    //             //     border: Border.all(color: Colors.blue),
                    //             //   ),
                    //             //   child: Text(
                    //             //     "Cancel",
                    //             //     style: TextStyle(color: Colors.blue),
                    //             //   ),
                    //             // ),
                    //             ),
                    //         SizedBox(
                    //           width: 10.0,
                    //         ),
                    //         Obx(
                    //           () => GestureDetector(
                    //               onTap: () async {
                    //                 // if (_updateTaskController
                    //                 //         .isPioritySelected.value ==
                    //                 //     false) {
                    //                 //   _updateTaskController
                    //                 //       .showPriorityError.value = true;
                    //                 // }

                    //                 // if (_updateTaskController
                    //                 //         .statusUpdated.value ==
                    //                 //     false) {
                    //                 //   _updateTaskController.showStatusError.value =
                    //                 //       true;
                    //                 // }

                    //                 // if (_updateTaskController
                    //                 //         .isEmployeeAssigned.value ==
                    //                 //     false) {
                    //                 //   _updateTaskController
                    //                 //       .showSelectedEmpError.value = true;
                    //                 // }

                    //                 //  if (_formKey.currentState!.validate()) {

                    //                 // _updateTaskController.appointments.add(
                    //                 //     Appointment(
                    //                 //         isAllDay: false,
                    //                 //         startTime: DateTime.parse(
                    //                 //             _updateTaskController
                    //                 //                 .startDateEditingController
                    //                 //                 .text),
                    //                 //         endTime: DateTime.parse(
                    //                 //             _updateTaskController
                    //                 //                 .dueDateEditingController
                    //                 //                 .text),
                    //                 //         color: getColor(),
                    //                 //         subject: _updateTaskController
                    //                 //             .taskNameController.text));

                    //                 //  Get.back();

                    //                 /////////////////////////////////////

                    //                 // if (forAdmin) {
                    //                 //   switch (_updateTaskController
                    //                 //       .selectedStatus.value) {
                    //                 //     case "Assigned":
                    //                 //       _updateTaskController.taskLabel.value =
                    //                 //           "Assigned to";
                    //                 //       break;
                    //                 //     case "In progress":
                    //                 //       _updateTaskController.taskLabel.value =
                    //                 //           "In progress by";
                    //                 //       break;
                    //                 //     case "Completed":
                    //                 //       _updateTaskController.taskLabel.value =
                    //                 //           "Completed by";
                    //                 //       break;
                    //                 //     case "Hold":
                    //                 //       _updateTaskController.taskLabel.value =
                    //                 //           "Hold by";
                    //                 //       break;
                    //                 //     default:
                    //                 //       _updateTaskController.taskLabel.value =
                    //                 //           "Assigned to";
                    //                 //   }
                    //                 // }

                    //                 ////////////////////////////////////////////////

                    //                 // if (_updateTaskController
                    //                 //         .isPioritySelected.value &&
                    //                 //     _updateTaskController
                    //                 //         .statusUpdated.value &&
                    //                 //     _updateTaskController
                    //                 //         .isEmployeeAssigned.value) {

                    //                 await _updateTaskController.updateTask(
                    //                     widget.document,
                    //                     widget.username,
                    //                     widget.forEmp,
                    //                     widget.appTitle,
                    //                     widget.forAdmin,
                    //                     data["taskName"].toString(),
                    //                     widget.forTaskOverview,
                    //                     widget.forUsersProfile);

                    //                 if (widget.forAdmin == false) {
                    //                   _updateTaskController
                    //                       .employeesToAssign.value
                    //                       .clear();

                    //                   _updateTaskController.assignedTo.value =
                    //                       _updateTaskController
                    //                               .employeesToAssign.isNotEmpty
                    //                           ? _updateTaskController
                    //                               .employeesToAssign[0]
                    //                           : "Choose employee";
                    //                 }

                    //                 print(
                    //                     "_updateTaskController.eassignedTo.value ${_updateTaskController.assignedTo.value}");

                    //                 _updateTaskController.taskNameController
                    //                     .clear();

                    //                 _updateTaskController.descriptionController
                    //                     .clear();

                    //                 _updateTaskController
                    //                     .startDateEditingController
                    //                     .clear();

                    //                 _updateTaskController
                    //                     .dueDateEditingController
                    //                     .clear();

                    //                 _updateTaskController
                    //                     .remainderTimeController
                    //                     .clear();

                    //                 _updateTaskController
                    //                     .setRemainderOptionController
                    //                     .clear();

                    //                 _updateTaskController.selectedStatus.value =
                    //                     "Assigned";

                    //                 _updateTaskController
                    //                     .selectedPriority.value = "High";
                    //                 _updateTaskController.selectedTag.value =
                    //                     "No tags added";

                    //                 _updateTaskController.remarkController
                    //                     .clear();
                    //                 //  }
                    //                 //   }
                    //               },
                    //               child: ButtonWidget(
                    //                   isLoading: _updateTaskController
                    //                       .updatingTask.value,
                    //                   width: 85.0,
                    //                   text: "Update",
                    //                   textColor: Colors.white,
                    //                   color: Get.theme.primaryColor)),
                    //         )
                    //       ],
                    //     ),

                    //   ],
                    // ),

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
                              onTap: () async {
                                // if (_updateTaskController
                                //         .isPioritySelected.value ==
                                //     false) {
                                //   _updateTaskController
                                //       .showPriorityError.value = true;
                                // }

                                // if (_updateTaskController
                                //         .statusUpdated.value ==
                                //     false) {
                                //   _updateTaskController.showStatusError.value =
                                //       true;
                                // }

                                // if (_updateTaskController
                                //         .isEmployeeAssigned.value ==
                                //     false) {
                                //   _updateTaskController
                                //       .showSelectedEmpError.value = true;
                                // }

                                //  if (_formKey.currentState!.validate()) {

                                // _updateTaskController.appointments.add(
                                //     Appointment(
                                //         isAllDay: false,
                                //         startTime: DateTime.parse(
                                //             _updateTaskController
                                //                 .startDateEditingController
                                //                 .text),
                                //         endTime: DateTime.parse(
                                //             _updateTaskController
                                //                 .dueDateEditingController
                                //                 .text),
                                //         color: getColor(),
                                //         subject: _updateTaskController
                                //             .taskNameController.text));

                                //  Get.back();

                                /////////////////////////////////////

                                // if (forAdmin) {
                                //   switch (_updateTaskController
                                //       .selectedStatus.value) {
                                //     case "Assigned":
                                //       _updateTaskController.taskLabel.value =
                                //           "Assigned to";
                                //       break;
                                //     case "In progress":
                                //       _updateTaskController.taskLabel.value =
                                //           "In progress by";
                                //       break;
                                //     case "Completed":
                                //       _updateTaskController.taskLabel.value =
                                //           "Completed by";
                                //       break;
                                //     case "Hold":
                                //       _updateTaskController.taskLabel.value =
                                //           "Hold by";
                                //       break;
                                //     default:
                                //       _updateTaskController.taskLabel.value =
                                //           "Assigned to";
                                //   }
                                // }

                                ////////////////////////////////////////////////

                                // if (_updateTaskController
                                //         .isPioritySelected.value &&
                                //     _updateTaskController
                                //         .statusUpdated.value &&
                                //     _updateTaskController
                                //         .isEmployeeAssigned.value) {

                                await _updateTaskController.updateTask(
                                    widget.document,
                                    widget.username,
                                    widget.forEmp,
                                    widget.appTitle,
                                    widget.forAdmin,
                                    data["taskName"].toString(),
                                    widget.forTaskOverview,
                                    widget.forUsersProfile);

                                if (widget.forAdmin == false) {
                                  _updateTaskController.employeesToAssign.value
                                      .clear();

                                  _updateTaskController.assignedTo.value =
                                      _updateTaskController
                                              .employeesToAssign.isNotEmpty
                                          ? _updateTaskController
                                              .employeesToAssign[0]
                                          : "Choose employee";
                                }

                                print(
                                    "_updateTaskController.eassignedTo.value ${_updateTaskController.assignedTo.value}");

                                _updateTaskController.taskNameController
                                    .clear();

                                _updateTaskController.descriptionController
                                    .clear();

                                _updateTaskController.startDateEditingController
                                    .clear();

                                _updateTaskController.dueDateEditingController
                                    .clear();

                                _updateTaskController.remainderTimeController
                                    .clear();

                                _updateTaskController
                                    .setRemainderOptionController
                                    .clear();

                                _updateTaskController.selectedStatus.value =
                                    "Assigned";

                                _updateTaskController.selectedPriority.value =
                                    "High";
                                _updateTaskController.selectedTag.value =
                                    "No tags added";

                                _updateTaskController.remarkController.clear();
                                //  }
                                //   }
                              },
                              child: ButtonWidget(
                                  isLoading:
                                      _updateTaskController.updatingTask.value,
                                  width: 85.0,
                                  text: "Update",
                                  textColor: Colors.white,
                                  color: Get.theme.primaryColor)),
                        )
                      ],
                    ),

                    //   ],
                    // )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Color getColor() {
    switch (_updateTaskController.selectedPriority.value) {
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
