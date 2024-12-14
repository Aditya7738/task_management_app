import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/views/admin_dash_board.dart';
import 'package:task_management_app/views/login_page.dart';

class NavigateUser extends StatelessWidget {
  NavigateUser({super.key});

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;
    if (user != null) {
      print("User is logged in");
      return AdminDashboardScreen();
    } else {
      print("User is not logged in");
      return LoginPage();
    }
  }
}
