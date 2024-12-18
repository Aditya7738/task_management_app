import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_app/controller/login_controller.dart';
import 'package:task_management_app/controller/user_activities_controller.dart';
import 'package:task_management_app/controller/user_task_details_controller.dart';
import 'package:task_management_app/views/add_employees.dart';
import 'package:task_management_app/views/create_task.dart';
import 'package:task_management_app/views/users_task_details.dart';
import 'package:task_management_app/views/login_page.dart';

class UsersActivities extends StatefulWidget {
  UsersActivities({super.key});

  @override
  State<UsersActivities> createState() => _UsersActivitiesState();
}

class _UsersActivitiesState extends State<UsersActivities> {
  FirebaseAuth auth = FirebaseAuth.instance;

  UserActivitiesController _userActivitiesController =
      Get.put(UserActivitiesController());

  LoginController _loginController = Get.put(LoginController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        "_loginController.emailController.value.text ${_loginController.emailController.value.text}");
    _userActivitiesController.getCompanyName();

    // _userActivitiesController.getManagersCollection();
    // _userActivitiesController.getEmployeeCollection();
  }

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
          title: Text('Users Activities'),
          titleTextStyle: TextStyle(fontSize: 17.0, color: Colors.black),
          actions: [
            GestureDetector(
              onTap: () {
                //Get.to(() => AddUsers());
                // showModalBottomSheet(
                //   constraints: BoxConstraints.expand(
                //       width: Get.width, height: Get.height),
                //   isScrollControlled: true,
                //   context: context,
                //   builder: (context) {
                //     return AddEmployees();
                //   },
                // );

                Get.to(() => AddEmployees());
              },
              child: Container(
                alignment: Alignment.center,
                //  margin: EdgeInsets.only(right: 10),
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  maxLines: 1,
                  'Add employee',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
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
                SizedBox(
                  width: Get.width,
                  child: Obx(
                    () => Text(
                      "${_userActivitiesController.companyName.value.toUpperCase()} company's employees activities",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: Get.width * 0.5,
                    height: Get.height * 0.4,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Colors.red,
                            value: 40,
                            radius: 40,
                            title: '40% Inactive employees',
                          ),
                          PieChartSectionData(
                            radius: 60,
                            color: Colors.green,
                            value: 60,
                            title: '60% Active employees',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search user',
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20.0,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Managers',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (_userActivitiesController.fetchingCompanyName.value) {
                    return SizedBox(
                      width: Get.width,
                      height: Get.height * 0.26,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    );
                  } else {
                    return StreamBuilder(
                      // future: _userActivitiesController
                      //     .getFutureManagersCollection(),
                      stream: _userActivitiesController.getManagersCollection(),
                      builder: (context, snapshot) {
                        if (
                            //true
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
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

                                  return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                  child: Text(data['firstName']
                                                          [0]
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
                                                    Get.to(() => CreateTask(
                                                          forAdmin: true,
                                                        ));
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    //width: 0,
                                                    //height: 30,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0,
                                                            vertical: 5.0),
                                                    decoration: BoxDecoration(
                                                      color: Get
                                                          .theme.primaryColor,
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
                                                  width: 10.0,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    print("EDIT MANAGER");
                                                  },
                                                  child: Icon(
                                                    Iconsax.edit_outline,
                                                    size: 20.0,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    print("DELETE MANAGER");
                                                  },
                                                  child: Icon(Icons
                                                      .delete_outline_outlined),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.end,
                                        //   children: [
                                        //     InkWell(
                                        //         onTap: () {
                                        //           Get.to(
                                        //               () => UsersTaskDetails());
                                        //         },
                                        //         child: Text(
                                        //           'View task activity',
                                        //           style: TextStyle(
                                        //               fontWeight:
                                        //                   FontWeight.bold,
                                        //               color: Get
                                        //                   .theme.primaryColor),
                                        //         )),
                                        //     SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
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
                    );

                    // return StreamBuilder(
                    //   stream: _userActivitiesController.getManagersCollection(),
                    //   builder: (context, snapshot) {
                    //     if (
                    //         //true
                    //         snapshot.connectionState ==
                    //             ConnectionState.waiting) {
                    //       return SizedBox(
                    //         width: Get.width,
                    //         height: Get.height * 0.26,
                    //         child: Center(
                    //           child: CircularProgressIndicator(
                    //             color: Get.theme.primaryColor,
                    //           ),
                    //         ),
                    //       );
                    //     } else if (snapshot.hasError) {
                    //       return Center(
                    //         child: Text(
                    //           'Error: ${snapshot.error}',
                    //           style: TextStyle(color: Colors.red),
                    //         ),
                    //       );
                    //     } else if (snapshot.hasData) {
                    //       return Container(
                    //           color: Colors.amber,
                    //           width: Get.width,
                    //           height: Get.height * 0.65,
                    //           child: snapshot.data == null
                    //               ? Center(
                    //                   child: Text(
                    //                     'No data found',
                    //                     style: TextStyle(
                    //                         color: Get.theme.primaryColor),
                    //                   ),
                    //                 )
                    //               : Container(
                    //                   color: Colors.red,
                    //                   width: Get.width,
                    //                   height: Get.height * 0.65,
                    //                   child: ListView(
                    //                     children: snapshot.data!.docs.map(
                    //                       (DocumentSnapshot document) {
                    //                         Map<String, dynamic> data =
                    //                             document.data()!
                    //                                 as Map<String, dynamic>;

                    //                         data.forEach((key, value) {
                    //                           print("key: $key, value: $value");
                    //                         });

                    //                         return Container(
                    //                           margin:
                    //                               EdgeInsets.only(bottom: 10),
                    //                           padding: EdgeInsets.all(10),
                    //                           decoration: BoxDecoration(
                    //                             border: Border.all(
                    //                                 color: Colors.grey),
                    //                             borderRadius:
                    //                                 BorderRadius.circular(10),
                    //                           ),
                    //                           child: Column(
                    //                             mainAxisAlignment:
                    //                                 MainAxisAlignment.start,
                    //                             crossAxisAlignment:
                    //                                 CrossAxisAlignment.start,
                    //                             children: [
                    //                               Row(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment
                    //                                         .spaceBetween,
                    //                                 children: [
                    //                                   Row(
                    //                                     mainAxisAlignment:
                    //                                         MainAxisAlignment
                    //                                             .start,
                    //                                     children: [
                    //                                       CircleAvatar(
                    //                                         child: Text('A'),
                    //                                       ),
                    //                                       SizedBox(
                    //                                         width: 5.0,
                    //                                       ),
                    //                                       Text(
                    //                                         "${data['fistName']} ${data['lastName']}",
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       Icon(
                    //                                         Iconsax
                    //                                             .edit_outline,
                    //                                         size: 20.0,
                    //                                       ),
                    //                                       SizedBox(
                    //                                         width: 5.0,
                    //                                       ),
                    //                                       Icon(Icons
                    //                                           .delete_outline_outlined),
                    //                                     ],
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               SizedBox(
                    //                                 height: 10,
                    //                               ),
                    //                               Row(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment.end,
                    //                                 children: [
                    //                                   InkWell(
                    //                                       onTap: () {
                    //                                         Get.to(() =>
                    //                                             UsersTaskDetails());
                    //                                       },
                    //                                       child: Text(
                    //                                         'View task activity',
                    //                                         style: TextStyle(
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             color: Get.theme
                    //                                                 .primaryColor),
                    //                                       )),
                    //                                   SizedBox(
                    //                                     width: 10,
                    //                                   ),
                    //                                   Container(
                    //                                     alignment:
                    //                                         Alignment.center,
                    //                                     width: 100,
                    //                                     height: 30,
                    //                                     decoration:
                    //                                         BoxDecoration(
                    //                                       color: Get.theme
                    //                                           .primaryColor,
                    //                                       borderRadius:
                    //                                           BorderRadius
                    //                                               .circular(10),
                    //                                     ),
                    //                                     child: Text(
                    //                                       'Add task',
                    //                                       style: TextStyle(
                    //                                           color:
                    //                                               Colors.white),
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         );
                    //                       },
                    //                     ).toList(),
                    //                   ),
                    //                 ));
                    //     } else {
                    //       return Center(
                    //         child: Text(
                    //           'No data found',
                    //           style: TextStyle(color: Colors.red),
                    //         ),
                    //       );
                    //     }
                    //   },
                    // );
                  }
                }),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Employees',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (_userActivitiesController.fetchingCompanyName.value) {
                    return SizedBox(
                      width: Get.width,
                      height: Get.height * 0.26,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    );
                  } else {
                    return FutureBuilder(
                      future: _userActivitiesController
                          .getFutureEmployeesCollection(),
                      builder: (context, snapshot) {
                        if (
                            //true
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
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

                                  return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                  child: Text(data['firstName']
                                                          [0]
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
                                                Icon(
                                                  Iconsax.edit_outline,
                                                  size: 20.0,
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Icon(Icons
                                                    .delete_outline_outlined),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      () => UsersTaskDetails());
                                                },
                                                child: Text(
                                                  'View task activity',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Get
                                                          .theme.primaryColor),
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Get.theme.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                'Add task',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
                    );

                    // return StreamBuilder(
                    //   stream: _userActivitiesController.getManagersCollection(),
                    //   builder: (context, snapshot) {
                    //     if (
                    //         //true
                    //         snapshot.connectionState ==
                    //             ConnectionState.waiting) {
                    //       return SizedBox(
                    //         width: Get.width,
                    //         height: Get.height * 0.26,
                    //         child: Center(
                    //           child: CircularProgressIndicator(
                    //             color: Get.theme.primaryColor,
                    //           ),
                    //         ),
                    //       );
                    //     } else if (snapshot.hasError) {
                    //       return Center(
                    //         child: Text(
                    //           'Error: ${snapshot.error}',
                    //           style: TextStyle(color: Colors.red),
                    //         ),
                    //       );
                    //     } else if (snapshot.hasData) {
                    //       return Container(
                    //           color: Colors.amber,
                    //           width: Get.width,
                    //           height: Get.height * 0.65,
                    //           child: snapshot.data == null
                    //               ? Center(
                    //                   child: Text(
                    //                     'No data found',
                    //                     style: TextStyle(
                    //                         color: Get.theme.primaryColor),
                    //                   ),
                    //                 )
                    //               : Container(
                    //                   color: Colors.red,
                    //                   width: Get.width,
                    //                   height: Get.height * 0.65,
                    //                   child: ListView(
                    //                     children: snapshot.data!.docs.map(
                    //                       (DocumentSnapshot document) {
                    //                         Map<String, dynamic> data =
                    //                             document.data()!
                    //                                 as Map<String, dynamic>;

                    //                         data.forEach((key, value) {
                    //                           print("key: $key, value: $value");
                    //                         });

                    //                         return Container(
                    //                           margin:
                    //                               EdgeInsets.only(bottom: 10),
                    //                           padding: EdgeInsets.all(10),
                    //                           decoration: BoxDecoration(
                    //                             border: Border.all(
                    //                                 color: Colors.grey),
                    //                             borderRadius:
                    //                                 BorderRadius.circular(10),
                    //                           ),
                    //                           child: Column(
                    //                             mainAxisAlignment:
                    //                                 MainAxisAlignment.start,
                    //                             crossAxisAlignment:
                    //                                 CrossAxisAlignment.start,
                    //                             children: [
                    //                               Row(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment
                    //                                         .spaceBetween,
                    //                                 children: [
                    //                                   Row(
                    //                                     mainAxisAlignment:
                    //                                         MainAxisAlignment
                    //                                             .start,
                    //                                     children: [
                    //                                       CircleAvatar(
                    //                                         child: Text('A'),
                    //                                       ),
                    //                                       SizedBox(
                    //                                         width: 5.0,
                    //                                       ),
                    //                                       Text(
                    //                                         "${data['fistName']} ${data['lastName']}",
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       Icon(
                    //                                         Iconsax
                    //                                             .edit_outline,
                    //                                         size: 20.0,
                    //                                       ),
                    //                                       SizedBox(
                    //                                         width: 5.0,
                    //                                       ),
                    //                                       Icon(Icons
                    //                                           .delete_outline_outlined),
                    //                                     ],
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               SizedBox(
                    //                                 height: 10,
                    //                               ),
                    //                               Row(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment.end,
                    //                                 children: [
                    //                                   InkWell(
                    //                                       onTap: () {
                    //                                         Get.to(() =>
                    //                                             UsersTaskDetails());
                    //                                       },
                    //                                       child: Text(
                    //                                         'View task activity',
                    //                                         style: TextStyle(
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .bold,
                    //                                             color: Get.theme
                    //                                                 .primaryColor),
                    //                                       )),
                    //                                   SizedBox(
                    //                                     width: 10,
                    //                                   ),
                    //                                   Container(
                    //                                     alignment:
                    //                                         Alignment.center,
                    //                                     width: 100,
                    //                                     height: 30,
                    //                                     decoration:
                    //                                         BoxDecoration(
                    //                                       color: Get.theme
                    //                                           .primaryColor,
                    //                                       borderRadius:
                    //                                           BorderRadius
                    //                                               .circular(10),
                    //                                     ),
                    //                                     child: Text(
                    //                                       'Add task',
                    //                                       style: TextStyle(
                    //                                           color:
                    //                                               Colors.white),
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         );
                    //                       },
                    //                     ).toList(),
                    //                   ),
                    //                 ));
                    //     } else {
                    //       return Center(
                    //         child: Text(
                    //           'No data found',
                    //           style: TextStyle(color: Colors.red),
                    //         ),
                    //       );
                    //     }
                    //   },
                    // );
                  }
                }),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
