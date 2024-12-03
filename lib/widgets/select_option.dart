import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/controller/create_task_controller.dart';

class SelectOption extends StatelessWidget {
  final Widget icon;
  final String title;
  final List<DropdownMenuItem<String>> items;
  Function(String?)? onChanged;
  String? value;
  SelectOption(
      {super.key,
      required this.icon,
      required this.title,
      required this.items,
      required this.onChanged,
      required this.value});

  CreateTaskController createTaskController = Get.put(CreateTaskController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(margin: EdgeInsets.only(left: 11.0), child: Text(title)),
            // Row(
            //   children: [
            //     Text(
            //       "Unassigned",
            //       style: TextStyle(
            //           fontSize: 15.0, fontWeight: FontWeight.bold),
            //     ),
            //     Icon(Icons.arrow_drop_down_rounded)
            //   ],
            // ),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                value: value,
                icon: Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.arrow_drop_down_rounded)),
                items: items,
                onChanged: onChanged,
              ),
            )
          ],
        )
      ],
    );
  }
}
