import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/controller/user_task_details_controller.dart';
import 'package:task_management_app/widgets/leading_back_arrow.dart';
import 'package:task_management_app/widgets/task_list.dart';

class UsersTaskDetails extends StatefulWidget {
  const UsersTaskDetails({super.key});

  @override
  State<UsersTaskDetails> createState() => _UsersTaskDetailsState();
}

class _BarData {
  const _BarData(this.color, this.value, this.barLabel);
  final Color color;
  final double value;
  final String barLabel;
}

class _UsersTaskDetailsState extends State<UsersTaskDetails>
    with SingleTickerProviderStateMixin {
  List<_BarData> dataList = <_BarData>[];

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    dataList = [
      const _BarData(Colors.blue, 18, "Assigned"),
      const _BarData(Colors.green, 2.5, "Completed"),
      const _BarData(Colors.orange, 17, "In Progress"),
      const _BarData(Colors.red, 10, "On Hold"),

      // const _BarData(Colors.blue, 2, ""),
      // const _BarData(Colors.red, 2, 2),
    ];
  }

  List<String> tabNames = ["Assigned", "Completed", "In progress", "On hold"];

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
          userTaskDetailsController.touchedGroupIndex.value == x ? [0] : [],
    );
  }

  UserTaskDetailsController userTaskDetailsController =
      Get.put(UserTaskDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingBackArrow(),
        title: Text('User Task Details'),
        titleTextStyle: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.87,
                height: Get.height * 0.4,
                child: Obx(
                  () => BarChart(
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
                            userTaskDetailsController.touchedGroupIndex.value =
                                response.spot!.touchedBarGroupIndex;
                          } else {
                            // setState(() {
                            //   touchedGroupIndex = -1;
                            // });
                            userTaskDetailsController.touchedGroupIndex.value =
                                -1;
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10.0,
              // ),
              Container(
                //  color: Colors.red,
                width: Get.width,
                height: 50,
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  controller: _tabController,
                  tabs: tabs(),
                  onTap: (index) {
                    // print(index);
                    // taskScreenController.selectedTask.value = tabNames[index];
                  },
                ),
              ),
              SizedBox(
                width: Get.width,
                height: Get.height * 0.78,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TaskList(
                      username: "",
                      forManager: false,
                    ),
                    TaskList(
                      username: "",
                      forManager: false,
                    ),
                    TaskList(
                      username: "",
                      forManager: false,
                    ),
                    TaskList(
                      username: "",
                      forManager: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
