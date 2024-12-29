import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/controller/dashboard_controller.dart';
import 'package:task_management_app/controller/login_controller.dart';
import 'package:task_management_app/views/assigned_tasks_to_others_list.dart';
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
  DashboardController dashboardController = Get.put(DashboardController());
  LoginController _loginController = Get.put(LoginController());

  // String roleName = "";
  // String username = "";

  List<Widget> tabs() {
    print("Role name: ${dashboardController.roleName.value}");
    print(
        "dashboardController. roleName.value == Manager ${dashboardController.roleName.value == "Manager"}");
    return <Widget>[
      TasksScreen(
        username: dashboardController.username.value,
        forManager:
            dashboardController.roleName.value == "Manager" ? true : false,
        forUsersProfile:
            dashboardController.roleName.value == "Admin" ? false : true,
        forAdmin: false,
      ),
      // CalendarTasks(),
      //  BoardScreen(),

      AssignedTasksToOthersList()
      // ProfileScreen()
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //   _loginController.getPermissions();
    dashboardController.fetchSharedRefData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (dashboardController.roleName.value == "Manager") {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              dashboardController.currentIndex.value = index;
              //  });
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.add_task_outlined),
                activeIcon: Icon(Icons.add_task_sharp),
                label: 'All task',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Iconsax.calendar_add_outline),
              //   activeIcon: Icon(Iconsax.calendar_add_bold),
              //   label: 'Calendar',
              // ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/teamwork_outlined.png",
                  width: 30.0,
                  height: 30.0,
                  color: Colors.grey,
                ),
                activeIcon: Image.asset(
                  "assets/images/teamwork_bold.png",
                  width: 30.0,
                  height: 30.0,
                  color: Get.theme.primaryColor,
                ),
                label: 'Assign tasks',
              ),
            ],
            selectedItemColor: Get.theme.primaryColor,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            currentIndex: dashboardController.currentIndex.value,
            unselectedItemColor: Colors.grey,
          ),
          body: dashboardController.fetchingSharedRefData.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: Get.theme.primaryColor,
                  ),
                )
              : tabs()[dashboardController.currentIndex.value],
        );
      } else {
        return TasksScreen(
          username: dashboardController.username.value,
          forManager:
              dashboardController.roleName.value == "Manager" ? true : false,
          forUsersProfile:
              dashboardController.roleName.value == "Admin" ? false : true,
          forAdmin: false,
        );
      }
      //return SizedBox();
    });
  }
}
