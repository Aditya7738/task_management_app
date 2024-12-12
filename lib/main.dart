import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/views/admin_dash_board.dart';
import 'package:task_management_app/views/create_task.dart';
import 'package:task_management_app/views/dashboard_screen.dart';
import 'package:task_management_app/views/signup_page.dart';
import 'package:task_management_app/widgets/repeat_task_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme:
            // ThemeData(
            //   inputDecorationTheme: InputDecorationTheme(
            //     border: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.red, width: 2.0),
            //       //  borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   primaryColor: Color.fromARGB(255, 17, 35, 230),
            //   focusColor: Color.fromARGB(255, 17, 35, 230),
            // ),
            ThemeData(
          primaryColor: Color.fromARGB(255, 17, 35, 230),
          inputDecorationTheme: InputDecorationTheme(
            // labelStyle: TextStyle(
            //   color: Colors.red,
            // ),
            // floatingLabelStyle: TextStyle(
            //   color: Color.fromARGB(255, 17, 35, 230),
            // ),
            errorStyle: TextStyle(color: Colors.red),
            // hintStyle: TextStyle(
            //   color: Colors.red,
            // ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 17, 35, 230),
                )),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 17, 35, 230),
                )),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 17, 35, 230),
                )),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.red)),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: SignupPage());
  }
}
