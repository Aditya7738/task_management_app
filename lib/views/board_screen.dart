import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_management_app/controller/board_screen_controller.dart';
import 'package:task_management_app/widgets/leading_back_arrow.dart';

class BoardScreen extends StatefulWidget {
  BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  BoardScreenController boardScreenController =
      Get.put(BoardScreenController());

  List<Widget> listCards() {
    List<Color> colors = [];
    List<String> boradTitle = [];

    switch (boardScreenController.selectedBoard.value) {
      case "All tasks":
        colors = [
          Colors.blue,
          Colors.green,
          Colors.grey,
        ];
        boradTitle = [
          'Board',
          'Manage',
          'Task',
        ];
        break;
      case "Completed":
        colors = [
          Colors.green,
          Colors.grey,
          Colors.blue,
        ];
        boradTitle = [
          'Manage',
          'Task',
          'Board',
        ];
        break;
      case "Pending":
        colors = [
          Colors.grey,
          Colors.blue,
          Colors.green,
        ];
        boradTitle = [
          'Task',
          'Board',
          'Manage',
        ];
        break;
      default:
        colors = [
          Colors.grey,
          Colors.blue,
          Colors.green,
        ];
        boradTitle = [
          'Task',
          'Board',
          'Manage',
        ];
    }

    List<Widget> list = [];
    for (var i = 0; i < 3; i++) {
      list.add(
        // Container(
        //   width: Get.width * 0.9,
        //   height: Get.height - 140,
        //   color: Colors.red,
        //   child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * 0.9,
              height: 30.0,
              color: colors[i],
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    boradTitle[i],
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "3",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),

            ///user function to render multiple widgets instead of below
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: (Get.width * 0.9) - 1.0,
                  height: Get.height - 175,
                  color: const Color.fromARGB(255, 239, 239, 239),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child:
                      //  Scrollbar(
                      //   // trackVisibility: true,
                      //   thumbVisibility: true,
                      //   thickness: 5.0,
                      //   child:
                      SingleChildScrollView(
                    child: Column(
                      children: listOfTaskInCards(),
                    ),
                  ),
                  //)
                ),
                // Container(
                //   width: 1.0,
                //   height: Get.height - 152,
                //   color: Colors.grey,
                // ),
              ],
            ),
          ],
        ),
        //),
      );
    }
    return list;
  }

  List<Widget> listOfTaskInCards() {
    List<Widget> list = [];
    for (var i = 0; i < 3; i++) {
      list.add(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Task ${i + 1}',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text('Description of task 1',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                    SizedBox(
                      height: 5.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        "assets/images/create_task_screen.png",
                        width: Get.width,
                        height: 100.0,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/icons8_attachment_100.png",
                          width: 15.0,
                          height: 15.0,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('1'),
                      ],
                    ),
                  ])),
          SizedBox(height: 10.0),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('This task is assigned to Mr.A',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        Image.asset(
                          "assets/images/default_image.png",
                          width: 20.0,
                          height: 20.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text('Description of task ${i + 1}',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                  ])),
          SizedBox(height: 10.0),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('This task is assigned to Mr.A',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text('Description of task ${i + 1}',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                  ])),
        ],
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          //  leading: LeadingBackArrow(),
          toolbarHeight: 40.0,
          title: const Text(
            'Task manager',
            style: TextStyle(fontSize: 17.0),
          ),
          actions: [
            Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: boardScreenController.selectedBoard.value,
                  icon: Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: Icon(Icons.arrow_drop_down_rounded)),
                  items: boardScreenController.boards
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
                    boardScreenController.selectedBoard.value =
                        value.toString();
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
        body: SizedBox(
          height: Get.height - 50,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...listCards(),
                SizedBox(
                  width: 5.0,
                ),
                Icon(Iconsax.add_circle_bold),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
