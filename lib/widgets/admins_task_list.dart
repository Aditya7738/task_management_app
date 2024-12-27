import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/controller/repeat_task_controller.dart';
import 'package:task_management_app/controller/task_screen_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:task_management_app/controller/tasks_overview_controller.dart';
import 'package:task_management_app/views/task_details.dart';
import 'package:task_management_app/views/update_task.dart';
import 'package:task_management_app/widgets/button_widget.dart';

class AdminsTaskList extends StatefulWidget {
  final String typeOfTasks;

  AdminsTaskList({
    super.key,
    required this.typeOfTasks,
  });

  @override
  State<AdminsTaskList> createState() => _AdminsTaskListState();
}

class _AdminsTaskListState extends State<AdminsTaskList> {
  TasksOverviewController tasksOvTasksOverviewController =
      Get.put(TasksOverviewController());

  var options = [
    "Edit",
    "Move to",
    "Delete",
  ];

  TaskScreenController _taskScreenController = Get.put(TaskScreenController());

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, DocumentSnapshot document) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete task",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          content: Text("Are you sure you want to delete this task?",
              style: TextStyle(
                color: const Color(0xFF555770),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: -0.32,
              )),
          actions: [
            GestureDetector(
                onTap: () {
                  // _tasksOverviewController.deleteTask(document, widget.appTitle,
                  //     widget.username, widget.forManager, widget.forAdmin);
                  _taskScreenController.deleteTask(
                      document, "", "", false, true, true);
                },
                child: Obx(
                  () => ButtonWidget(
                    isLoading: // false,
                        _taskScreenController.deletingTask.value,
                    width: 100.0,
                    color: Colors.red,
                    text: "Delete",
                    textColor: Colors.white,
                  ),
                )),
            const SizedBox(
              width: 10.0,
            ),
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Get.theme.primaryColor

                      // color: Colors.black,
                      //fontSize: deviceWidth > 600 ? 25 : 17
                      ),
                )
                //  ),
                ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //tasksOvTasksOverviewController.getAssignedAdminsTasklist();
  }

  String getDayTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = "";

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));

    if (dateTime.isAfter(today)) {
      formattedDate = 'Today, ${DateFormat('hh:mm a').format(dateTime)}';
    } else if (dateTime.isAfter(yesterday)) {
      formattedDate = 'Yesterday, ${DateFormat('hh:mm a').format(dateTime)}';
    } else {
      formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
    }

    return formattedDate;
  }

  TasksOverviewController _tasksOverviewController =
      Get.put(TasksOverviewController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child:
            //  Obx(() {
            //   print(
            //       "gettingUsernameOfEmp: ${_tasksOverviewController.gettingUsernameOfEmp.value}");
            //   if (_tasksOverviewController.gettingUsernameOfEmp.value) {
            //     return SizedBox(
            //       width: Get.width,
            //       height: Get.height * 0.26,
            //       child: Center(
            //         child: CircularProgressIndicator(
            //           color: Get.theme.primaryColor,
            //         ),
            //       ),
            //     );
            //   } else {
            //     return
            FutureBuilder(
                future: _tasksOverviewController.getTasks(widget.typeOfTasks),
                builder: (context, snapshot) {
                  if (
                      //true
                      snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: Get.width,
                      height: Get.height * 0.26,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      print(
                          "snapshot.data!.docs.length ${snapshot.data!.docs.length}");

                      return ListView(
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map(
                          (DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;

                            data.forEach((key, value) {
                              print("key: $key, value: $value");

                              print("value.runtimeType ${value.runtimeType}");

                              if (value == null) {
                                print(
                                    "${document.reference.id} $key value is null");
                              }

                              print(
                                  "////////////////////////////////////////////////////////");
                            });

                            // String date = data['timeStamp'];

                            return GestureDetector(
                              onTap: () {
                                //  Get.toNamed('/task_detail');
                                Get.to(() => TaskDetails(data: data));
                              },
                              child: Container(
                                  margin: EdgeInsets.all(8.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(Iconsax.calendar_1_outline,
                                                  size: 13.0),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                  getDayTime(data['timeStamp']
                                                      .toString()),
                                                  style: TextStyle(
                                                      fontSize: 12.0)),
                                              // SizedBox(
                                              //   width: 5.0,
                                              // ),
                                              // Text("- 11:00 pm",
                                              //     style: TextStyle(
                                              //         fontSize: 12.0,
                                              //         color: Colors.grey)),
                                            ],
                                          ),
                                          // DropdownButtonHideUnderline(
                                          //   child: DropdownButton(
                                          //     // menuMaxHeight: 50.0,
                                          //     //   borderRadius: BorderRadius.circular(10.0),
                                          //     iconSize: 10.0,
                                          //     icon: Icon(Icons.more_horiz_outlined, size: 16.0),
                                          //     items:
                                          //         options.map<DropdownMenuItem<String>>((option) {
                                          //       return DropdownMenuItem<String>(
                                          //           value: option, child: Text(option));
                                          //     }).toList(),
                                          //     onChanged: (value) {},
                                          //   ),
                                          // ),
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton2<String>(
                                              isExpanded: true,
                                              items: options
                                                  .map(
                                                    (option) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                      value: option,
                                                      //      height: 40,
                                                      child: Text(
                                                        option,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          // fontWeight: FontWeight.bold,
                                                          // color: Colors.black,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              //valueListenable: valueListenable,
                                              onChanged: (value) {
                                                switch (value) {
                                                  case "Edit":
                                                    Get.to(() => UpdateTask(
                                                          //  data: data,
                                                          forAdmin: true,
                                                          forEmp: false,
                                                          document: document,
                                                          username: "",
                                                          appTitle: "",
                                                          forTaskOverview: true,
                                                        ));
                                                    break;
                                                  case "Move to":
                                                    break;
                                                  case "Delete":
                                                    showDeleteConfirmationDialog(
                                                        context, document);
                                                    break;
                                                  default:
                                                }
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                height: 30,
                                                width: 29,
                                                decoration: BoxDecoration(
                                                    //color: Colors.red
                                                    ),
                                              ),
                                              iconStyleData: IconStyleData(
                                                icon: Container(
                                                  padding: EdgeInsets.all(4.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Icon(
                                                    Icons.more_vert_outlined,
                                                  ),
                                                ),
                                                iconSize: 21,
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                maxHeight: 200,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                              ),
                                              menuItemStyleData:
                                                  const MenuItemStyleData(
                                                padding: EdgeInsets.only(
                                                    left: 14, right: 14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      Text(data['taskName'].toString(),
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold)),
                                      // SizedBox(
                                      //   height: 4.0,
                                      // ),
                                      // Text(data['remarks'],
                                      //     style: TextStyle(
                                      //         fontSize: 13.0, color: Colors.grey)),
                                    ],
                                  )),
                            );
                          },
                        ).toList(),
                      );
                    } else {
                      return Center(
                        child: Text(
                          'No data found',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: Text(
                        'Null data found',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                })
        //         );
        //   }
        // }
        // ),
        );
  }
}
