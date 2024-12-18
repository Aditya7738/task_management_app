import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordDialog extends StatelessWidget {
  const ResetPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.5,
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "Reset Password",
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "Enter your email address to reset your password",
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 5.0,
          ),
          CupertinoTextField(
            placeholder: "Email",
          ),
          SizedBox(
            height: 10.0,
          ),
          CupertinoButton(
            child: Text("Reset Password"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
