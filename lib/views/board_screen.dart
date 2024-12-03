import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_management_app/controller/board_screen_controller.dart';

class BoardScreen extends StatelessWidget {
  BoardScreen({super.key});

  BoardScreenController boardScreenController =
      Get.put(BoardScreenController());

  List<Widget> listCards() {
    List<Widget> list = [];
    for (var i = 0; i < 1; i++) {
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
              color: Colors.blue,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Task",
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "10",
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),

            ///user function to render multiple widgets instead of below
            Container(
              width: Get.width * 0.9,
              height: Get.height - 154,
              color: Colors.yellow,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Task $index'),
                      subtitle: Text('Description of task $index'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        //),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.0,
        title: const Text(
          'Board',
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
                items:
                    boardScreenController.boards.map<DropdownMenuItem<String>>(
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
                  boardScreenController.selectedBoard.value = value.toString();
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:
            // Container(
            //       color: Colors.yellow,
            //       width: Get.width * 0.9,
            //       height: Get.height - 140,),
            Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // child:

            // ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: 2,
            //   itemBuilder: (context, index) {
            //     return Container(
            //       width: Get.width * 0.45,
            //       //height: Get.height - 617,
            //       color: Colors.red,
            //     );
            //   },
            // ),
            ...listCards(),

            SizedBox(
              width: 5.0,
            ),
            Icon(Iconsax.add_circle_bold),
          ],
        ),
      ),
    );
  }
}
