import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/views/admin_dash_board.dart';
import 'package:task_management_app/views/create_task.dart';
import 'package:task_management_app/views/dashboard_screen.dart';
import 'package:task_management_app/widgets/repeat_task_form.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 17, 35, 230),
        ),
        debugShowCheckedModeBanner: false,
        home: DashboardScreen());
  }
}
