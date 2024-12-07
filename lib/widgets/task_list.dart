import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_management_app/controller/repeat_task_controller.dart';
import 'package:task_management_app/controller/task_screen_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class TaskList extends StatelessWidget {
  TaskList({super.key});

  TaskScreenController taskScreenController = Get.put(TaskScreenController());

  var options = [
    "Edit",
    "Move to",
    "Delete",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
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
                          Icon(Iconsax.calendar_add_outline, size: 13.0),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text("Yesterday", style: TextStyle(fontSize: 12.0)),
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
                      style: TextStyle(fontSize: 13.0, color: Colors.grey)),
                ],
              ));
        },
      ),
    );
  }
}
