import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_management_app/controller/dashboard_controller.dart';
import 'package:task_management_app/views/calendar_tasks.dart';
import 'package:task_management_app/views/create_task.dart';
import 'package:task_management_app/views/profile_screen.dart';
import 'package:task_management_app/views/tasks_screen.dart';
import 'package:task_management_app/views/board_screen.dart';
import 'package:task_management_app/widgets/task_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // List<Tab> tabs = [
  //   Tab(
  //     child: Container(
  //       height: 44,
  //       alignment: Alignment.center,
  //       padding: EdgeInsets.all(8),
  //       // decoration: BoxDecoration(
  //       //   borderRadius: BorderRadius.circular(23),
  //       //   border: Border.all(
  //       //     color: Colors.grey,
  //       //   ),
  //       // ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const Text(
  //             'Completed',
  //             style: TextStyle(
  //               //   color: Theme.of(context).primaryColor,
  //               fontSize: 13,

  //               //   letterSpacing: -0.28,
  //             ),
  //           ),
  //           SizedBox(width: 5),
  //           Container(
  //             padding: EdgeInsets.all(5),
  //             decoration: BoxDecoration(
  //               //   color: Colors.green,
  //               shape: BoxShape.circle,
  //               border: Border.all(
  //                 color: Colors.grey,
  //               ),
  //             ),
  //             child: Text(
  //               '5',
  //               style: TextStyle(
  //                 // color: Colors.black,
  //                 fontSize: 10,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  //   Tab(
  //     child: Container(
  //       height: 44,
  //       alignment: Alignment.center,
  //       padding: EdgeInsets.all(8),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(23),
  //         border: Border.all(
  //           color: Colors.grey,
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const Text(
  //             'Assigned',
  //             style: TextStyle(
  //               //   color: Theme.of(context).primaryColor,
  //               fontSize: 13,

  //               //   letterSpacing: -0.28,
  //             ),
  //           ),
  //           SizedBox(width: 5),
  //           Container(
  //             padding: EdgeInsets.all(5),
  //             decoration: BoxDecoration(
  //               //   color: Colors.green,
  //               shape: BoxShape.circle,
  //               border: Border.all(
  //                 color: Colors.grey,
  //               ),
  //             ),
  //             child: Text(
  //               '5',
  //               style: TextStyle(
  //                 // color: Colors.black,
  //                 fontSize: 10,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  //   Tab(
  //     child: Container(
  //       height: 44,
  //       alignment: Alignment.center,
  //       padding: EdgeInsets.all(8),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(23),
  //         border: Border.all(
  //           color: Colors.grey,
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const Text(
  //             'In progress',
  //             style: TextStyle(
  //               //   color: Theme.of(context).primaryColor,
  //               fontSize: 13,

  //               //   letterSpacing: -0.28,
  //             ),
  //           ),
  //           SizedBox(width: 5),
  //           Container(
  //             padding: EdgeInsets.all(5),
  //             decoration: BoxDecoration(
  //               //   color: Colors.green,
  //               shape: BoxShape.circle,
  //               border: Border.all(
  //                 color: Colors.grey,
  //               ),
  //             ),
  //             child: Text(
  //               '5',
  //               style: TextStyle(
  //                 // color: Colors.black,
  //                 fontSize: 10,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  //   Tab(
  //     child: Container(
  //       height: 44,
  //       alignment: Alignment.center,
  //       padding: EdgeInsets.all(8),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(23),
  //         border: Border.all(
  //           color: Colors.grey,
  //         ),
  //       ),
  // child: Row(
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: [
  //     const Text(
  //       'Hold',
  //       style: TextStyle(
  //         //   color: Theme.of(context).primaryColor,
  //         fontSize: 13,

  //         //   letterSpacing: -0.28,
  //       ),
  //     ),
  //     SizedBox(width: 5),
  //     Container(
  //       padding: EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //         //   color: Colors.green,
  //         shape: BoxShape.circle,
  //         border: Border.all(
  //           color: Colors.grey,
  //         ),
  //       ),
  //       child: Text(
  //         '5',
  //         style: TextStyle(
  //           // color: Colors.black,
  //           fontSize: 10,
  //         ),
  //       ),
  //     ),
  //   ],
  //  ),
  //     ),
  //   ),
  // ];

  // List<Tab> tabs() => [
  //       Tab(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               'Hold',
  //               style: TextStyle(
  //                 //   color: Theme.of(context).primaryColor,
  //                 fontSize: 13,

  //                 //   letterSpacing: -0.28,
  //               ),
  //             ),
  //             SizedBox(width: 5),
  //             Container(
  //               padding: EdgeInsets.all(5),
  //               decoration: BoxDecoration(
  //                 //   color: Colors.green,
  //                 shape: BoxShape.circle,
  //                 border: Border.all(
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //               child: Text(
  //                 '5',
  //                 style: TextStyle(
  //                   // color: Colors.black,
  //                   fontSize: 10,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Tab(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               'Hold',
  //               style: TextStyle(
  //                 //   color: Theme.of(context).primaryColor,
  //                 fontSize: 13,

  //                 //   letterSpacing: -0.28,
  //               ),
  //             ),
  //             SizedBox(width: 5),
  //             Container(
  //               padding: EdgeInsets.all(5),
  //               decoration: BoxDecoration(
  //                 //   color: Colors.green,
  //                 shape: BoxShape.circle,
  //                 border: Border.all(
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //               child: Text(
  //                 '5',
  //                 style: TextStyle(
  //                   // color: Colors.black,
  //                   fontSize: 10,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       )
  //     ];

  List<Widget> tabs = <Widget>[TasksScreen(), BoardScreen(), ProfileScreen()];

  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            dashboardController.currentIndex.value = index;
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add_task_outlined),
              activeIcon: Icon(Icons.add_task_sharp),
              label: 'All task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.profile_circle_outline),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Get.theme.primaryColor,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          currentIndex: dashboardController.currentIndex.value,
          unselectedItemColor: Colors.grey,
          // showSelectedLabels: true,
          // showUnselectedLabels: true,
        ),
        body: tabs[dashboardController.currentIndex.value],
      ),
    );
  }
}
