import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/views/admin_dash_board.dart';
import 'package:task_management_app/views/dashboard_screen.dart';
import 'package:task_management_app/views/login_page.dart';

class NavigateUser extends StatefulWidget {
  NavigateUser({super.key});

  @override
  State<NavigateUser> createState() => _NavigateUserState();
}

class _NavigateUserState extends State<NavigateUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkUserRole();
  }

  String roleName = "";

  Future<void> checkUserRole() async {
    if (await sharedPreferencesAsync.getString("role") != null) {
      roleName = (await sharedPreferencesAsync.getString("role"))!;
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  SharedPreferencesAsync sharedPreferencesAsync = SharedPreferencesAsync();

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;

    if (user != null) {
      print("User is logged in");

      if (roleName == "Admin") {
        return AdminDashboardScreen();
      } else {
        return DashboardScreen();
      }
    } else {
      print("User is not logged in");
      return LoginPage();
    }
  }
}
