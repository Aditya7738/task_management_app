import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/controller/repeat_task_controller.dart';
import 'package:task_management_app/controller/task_screen_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class TaskList extends StatefulWidget {
  final String username;
  final bool forManager;
  TaskList({super.key, required this.forManager, required this.username});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TaskScreenController taskScreenController = Get.put(TaskScreenController());

  var options = [
    "Edit",
    "Move to",
    "Delete",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //taskScreenController.getAssignedTasklist();
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FutureBuilder(
          future:
              taskScreenController.getAssignedTasklist(true, widget.username),
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
                      });

                      // String date = data['timeStamp'];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/task_detail');
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Text(getDayTime(data['timeStamp']),
                                            style: TextStyle(fontSize: 12.0)),
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
                                                  DropdownMenuItem<String>(
                                                value: option,
                                                //      height: 40,
                                                child: Text(
                                                  option,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    // fontWeight: FontWeight.bold,
                                                    // color: Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        //valueListenable: valueListenable,
                                        onChanged: (value) {
                                          //    valueListenable.value = value;
                                          // if (value == "Move to") {
                                          //   Get.dialog(
                                          //     GetBuilder<RepeatTaskController>(
                                          //       builder: (controller) => RadioMenuButton(
                                          //         value: "Do not stop repeating this task",
                                          //         groupValue: controller.selectedOption,
                                          //         onChanged: (value) {
                                          //           controller.updateSelectedOption(
                                          //               value.toString());
                                          //         },
                                          //         child:
                                          //             Text("Do not stop repeating this task"),
                                          //       ),
                                          //     ),
                                          //   );
                                          // }
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: 10,
                                          width: 20,
                                          decoration: BoxDecoration(),
                                        ),
                                        iconStyleData: IconStyleData(
                                          icon: Icon(
                                            Icons.more_vert_outlined,
                                          ),
                                          iconSize: 14,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
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
                                Text(data['taskName'],
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(data['remarks'],
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.grey)),
                              ],
                            )),
                      );
                    },
                  ).toList(),
                );

                //               return ListView.builder(
                //   itemCount: 5,
                //   itemBuilder: (context, index) {
                return Container(
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
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Iconsax.calendar_1_outline, size: 13.0),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("Yesterday",
                                    style: TextStyle(fontSize: 12.0)),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("- 11:00 pm",
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.grey)),
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
                                      (option) => DropdownMenuItem<String>(
                                        value: option,
                                        //      height: 40,
                                        child: Text(
                                          option,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            // fontWeight: FontWeight.bold,
                                            // color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                //valueListenable: valueListenable,
                                onChanged: (value) {
                                  //    valueListenable.value = value;
                                  // if (value == "Move to") {
                                  //   Get.dialog(
                                  //     GetBuilder<RepeatTaskController>(
                                  //       builder: (controller) => RadioMenuButton(
                                  //         value: "Do not stop repeating this task",
                                  //         groupValue: controller.selectedOption,
                                  //         onChanged: (value) {
                                  //           controller.updateSelectedOption(
                                  //               value.toString());
                                  //         },
                                  //         child:
                                  //             Text("Do not stop repeating this task"),
                                  //       ),
                                  //     ),
                                  //   );
                                  // }
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 10,
                                  width: 20,
                                  decoration: BoxDecoration(),
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.more_vert_outlined,
                                  ),
                                  iconSize: 14,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text("Task title",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text("Task description",
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.grey)),
                      ],
                    ));

                //   },
                // );
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
          }),
    );
  }
}
