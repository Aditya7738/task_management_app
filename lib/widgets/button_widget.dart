import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonWidget extends StatelessWidget {
  bool isLoading = false;
  double width;
  BoxBorder? border;
  Color? color;
  Color? textColor;
  String text;
  ButtonWidget(
      {super.key,
      required this.isLoading,
      required this.width,
      required this.color,
      required this.text,
      required this.textColor,
      this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        //  MediaQuery.of(context).size.width > 600
        //     ? 600.sp
        //     : MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: border,
            color: color,
            borderRadius: BorderRadius.circular(15.0)),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Center(
          child: isLoading
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  width: (Get.width / 28) + 4,
                  height: (Get.width / 28) + 13,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.0,
                    backgroundColor: Color(0xffCC868A),
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    // deviceWidth > 600
                    //     ? Fontsizes.tabletButtonTextSize
                    //     : Fontsizes.buttonTextSize
                  ),
                ),
        ));
  }
}
