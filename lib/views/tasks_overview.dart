import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_management_app/controller/tasks_overview_controller.dart';
import 'package:task_management_app/views/create_task.dart';
import 'package:task_management_app/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_app/widgets/admins_task_list.dart';
import 'package:task_management_app/widgets/task_list.dart';

class TasksOverview extends StatefulWidget {
  TasksOverview({super.key});

  @override
  State<TasksOverview> createState() => _TasksOverviewState();
}

class _TasksOverviewState extends State<TasksOverview>
    with SingleTickerProviderStateMixin {
  List<_BarData> dataList = <_BarData>[];
  FirebaseAuth auth = FirebaseAuth.instance;
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tasksOverviewController.getAllTasks();
    _tabController = TabController(length: 4, vsync: this);
  }

  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
    // double shadowValue,
    String barLabel,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
        // BarChartRodData(
        //   toY: shadowValue,
        //   color: widget.shadowColor,
        //   width: 6,
        // ),
      ],
      showingTooltipIndicators:
          tasksOverviewController.touchedGroupIndex.value == x ? [0] : [],
    );
  }

  TasksOverviewController tasksOverviewController =
      Get.put(TasksOverviewController());

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
    }
    return tabs;
  }

  setDataList() {
    dataList = [
      _BarData(
          Colors.blue,
          tasksOverviewController.assignTaskListLength.value.toDouble(),
          "Assigned"),

      _BarData(
          Colors.orange,
          tasksOverviewController.inProgressTaskListLength.value.toDouble(),
          "In Progress"),
      _BarData(
          Colors.red,
          tasksOverviewController.onHoldTaskListLength.value.toDouble(),
          "On Hold"),
      _BarData(
          Colors.green,
          tasksOverviewController.completedTaskListLength.value.toDouble(),
          "Completed"),

      // const _BarData(Colors.blue, 2, ""),
      // const _BarData(Colors.red, 2, 2),
    ];
  }

  @override
  Widget build(Object context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 45.0,
          title: Text('Tasks Overview'),
          titleTextStyle: TextStyle(fontSize: 16.0, color: Colors.black),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => CreateTask(
                    forAdmin: false,
                    forManager: true,
                    forUsersProfile: false,
                    appTitle: "Create New Task"));
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10),
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Add task',
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
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * 0.85,
                  height: Get.height * 0.4,
                  child: Obx(() {
                    if (tasksOverviewController.fetchingAllTasks.value) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Get.theme.primaryColor,
                        ),
                      );
                    } else {
                      setDataList();

                      return BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceBetween,
                          borderData: FlBorderData(
                            show: true,
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            leftTitles: AxisTitles(
                              //    axisNameWidget: Text("No of tasks"),
                              drawBelowEverything: true,
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 36,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    textAlign: TextAlign.left,
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              //   axisNameWidget: Text("Tasks categories"),
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 36,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child:
                                          //  _IconWidget(
                                          //   color: widget.dataList[index].color,
                                          //   isSelected: touchedGroupIndex == index,
                                          // ),
                                          Text(dataList[index].barLabel));
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(),
                            topTitles: const AxisTitles(),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: Colors.grey.withOpacity(0.2),
                              strokeWidth: 1,
                            ),
                          ),
                          barGroups: dataList.asMap().entries.map((e) {
                            final index = e.key;
                            final data = e.value;
                            return generateBarGroup(
                              index,
                              data.color,
                              data.value,
                              //  data.shadowValue,
                              data.barLabel,
                            );
                          }).toList(),
                          maxY: 20,
                          barTouchData: BarTouchData(
                            enabled: true,
                            handleBuiltInTouches: false,
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipColor: (group) => Colors.transparent,
                              tooltipMargin: 0,
                              getTooltipItem: (
                                BarChartGroupData group,
                                int groupIndex,
                                BarChartRodData rod,
                                int rodIndex,
                              ) {
                                return BarTooltipItem(
                                  rod.toY.toString(),
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: rod.color,
                                    fontSize: 18,
                                    shadows: const [
                                      Shadow(
                                        color: Colors.black26,
                                        blurRadius: 12,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            touchCallback: (event, response) {
                              if (event.isInterestedForInteractions &&
                                  response != null &&
                                  response.spot != null) {
                                // setState(() {
                                //   touchedGroupIndex =
                                //       response.spot!.touchedBarGroupIndex;
                                // });
                                tasksOverviewController
                                        .touchedGroupIndex.value =
                                    response.spot!.touchedBarGroupIndex;
                              } else {
                                // setState(() {
                                //   touchedGroupIndex = -1;
                                // });
                                tasksOverviewController
                                    .touchedGroupIndex.value = -1;
                              }
                            },
                          ),
                        ),
                      );
                    }
                  }),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  controller: _tabController,
                  tabs: tabs(),
                  onTap: (index) {
                    // print(index);
                    //    taskScreenController.selectedTaskTab.value = tabNames[index];
                  },
                ),
                SizedBox(
                  width: Get.width,
                  height: Get.height * 0.65,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      AdminsTaskList(
                        typeOfTasks: "Assigned",
                      ),
                      AdminsTaskList(
                        typeOfTasks: "In progress",
                      ),
                      AdminsTaskList(
                        typeOfTasks: "Hold",
                      ),
                      AdminsTaskList(
                        typeOfTasks: "Completed",
                      ),
                    ],
                  ),
                ),

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value, this.barLabel);
  final Color color;
  final double value;
  final String barLabel;
}
