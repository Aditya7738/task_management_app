import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_management_app/views/admin_dash_board.dart';
import 'package:task_management_app/views/create_task.dart';
import 'package:task_management_app/views/dashboard_screen.dart';
import 'package:task_management_app/views/login_page.dart';
import 'package:task_management_app/views/navigate_user.dart';
import 'package:task_management_app/views/signup_page.dart';
import 'package:task_management_app/widgets/repeat_task_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // User? user = auth.currentUser;
    // if (user != null) {
    //   print("User is logged in");
    //   //   Get.to(() => AdminDashboardScreen());
    //   return GetMaterialApp(
    //       theme:
    //           // ThemeData(
    //           //   inputDecorationTheme: InputDecorationTheme(
    //           //     border: OutlineInputBorder(
    //           //       borderSide: BorderSide(color: Colors.red, width: 2.0),
    //           //       //  borderRadius: BorderRadius.circular(10),
    //           //     ),
    //           //   ),
    //           //   primaryColor: Color.fromARGB(255, 17, 35, 230),
    //           //   focusColor: Color.fromARGB(255, 17, 35, 230),
    //           // ),
    //           ThemeData(
    //         primaryColor: Color.fromARGB(255, 17, 35, 230),
    //         inputDecorationTheme: InputDecorationTheme(
    //           // labelStyle: TextStyle(
    //           //   color: Colors.red,
    //           // ),
    //           // floatingLabelStyle: TextStyle(
    //           //   color: Color.fromARGB(255, 17, 35, 230),
    //           // ),
    //           errorStyle: TextStyle(color: Colors.red),
    //           // hintStyle: TextStyle(
    //           //   color: Colors.red,
    //           // ),
    //           border: const OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //               borderSide: BorderSide(
    //                 color: Color.fromARGB(255, 17, 35, 230),
    //               )),
    //           focusedBorder: const OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //               borderSide: BorderSide(
    //                 color: Color.fromARGB(255, 17, 35, 230),
    //               )),
    //           enabledBorder: const OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //               borderSide: BorderSide(
    //                 color: Color.fromARGB(255, 17, 35, 230),
    //               )),
    //           errorBorder: const OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //               borderSide: BorderSide(color: Colors.red)),
    //           focusedErrorBorder: const OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //               borderSide: BorderSide(color: Colors.red)),
    //         ),
    //       ),
    //       debugShowCheckedModeBanner: false,
    //       home: AdminDashboardScreen());

    // } else {
    //   print("User is not logged in");
    //   return GetMaterialApp(
    //       theme:
    //           // ThemeData(
    //           //   inputDecorationTheme: InputDecorationTheme(
    //           //     border: OutlineInputBorder(
    //           //       borderSide: BorderSide(color: Colors.red, width: 2.0),
    //           //       //  borderRadius: BorderRadius.circular(10),
    //           //     ),
    //           //   ),
    //           //   primaryColor: Color.fromARGB(255, 17, 35, 230),
    //           //   focusColor: Color.fromARGB(255, 17, 35, 230),
    //           // ),
    //           ThemeData(
    //         primaryColor: Color.fromARGB(255, 17, 35, 230),
    //         inputDecorationTheme: InputDecorationTheme(
    //           // labelStyle: TextStyle(
    //           //   color: Colors.red,
    //           // ),
    //           // floatingLabelStyle: TextStyle(
    //           //   color: Color.fromARGB(255, 17, 35, 230),
    //           // ),
    //           errorStyle: TextStyle(color: Colors.red),
    //           // hintStyle: TextStyle(
    //           //   color: Colors.red,
    //           // ),
    //           border: const OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //               borderSide: BorderSide(
    //                 color: Color.fromARGB(255, 17, 35, 230),
    //               )),
    //           focusedBorder: const OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //               borderSide: BorderSide(
    //                 color: Color.fromARGB(255, 17, 35, 230),
    //               )),
    //           enabledBorder: const OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //               borderSide: BorderSide(
    //                 color: Color.fromARGB(255, 17, 35, 230),
    //               )),
    //           errorBorder: const OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //               borderSide: BorderSide(color: Colors.red)),
    //           focusedErrorBorder: const OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
    //               borderSide: BorderSide(color: Colors.red)),
    //         ),
    //       ),
    //       debugShowCheckedModeBanner: false,
    //       home: LoginPage());
    // }

    return GetMaterialApp(
        theme: ThemeData(
          radioTheme: RadioThemeData(
            fillColor:
                MaterialStateProperty.all(Color.fromARGB(255, 17, 35, 230)),
          ),
          primaryColor: Color.fromARGB(255, 17, 35, 230),
          inputDecorationTheme: InputDecorationTheme(
            errorStyle: TextStyle(color: Colors.red),
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
        home: NavigateUser());
  }
}
