import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:task_management_app/constants/fontsizes.dart';
import 'package:task_management_app/controller/add_employees_controller.dart';
import 'package:task_management_app/controller/validation_helper.dart';
import 'package:task_management_app/views/login_page.dart';
import 'package:task_management_app/widgets/button_widget.dart';

class AddEmployees extends StatefulWidget {
  AddEmployees({super.key});

  @override
  State<AddEmployees> createState() => _AddEmployeesState();
}

class _AddEmployeesState extends State<AddEmployees> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddEmployeesController _addEmployeesController =
      Get.put(AddEmployeesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addEmployeesController.usernameController.clear();
    _addEmployeesController.firstNameController.clear();
    _addEmployeesController.lastNameController.clear();
    // _addEmployeesController.roleController.clear();
  }

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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Obx(
                      //   () =>
                      TextFormField(
                        //  autofocus: _addEmployeesController.autofocuskb1.value,
                        style:
                            TextStyle(fontSize: FontSizes.textFormFieldFontSize
                                //  deviceWidth > 600
                                //     ? Fontsizes.tabletTextFormInputFieldSize
                                //     : Fontsizes.textFormInputFieldSize
                                ),
                        controller: _addEmployeesController.usernameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          //  return ValidationHelper.isEmailValid(value);
                          return ValidationHelper.nullOrEmptyString(value);
                        },
                        // onEditingComplete: () {
                        //   _addEmployeesController.autofocuskb1.value = false;
                        //   _addEmployeesController.autofocuskb2.value = true;
                        // },
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
                          labelText: "Enter employee's username",
                        ),
                      ),
                      //),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Role",
                              style: TextStyle(
                                fontSize: 16,
                                // fontFamily: 'Inter',
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 1.0),
                                    ),
                                    child:
                                        // GetBuilder<_addEmployeesController>(
                                        //   builder: (controller) {
                                        //     return
                                        Obx(
                                      () => RadioMenuButton(
                                          toggleable: true,
                                          value: "Manager",
                                          groupValue: _addEmployeesController
                                              .role.value,
                                          onChanged: (value) {
                                            _addEmployeesController.role.value =
                                                value.toString();
                                          },
                                          style: ButtonStyle(
                                              iconColor:
                                                  WidgetStateProperty.all(
                                                      Theme.of(context)
                                                          .primaryColor)),
                                          child: Text(
                                            "Manager",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: _addEmployeesController
                                                            .role.value ==
                                                        "Manager"
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors.black),
                                          )),
                                    )
                                    //         ;
                                    //   },
                                    // ),
                                    ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Container(
                                    // decoration: ShapeDecoration(
                                    //   color: Colors.white,
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(9),
                                    //   ),
                                    //   shadows: const [
                                    //     BoxShadow(
                                    //       color: Color(0x66000000),
                                    //       blurRadius: 1,
                                    //       offset: Offset(0, 0),
                                    //       spreadRadius: 0,
                                    //     )
                                    //   ],
                                    // ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 1.0),
                                    ),
                                    child:
                                        // GetBuilder<AddEmployeesController>(
                                        //   builder: (controller) {
                                        //     return
                                        Obx(
                                      () => RadioMenuButton(
                                          toggleable: true,
                                          value: "Employee",
                                          groupValue: _addEmployeesController
                                              .role.value,
                                          onChanged: (value) {
                                            _addEmployeesController.role.value =
                                                value.toString();
                                          },
                                          style: ButtonStyle(
                                              iconColor:
                                                  WidgetStateProperty.all(
                                                      Theme.of(context)
                                                          .primaryColor)),
                                          child: Text(
                                            "Employee",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: _addEmployeesController
                                                            .role.value ==
                                                        "Employee"
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors.black),
                                          )),
                                    )
                                    //       ;
                                    // },
                                    ),
                              ])
                        ],
                      ),

                      //   ],
                      // ),

                      const SizedBox(
                        height: 30.0,
                      ),
                      Obx(
                        () => TextFormField(
                          style: TextStyle(
                              fontSize: FontSizes.textFormFieldFontSize
                              //  deviceWidth > 600
                              //     ? Fontsizes.tabletTextFormInputFieldSize
                              //     : Fontsizes.textFormInputFieldSize
                              ),
                          controller:
                              _addEmployeesController.passwordController,
                          obscureText:
                              _addEmployeesController.isPasswordInvisible.value,
                          keyboardType: TextInputType.visiblePassword,
                          validator: ValidationHelper.isPasswordContain,
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            errorStyle: TextStyle(
                                fontSize: FontSizes.errorFontSize,

                                //  deviceWidth > 600
                                //     ? Fontsizes.tabletErrorTextSize
                                //     : Fontsizes.errorTextSize,
                                color: Colors.red),
                            labelStyle: TextStyle(
                                fontSize: FontSizes.textFormFieldFontSize),

                            suffixIcon: IconButton(
                              onPressed: () {
                                _addEmployeesController
                                        .isPasswordInvisible.value =
                                    !_addEmployeesController
                                        .isPasswordInvisible.value;
                              },
                              icon: Icon(
                                _addEmployeesController
                                        .isPasswordInvisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 24.0,
                              ),
                            ),
                            // errorText: ,
                            labelText: "Set password",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 40.0,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     print(
                      //         "_formKey.currentState!.validate() ${_formKey.currentState!.validate()}");
                      //     if (_formKey.currentState!.validate()) {
                      //       //   _addEmployeesController.signupAdmin();
                      //     }
                      //   },
                      //   child: ButtonWidget(
                      //       isLoading:
                      //           _addEmployeesController.addingEmployee.value,
                      //       width: Get.width,
                      //       text: "Send invitation link",
                      //       textColor: Colors.white,
                      //       color: Get.theme.primaryColor),
                      // ),
                      // SizedBox(
                      //   height: 10.0,
                      // ),
                      // Text(
                      //   "OR",
                      //   style: TextStyle(color: Colors.grey),
                      // ),
                      // SizedBox(
                      //   height: 10.0,
                      // ),
                      GestureDetector(
                        onTap: () {
                          print(
                              "_formKey.currentState!.validate() ${_formKey.currentState!.validate()}");
                          if (_formKey.currentState!.validate()) {
                            //   _addEmployeesController.signupAdmin();
                            _addEmployeesController.createEmployeeAccount();
                          }
                        },
                        child: Obx(
                          () => ButtonWidget(
                              isLoading:
                                  //false,
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
