import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_management_app/controller/dashboard_controller.dart';
import 'package:task_management_app/controller/login_controller.dart';
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
  List<Widget> tabs = <Widget>[
    TasksScreen(),
    CalendarTasks(),
    BoardScreen(),
    // ProfileScreen()
  ];

  DashboardController dashboardController = Get.put(DashboardController());
  LoginController _loginController = Get.put(LoginController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginController.getPermissions();
  }

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
              icon: Icon(Iconsax.calendar_add_outline),
              activeIcon: Icon(Iconsax.calendar_add_bold),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard_sharp),
              label: 'Task Board',
            ),
          ],
          selectedItemColor: Get.theme.primaryColor,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          currentIndex: dashboardController.currentIndex.value,
          unselectedItemColor: Colors.grey,
        ),
        body: tabs[dashboardController.currentIndex.value],
      ),
    );
  }
}
