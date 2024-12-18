import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_management_app/controller/user_activities_controller.dart';
import 'package:task_management_app/views/create_task.dart';

class ListOfUser extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>>? stream;
  ListOfUser({super.key, this.stream});

  UserActivitiesController _userActivitiesController =
      Get.put(UserActivitiesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
          stream: stream,
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

                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                        Get.to(() => CreateTask(
                                              forAdmin: true,
                                            ));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        //width: 0,
                                        //height: 30,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        decoration: BoxDecoration(
                                          color: Get.theme.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          'Add task',
                                          style: TextStyle(color: Colors.white),
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
                                      child:
                                          Icon(Icons.delete_outline_outlined),
                                    ),
                                  ],
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
      }
    });
  }
}
