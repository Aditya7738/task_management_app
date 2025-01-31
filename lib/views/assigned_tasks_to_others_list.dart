import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_app/constants/fontsizes.dart';
import 'package:task_management_app/controller/assign_tasks_controller.dart';
import 'package:task_management_app/controller/create_task_controller.dart';
import 'package:task_management_app/controller/login_controller.dart';
import 'package:task_management_app/controller/update_task_controller.dart';
import 'package:task_management_app/controller/user_activities_controller.dart';
import 'package:task_management_app/controller/user_task_details_controller.dart';
import 'package:task_management_app/controller/validation_helper.dart';
import 'package:task_management_app/views/add_employees.dart';
import 'package:task_management_app/views/create_task.dart';
import 'package:task_management_app/views/tasks_screen.dart';
import 'package:task_management_app/views/users_task_details.dart';
import 'package:task_management_app/views/login_page.dart';
import 'package:task_management_app/widgets/button_widget.dart';
import 'package:task_management_app/widgets/list_of_user.dart';

class AssignedTasksToOthersList extends StatefulWidget {
  AssignedTasksToOthersList({super.key});

  @override
  State<AssignedTasksToOthersList> createState() =>
      _AssignedTasksToOthersListState();
}

class _AssignedTasksToOthersListState extends State<AssignedTasksToOthersList> {
  FirebaseAuth auth = FirebaseAuth.instance;

  UserActivitiesController _userActivitiesController =
      Get.put(UserActivitiesController());

  LoginController _loginController = Get.put(LoginController());

  // CreateTaskController createTaskController = Get.put(CreateTaskController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(
    //     "_loginController.emailController.value.text ${_loginController.emailController.value.text}");

    // if (_userActivitiesController.companyName.value.isEmpty) {
    //   _userActivitiesController.getCompanyName();
    // }

