import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_management_app/views/calendar_tasks.dart';
import 'package:task_management_app/widgets/task_list.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  List<Tab> tabs() => [
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Assigned',
                style: TextStyle(
                  //   color: Theme.of(context).primaryColor,
                  fontSize: 13,

                  //   letterSpacing: -0.28,
                ),
              ),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  //   color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Text(
                  '5',
                  style: TextStyle(
                    // color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'In progress',
                style: TextStyle(
                  //   color: Theme.of(context).primaryColor,
                  fontSize: 13,

                  //   letterSpacing: -0.28,
                ),
              ),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  //   color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Text(
                  '5',
                  style: TextStyle(
                    // color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Completed',
                style: TextStyle(
                  //   color: Theme.of(context).primaryColor,
                  fontSize: 13,

                  //   letterSpacing: -0.28,
                ),
              ),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  //   color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Text(
                  '5',
                  style: TextStyle(
                    // color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hold',
                style: TextStyle(
                  //   color: Theme.of(context).primaryColor,
                  fontSize: 13,

                  //   letterSpacing: -0.28,
                ),
              ),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  //   color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Text(
                  '5',
                  style: TextStyle(
                    // color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Dashboard Screen',
            style: TextStyle(fontSize: 16.0),
          ),
          actions: [
            InkWell(
                onTap: () {
                  Get.to(CalendarTasks());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Iconsax.calendar_add_outline),
                )),
          ],
          bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: tabs(),
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
          TaskList(),
          TaskList(),
          TaskList(),
          TaskList(),
        ],
      ),
    );
  }
}