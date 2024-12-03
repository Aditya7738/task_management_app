import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_management_app/controller/create_task_controller.dart';
import 'package:task_management_app/views/create_task.dart';

class CalendarTasks extends StatefulWidget {
  @override
  _CalendarTasksState createState() => _CalendarTasksState();
}

class _CalendarTasksState extends State<CalendarTasks>
    with SingleTickerProviderStateMixin {
  final CreateTaskController createTaskController =
      Get.put(CreateTaskController());

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  List<Tab> tabs = [
    Tab(
      child: Container(
        child: const Text(
          'Month',
          style: TextStyle(
            //   color: Theme.of(context).primaryColor,
            fontSize: 13,

            letterSpacing: -0.28,
          ),
        ),
      ),
    ),
    Tab(
      child: Container(
        child: const Text(
          'Week',
          style: TextStyle(
            //   color: Theme.of(context).primaryColor,
            fontSize: 13,

            letterSpacing: -0.28,
          ),
        ),
      ),
    ),
    Tab(
      child: Container(
        child: const Text(
          'Day',
          style: TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    ),
  ];

  List<Widget> tabBody() => [
        Obx(
          () => SfCalendar(
            view: CalendarView.month,
            dataSource: TaskDataSource(createTaskController.appointments.value),
          ),
        ),
        Obx(
          () => SfCalendar(
            view: CalendarView.week,
            dataSource: TaskDataSource(createTaskController.appointments.value),
          ),
        ),
        Obx(
          () => SfCalendar(
            view: CalendarView.day,
            dataSource: TaskDataSource(createTaskController.appointments.value),
          ),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40.0,
          backgroundColor: Colors.white,
          // title: Text(
          //   'Calendar Tasks',
          //   style: TextStyle(fontSize: 16.0),
          // ),
          actions: [
            InkWell(
                onTap: () {
                  Get.to(CreateTask());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.add),
                ))
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: Container(
              color: Colors.white,
              height: kToolbarHeight - 18.0,
              // decoration: BoxDecoration(
              //     border: Border.all(
              //         color: const Color.fromARGB(255, 218, 218, 218)),
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(3.0)),
              child: TabBar(
                tabs: tabs,
                controller: _tabController,
                labelColor: Colors.white,
                indicatorColor: const Color.fromARGB(255, 17, 35, 230),
                //unselectedLabelColor: Colors.black,
                unselectedLabelStyle: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
                indicator: BoxDecoration(
                  // borderRadius: BorderRadius.circular(2.0),
                  color: const Color.fromARGB(255, 17, 35, 230),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
          ),
        ),
        body: SizedBox(
          width: Get.width,
          height: Get.height - (kToolbarHeight + 58.0),
          child: TabBarView(
            controller: _tabController,
            children: tabBody(),
          ),
        ));
  }
}
