import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadingBackArrow extends StatelessWidget {
  const LeadingBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Icon(
        Icons.arrow_back,
        // color: Theme.of(context).primaryColor,
        size: 19.0,
      ),
    );
  }
}
