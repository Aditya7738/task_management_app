import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_management_app/constants/database_references.dart';
import 'package:task_management_app/controller/task_screen_controller.dart';
import 'package:task_management_app/views/board_screen.dart';
import 'package:task_management_app/views/calendar_tasks.dart';
import 'package:task_management_app/views/login_page.dart';
import 'package:task_management_app/widgets/task_list.dart';

class TasksScreen extends StatefulWidget {
  final String? appTitle;
  final String username;
  final bool forManager;
  final bool forAdmin;
  final bool forUsersProfile;
  TasksScreen(
      {super.key,
      this.appTitle,
      required this.username,
      required this.forManager,
      required this.forAdmin,
      required this.forUsersProfile});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  TaskScreenController taskScreenController = Get.put(TaskScreenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // String collectionReference = widget.forManager
    //     ? DatabaseReferences.MANAGERS_COLLECTION_REFERENCE
    //     : DatabaseReferences.EMPLOYEES_COLLECTION_REFERENCE;

    //  taskScreenController.getMap(collectionReference, widget.username);
  }

  List<String> tabNames = [
    "Assigned",
    "In progress",
    "On hold",
    "Completed",
  ];

  List<Tab> tabs() {
    List<Tab> tabs = [];
    for (var tabName in tabNames) {
      tabs.add(
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tabName,
                style: TextStyle(
                  //   color: Theme.of(context).primaryColor,
                  fontSize: 13,

                  //   letterSpacing: -0.28,
                ),
              ),
              // SizedBox(width: 5),
              // Container(
              //   padding: EdgeInsets.all(5),
              //   decoration: BoxDecoration(
              //     //   color: Colors.green,
              //     shape: BoxShape.circle,
              //     border: Border.all(
              //       color: Colors.grey,
              //     ),
              //   ),
              //   child: Text(
              //     '5',
              //     style: TextStyle(
              //       // color: Colors.black,
              //       fontSize: 10,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );

      // Tab(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         'In progress',
      //         style: TextStyle(
      //           //   color: Theme.of(context).primaryColor,
      //           fontSize: 13,

      //           //   letterSpacing: -0.28,
      //         ),
      //       ),
      //       SizedBox(width: 5),
      //       Container(
      //         padding: EdgeInsets.all(5),
      //         decoration: BoxDecoration(
      //           //   color: Colors.green,
      //           shape: BoxShape.circle,
      //           border: Border.all(
      //             color: Colors.grey,
      //           ),
      //         ),
      //         child: Text(
      //           '5',
      //           style: TextStyle(
      //             // color: Colors.black,
      //             fontSize: 10,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // Tab(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Completed',
      //         style: TextStyle(
      //           //   color: Theme.of(context).primaryColor,
      //           fontSize: 13,

      //           //   letterSpacing: -0.28,
      //         ),
      //       ),
      //       SizedBox(width: 5),
      //       Container(
      //         padding: EdgeInsets.all(5),
      //         decoration: BoxDecoration(
      //           //   color: Colors.green,
      //           shape: BoxShape.circle,
      //           border: Border.all(
      //             color: Colors.grey,
      //           ),
      //         ),
      //         child: Text(
      //           '5',
      //           style: TextStyle(
      //             // color: Colors.black,
      //             fontSize: 10,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // Tab(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Hold',
      //         style: TextStyle(
      //           //   color: Theme.of(context).primaryColor,
      //           fontSize: 13,

      //           //   letterSpacing: -0.28,
      //         ),
      //       ),
      //       SizedBox(width: 5),
      //       Container(
      //         padding: EdgeInsets.all(5),
      //         decoration: BoxDecoration(
      //           //   color: Colors.green,
      //           shape: BoxShape.circle,
      //           border: Border.all(
      //             color: Colors.grey,
      //           ),
      //         ),
      //         child: Text(
      //           '5',
      //           style: TextStyle(
      //             // color: Colors.black,
      //             fontSize: 10,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // )
    }
    return tabs;
  }

  //TaskScreenController taskScreenController = Get.put(TaskScreenController());
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //Get.to(BoardScreen());
        return widget.appTitle == null ? false : true;
      },
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              widget.appTitle ?? "Task manager",
              style: TextStyle(fontSize: 16.0),
            ),
            actions: [
              // InkWell(
              //     onTap: () {
              //       Get.to(BoardScreen());
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.only(right: 10.0),
              //       child: Icon(Iconsax.task_outline),
              //     )),
              // InkWell(
              //     onTap: () {
              //       Get.to(CalendarTasks());
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.only(right: 8.0),
              //       child: Icon(Iconsax.calendar_add_outline),
              //     )),

              widget.forUsersProfile
                  ? IconButton(
                      onPressed: () async {
                        await auth.signOut();
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Get.to(() => LoginPage());
                        });
                      },
                      icon: Icon(Icons.logout_rounded))
                  : SizedBox()
            ],
            bottom: TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              controller: _tabController,
              tabs: tabs(),
              onTap: (index) {
                // print(index);
                taskScreenController.selectedTaskTab.value = tabNames[index];
              },
            )
            //  ButtonsTabBar(
            //   //  borderColor: Colors.grey,

            //   decoration: BoxDecoration(
            //     color: const Color.fromARGB(255, 17, 35, 230),
            //     borderRadius: BorderRadius.circular(23),
            //     // border: Border.all(
            //     //   color: Colors.grey,
            //     // ),
            //   ),
            //   //  unselectedBorderColor: Colors.grey,
            //   unselectedDecoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(23),
            //     // border: Border.all(
            //     //   color: Colors.grey,
            //     // ),
            //   ),
            //   labelStyle:
            //       TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //   //  backgroundColor: const Color.fromARGB(255, 17, 35, 230),
            //   // unselectedBackgroundColor: Colors.white,
            //   tabs: tabs(),
            //   controller: _tabController,
            //   // indicator: BoxDecoration(
            //   //   // borderRadius: BorderRadius.circular(2.0),
            //   //   color: const Color.fromARGB(255, 17, 35, 230),
            //   // ),
            // ),

            ),
        body: TabBarView(
          controller: _tabController,
          children: [
            TaskList(
              username: widget.username,
              forManager: widget.forManager,
              appTitle: widget.appTitle,
              typeOfTasks: "Assigned",
              forAdmin: widget.forAdmin,
              forUsersProfile: widget.forUsersProfile,
            ),
            TaskList(
              username: widget.username,
              forManager: widget.forManager,
              appTitle: widget.appTitle,
              typeOfTasks: "In progress",
              forAdmin: widget.forAdmin,
              forUsersProfile: widget.forUsersProfile,
            ),
            TaskList(
              username: widget.username,
              forManager: widget.forManager,
              appTitle: widget.appTitle,
              typeOfTasks: "Hold",
              forAdmin: widget.forAdmin,
              forUsersProfile: widget.forUsersProfile,
            ),
            TaskList(
              username: widget.username,
              forManager: widget.forManager,
              appTitle: widget.appTitle,
              typeOfTasks: "Completed",
              forAdmin: widget.forAdmin,
              forUsersProfile: widget.forUsersProfile,
            ),
          ],
        ),
      ),
    );
  }
}
