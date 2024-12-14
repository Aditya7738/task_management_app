import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:task_management_app/constants/fontsizes.dart';
import 'package:task_management_app/controller/add_employees_controller.dart';
import 'package:task_management_app/controller/validation_helper.dart';
import 'package:task_management_app/views/login_page.dart';
import 'package:task_management_app/widgets/button_widget.dart';

class AddEmployees extends StatelessWidget {
  AddEmployees({super.key});

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddEmployeesController _addEmployeesController =
      Get.put(AddEmployeesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.close_rounded,
              //color: Theme.of(context).primaryColor,
              size: 20.0,
            ),
          ),
          automaticallyImplyLeading: false,
          title: Text(
            "Add employee",
            style: TextStyle(fontSize: 17.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                  child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        style:
                            TextStyle(fontSize: FontSizes.textFormFieldFontSize
                                //  deviceWidth > 600
                                //     ? Fontsizes.tabletTextFormInputFieldSize
                                //     : Fontsizes.textFormInputFieldSize
                                ),
                        controller: _addEmployeesController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return ValidationHelper.isEmailValid(value);
                        },
                        // onChanged: (value) {
                        //   print("onChanged");
                        //   _addEmployeesController.companyNameController.text =
                        //       _addEmployeesController.guessCompanyName(value);
                        // },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: FontSizes.errorFontSize,
                              //  deviceWidth > 600
                              //     ? Fontsizes.tabletErrorTextSize
                              //     : Fontsizes.errorTextSize,
                              color: Colors.red),
                          labelStyle: TextStyle(fontSize: 14.0
                              // deviceWidth > 600
                              //     ? Fontsizes.tabletTextFormInputFieldSize
                              //     : Fontsizes.textFormInputFieldSize
                              ),
                          labelText: "Enter employee's work-email",
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width > 600
                                ? (Get.width / 2) - 45
                                : (Get.width / 2) - 35,
                            //  deviceWidth > 600
                            //     ? (deviceWidth / 2) - 45
                            //     : (deviceWidth / 2) - 35,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: FontSizes.textFormFieldFontSize
                                  //  deviceWidth > 600
                                  //     ? Fontsizes.tabletTextFormInputFieldSize
                                  //     : Fontsizes.textFormInputFieldSize
                                  ),
                              controller:
                                  _addEmployeesController.firstNameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                return ValidationHelper.nullOrEmptyString(
                                    value);
                              },
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    fontSize: FontSizes.errorFontSize,
                                    color: Colors.red),
                                labelStyle: TextStyle(
                                    fontSize: FontSizes.textFormFieldFontSize
                                    // deviceWidth > 600
                                    //     ? Fontsizes.tabletTextFormInputFieldSize
                                    //     : Fontsizes.textFormInputFieldSize
                                    ),
                                labelText: "First Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 28.0,
                          ),
                          SizedBox(
                            width: Get.width > 600
                                ? (Get.width / 2) - 45
                                : (Get.width / 2) - 35,
                            //  deviceWidth > 600
                            //     ? (deviceWidth / 2) - 45
                            //     : (deviceWidth / 2) - 35,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: FontSizes.textFormFieldFontSize
                                  //  deviceWidth > 600
                                  //     ? Fontsizes.tabletTextFormInputFieldSize
                                  //     : Fontsizes.textFormInputFieldSize
                                  ),
                              controller:
                                  _addEmployeesController.lastNameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                return ValidationHelper.nullOrEmptyString(
                                    value);
                              },
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    fontSize: FontSizes.errorFontSize,
                                    //  deviceWidth > 600
                                    //     ? Fontsizes.tabletErrorTextSize
                                    //     : Fontsizes.errorTextSize,
                                    color: Colors.red),
                                labelStyle: TextStyle(
                                  fontSize: FontSizes.textFormFieldFontSize,
                                  // deviceWidth > 600
                                  //     ? Fontsizes.tabletTextFormInputFieldSize
                                  //     : Fontsizes.textFormInputFieldSize
                                ),
                                labelText: "Last Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        style:
                            TextStyle(fontSize: FontSizes.textFormFieldFontSize
                                //  deviceWidth > 600
                                //     ? Fontsizes.tabletTextFormInputFieldSize
                                //     : Fontsizes.textFormInputFieldSize
                                ),
                        controller: _addEmployeesController.roleController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          return ValidationHelper.nullOrEmptyString(value);
                        },
                        // onChanged: (value) {
                        //   print("onChanged");
                        //   _addEmployeesController.companyNameController.text =
                        //       _addEmployeesController.guessCompanyName(value);
                        // },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: FontSizes.errorFontSize,
                              //  deviceWidth > 600
                              //     ? Fontsizes.tabletErrorTextSize
                              //     : Fontsizes.errorTextSize,
                              color: Colors.red),
                          labelStyle: TextStyle(fontSize: 14.0
                              // deviceWidth > 600
                              //     ? Fontsizes.tabletTextFormInputFieldSize
                              //     : Fontsizes.textFormInputFieldSize
                              ),
                          labelText: "Enter employee's role",
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          print(
                              "_formKey.currentState!.validate() ${_formKey.currentState!.validate()}");
                          if (_formKey.currentState!.validate()) {
                            //   _addEmployeesController.signupAdmin();
                          }
                        },
                        child: ButtonWidget(
                            isLoading:
                                _addEmployeesController.addingEmployee.value,
                            width: Get.width,
                            text: "Send invitation link",
                            textColor: Colors.white,
                            color: Get.theme.primaryColor),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "OR",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          print(
                              "_formKey.currentState!.validate() ${_formKey.currentState!.validate()}");
                          if (_formKey.currentState!.validate()) {
                            //   _addEmployeesController.signupAdmin();
                            _addEmployeesController.addEmployees();
                          }
                        },
                        child: Obx(
                          () => ButtonWidget(
                              isLoading:
                                  _addEmployeesController.addingEmployee.value,
                              width: Get.width,
                              text: "Add manually",
                              textColor: Colors.white,
                              color: Get.theme.primaryColor),
                        ),
                      ),
                    ]),
              ))),
        ));
  }
}
