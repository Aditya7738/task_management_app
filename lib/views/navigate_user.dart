import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/controller/navigate_user_controller.dart';
import 'package:task_management_app/views/admin_dash_board.dart';
import 'package:task_management_app/views/dashboard_screen.dart';
import 'package:task_management_app/views/login_page.dart';

class NavigateUser extends StatefulWidget {
  NavigateUser({super.key});

  @override
  State<NavigateUser> createState() => _NavigateUserState();
}

class _NavigateUserState extends State<NavigateUser> {
  NavigateUserController _navigateUserController =
      Get.put(NavigateUserController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _navigateUserController.checkUserRole();
    _navigateUserController.getStoragePermissions();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;

    if (user != null) {
      print("User is logged in");

      print("Role Name2: ${_navigateUserController.roleName.value}");

      return Obx(() {
        if (_navigateUserController.checkingUserRole.value) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Get.theme.primaryColor,
              ),
            ),
          );
        } else {
          if (_navigateUserController.roleName.value == "Admin") {
            return AdminDashboardScreen();
          } else {
            return DashboardScreen();
          }
        }
      });

      //   if (_navigateUserController.roleName.value == "Admin") {
      //     return AdminDashboardScreen();
      //   } else {
      //     return DashboardScreen();
      //   }
    } else {
      print("User is not logged in");
      return LoginPage();
    }
  }
}