    // _userActivitiesController.getManagersCollection();
    // _userActivitiesController.getEmployeeCollection();
  }

  Future<void> showUpdateDialog(
      BuildContext context, DocumentSnapshot document) async {
    // double deviceWidth = MediaQuery.of(context).size.width;

    // final customerProvider =
    //     Provider.of<CustomerProvider>(context, listen: false);

    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    _userActivitiesController.firstNameController.text =
        data['firstName'].toString();
    _userActivitiesController.lastNameController.text =
        data['lastName'].toString();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text("Update profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          content: SingleChildScrollView(
            child: SizedBox(
              height: Get.height * .35,
              width: Get.width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fill below details to update selected profile',
                      style: TextStyle(
                        color: const Color(0xFF555770),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.32,
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Obx(
                  //   () =>
                  TextFormField(
                    style: TextStyle(fontSize: FontSizes.textFormFieldFontSize
                        //  deviceWidth > 600
                        //     ? Fontsizes.tabletTextFormInputFieldSize
                        //     : Fontsizes.textFormInputFieldSize
                        ),
                    controller: _userActivitiesController.firstNameController,
                    keyboardType: TextInputType.name,
                    validator: ValidationHelper.nullOrEmptyString,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: FontSizes.errorFontSize,
                          //  deviceWidth > 600
                          //     ? Fontsizes.tabletErrorTextSize
                          //     : Fontsizes.errorTextSize,
                          color: Colors.red),
                      labelStyle: TextStyle(fontSize: 14.0
                          // deviceWidth > 600
                          //     ? Fontsizes.tabletTextFormInputFieldSize
                          //     : Fontsizes.textFormInputFieldSize
                          ),
                      labelText: "Enter new first name",
                      // hintText: data['firstName'].toString(),
                      // hintStyle: TextStyle(fontSize: 14.0)
                      // border: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.red),
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ),

                  // ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: FontSizes.textFormFieldFontSize
                        //  deviceWidth > 600
                        //     ? Fontsizes.tabletTextFormInputFieldSize
                        //     : Fontsizes.textFormInputFieldSize
                        ),
                    controller: _userActivitiesController.lastNameController,
                    keyboardType: TextInputType.name,
                    validator: ValidationHelper.nullOrEmptyString,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: FontSizes.errorFontSize,
                          //  deviceWidth > 600
                          //     ? Fontsizes.tabletErrorTextSize
                          //     : Fontsizes.errorTextSize,
                          color: Colors.red),
                      labelStyle: TextStyle(fontSize: 14.0
                          // deviceWidth > 600
                          //     ? Fontsizes.tabletTextFormInputFieldSize
                          //     : Fontsizes.textFormInputFieldSize
                          ),
                      labelText: "Enter new last name",
                      // hintText: data['lastName'].toString(),
                      // hintStyle: TextStyle(fontSize: 14.0)
                      // border: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.red),
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.red,
                    // color: Colors.black,
                    //fontSize: deviceWidth > 600 ? 25 : 17
                  ),
                )
                //  ),
                ),
            const SizedBox(
              width: 10.0,
            ),
            GestureDetector(
                onTap: () {
                  _userActivitiesController.updateProfile(document);
                },
                child: Obx(
                  () => ButtonWidget(
                    isLoading: _userActivitiesController.updatingProfile.value,
                    width: 100.0,
                    color: Get.theme.primaryColor,
                    text: "Update",
                    textColor: Colors.white,
                  ),
                )),
          ],
        );
      },
    ).then((value) {
      print("CLEARING FNAME LNAME");

      _userActivitiesController.firstNameController.clear();
      _userActivitiesController.lastNameController.clear();
    });
  }

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, DocumentSnapshot document) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          content: Text("Are you sure you want to delete this profile?",
              style: TextStyle(
                color: const Color(0xFF555770),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: -0.32,
              )),
          actions: [
            GestureDetector(
                onTap: () {
                  _userActivitiesController.deleteProfile(document);
                },
                child: Obx(
                  () => ButtonWidget(
                    isLoading: _userActivitiesController.deletingProfile.value,
                    width: 100.0,
                    color: Colors.red,
                    text: "Delete",
                    textColor: Colors.white,
                  ),
                )),
            const SizedBox(
              width: 10.0,
            ),
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Get.theme.primaryColor

                      // color: Colors.black,
                      //fontSize: deviceWidth > 600 ? 25 : 17
                      ),
                )
                //  ),
                ),
          ],
        );
      },
    );
  }

  CreateTaskController _createTaskController = Get.put(CreateTaskController());

  AssignTasksController _assignTasksController =
      Get.put(AssignTasksController());

  UpdateTaskController _updateTaskController = Get.put(UpdateTaskController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Assign tasks'),
          titleTextStyle: TextStyle(fontSize: 17.0, color: Colors.black),
          actions: [
            // GestureDetector(
            //   onTap: () {
            //     Get.to(() => CreateTask(
            //           forAdmin: false,
            //           forManager: true,
            //           forUsersProfile: true,
            //         ));
            //   },
            //   child: Container(
            //     alignment: Alignment.center,
            //     //  margin: EdgeInsets.only(right: 10),
            //     width: 80,
            //     height: 30,
            //     decoration: BoxDecoration(
            //       color: Get.theme.primaryColor,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Text(
            //       maxLines: 1,
            //       'Assign',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),

            IconButton(
                onPressed: () async {
                  await auth.signOut();
                  Get.to(() => LoginPage());
                },
                icon: Icon(Icons.logout_rounded))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   width: Get.width,
                //   child: Obx(
                //     () => Text(
                //       "${_userActivitiesController.companyName.value.toUpperCase()} company's employees activities",
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
                // Center(
                //   child: SizedBox(
                //     width: Get.width * 0.5,
                //     height: Get.height * 0.4,
                //     child: PieChart(
                //       PieChartData(
                //         sections: [
                //           PieChartSectionData(
                //             color: Colors.red,
                //             value: 40,
                //             radius: 40,
                //             title: '40% Inactive employees',
                //           ),
                //           PieChartSectionData(
                //             radius: 60,
                //             color: Colors.green,
                //             value: 60,
                //             title: '60% Active employees',
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

                // SizedBox(
                //   height: 50.0,
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       hintText: 'Search user',
                //       prefixIcon: Icon(
                //         Icons.search,
                //         size: 20.0,
                //       ),
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.grey),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),

                Text(
                  'Employees',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                // Obx(() {
                //   if (_userActivitiesController.fetchingCompanyName.value) {
                //     return SizedBox(
                //       width: Get.width,
                //       height: Get.height * 0.26,
                //       child: Center(
                //         child: CircularProgressIndicator(
                //           color: Get.theme.primaryColor,
                //         ),
                //       ),
                //     );
                //   } else {
                //     return
                StreamBuilder(
                  // future: _userActivitiesController
                  //     .getFutureManagersCollection(),
                  stream: _assignTasksController.getEmployeeCollection(),
                  builder: (context, snapshot) {
                    if (
                        //true
                        snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        width: Get.width,
                        height: Get.height * 0.26,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        print(
                            "snapshot.data!.docs.length ${snapshot.data!.docs.length}");

                        return
                            // SizedBox(
                            //   width: Get.width,
                            //   height: Get.height * 0.65,
                            //   child:
                            ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map(
                            (DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;

                              data.forEach((key, value) {
                                print("key: $key, value: $value");
                              });

                              return GestureDetector(
                                onTap: () {
                                  _updateTaskController.data.value = data;
                                  Get.to(() => TasksScreen(
                                        appTitle:
                                            "${data['firstName']} ${data['lastName']}'s tasks",
                                        username: data['username'].toString(),
                                        forManager: false,
                                        forAdmin: false,
                                        forUsersProfile: true,
                                      ));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                child: Text(data['firstName'][0]
                                                    .toString()
                                                    .toUpperCase()),
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                "${data['firstName']} ${data['lastName']}",
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _createTaskController
                                                      .data.value = data;

                                                  Get.to(() => CreateTask(
                                                        forAdmin: true,
                                                        // specificDocumentOfUser:
                                                        //     document,
                                                        forManager: false,
                                                        forUsersProfile: true,
                                                        appTitle: "Assign task",
                                                      ));
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  //width: 0,
                                                  //height: 30,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Get.theme.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    'Add task',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print("EDIT MANAGER");
                                                  showUpdateDialog(
                                                      context, document);
                                                },
                                                child: Icon(
                                                  Iconsax.edit_outline,
                                                  size: 20.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print("DELETE MANAGER");
                                                  // document.reference.delete();
                                                  // _userActivitiesController
                                                  //     .deleteManager(
                                                  //         document);
                                                  showDeleteConfirmationDialog(
                                                      context, document);
                                                },
                                                child: Icon(Icons
                                                    .delete_outline_outlined),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        );

                        // );
                      } else {
                        return Center(
                          child: Text(
                            'No data found',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: Text(
                          'Null data found',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                  },
                )

                //     ;
                //   }
                // }),
                // SizedBox(
                //   height: 10,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
