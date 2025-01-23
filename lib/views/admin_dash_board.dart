import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_management_app/controller/admin_dashboard_controller.dart';
import 'package:task_management_app/controller/login_controller.dart';
import 'package:task_management_app/views/tasks_overview.dart';
import 'package:task_management_app/views/users_activities.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  List<Widget> tabs = <Widget>[
    UsersActivities(),

    // Center(
    //   child: Text("Admin Dashboard"),
    // ),
    // Center(
    //   child: Text("Admin Dashboard"),
    // ),
    TasksOverview(),

    // ProfileScreen()
  ];

  AdminDashboardController admindashboardController =
      Get.put(AdminDashboardController());

  LoginController _loginController = Get.put(LoginController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_loginController.getPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            admindashboardController.currentIndex.value = index;
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/group_outline.png",
                width: 25.0,
                height: 25.0,
                color: Colors.grey,
              ),
              activeIcon: Image.asset(
                "assets/images/group_bold.png",
                width: 25.0,
                height: 25.0,
                color: Get.theme.primaryColor,
              ),
              label: 'Users activities',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.calendar_add_outline),
              activeIcon: Icon(Iconsax.calendar_add_bold),
              label: 'Tasks overview',
            ),
          ],
          selectedItemColor: Get.theme.primaryColor,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          currentIndex: admindashboardController.currentIndex.value,
          unselectedItemColor: Colors.grey,
        ),
        body: tabs[admindashboardController.currentIndex.value],

        // body: Center(
        //   child: Text("Admin Dashboard"),
        // ),
      ),
    );
  }
}
