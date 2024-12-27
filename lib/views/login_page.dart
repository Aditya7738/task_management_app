import 'package:custom_radio_group_list/custom_radio_group_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/constants/fontsizes.dart';
import 'package:task_management_app/controller/login_controller.dart';
import 'package:task_management_app/controller/signup_controller.dart';
import 'package:task_management_app/controller/validation_helper.dart';
import 'package:task_management_app/views/admin_dash_board.dart';
import 'package:task_management_app/views/create_task.dart';
import 'package:task_management_app/views/dashboard_screen.dart';
import 'package:task_management_app/views/signup_page.dart';
import 'package:task_management_app/widgets/button_widget.dart';
import 'package:task_management_app/widgets/reset_password_dialog.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();

    loginController.emailController.value.clear();
    loginController.companyNameController.text = "";
    loginController.passwordController.text = "";
    loginController.usernameController.text = "";

    loginController.role.value = "Manager";
  }

  void showResetPasswordDialog(BuildContext context) {
    // double deviceWidth = MediaQuery.of(context).size.width;

    // final customerProvider =
    //     Provider.of<CustomerProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text("Reset password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          content: SingleChildScrollView(
            child: SizedBox(
              height: Get.height * .35,
              width: Get.width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fill below details to reset your password',
                      style: TextStyle(
                        color: const Color(0xFF555770),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.32,
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Obx(
                    () => TextFormField(
                      style: TextStyle(fontSize: FontSizes.textFormFieldFontSize
                          //  deviceWidth > 600
                          //     ? Fontsizes.tabletTextFormInputFieldSize
                          //     : Fontsizes.textFormInputFieldSize
                          ),
                      controller: loginController.resetUsernameController,
                      keyboardType: loginController.role.value == "Admin"
                          ? TextInputType.emailAddress
                          : TextInputType.name,
                      validator: (value) {
                        if (loginController.role.value == "Admin") {
                          return ValidationHelper.isEmailValid(value);
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        print("onChanged");
                        if (loginController.role.value == "Admin") {
                          loginController.companyNameController.text =
                              loginController.guessCompanyName(value);
                        }
                      },
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
                        labelText: loginController.role.value == "Admin"
                            ? "Enter your email"
                            : "Enter assigned username",

                        // border: OutlineInputBorder(
                        //     borderSide: BorderSide(color: Colors.red),
                        //     borderRadius:
                        //         BorderRadius.all(Radius.circular(20.0))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: FontSizes.textFormFieldFontSize
                        //  deviceWidth > 600
                        //     ? Fontsizes.tabletTextFormInputFieldSize
                        //     : Fontsizes.textFormInputFieldSize
                        ),
                    controller: loginController.resetCompanyController,
                    keyboardType: TextInputType.name,
                    // validator: (value) {
                    //   return ValidationHelper.isEmailValid(value);
                    // },
                    decoration: InputDecoration(
                      // errorStyle: TextStyle(
                      //     fontSize: FontSizes.errorFontSize,
                      //     //  deviceWidth > 600
                      //     //     ? Fontsizes.tabletErrorTextSize
                      //     //     : Fontsizes.errorTextSize,
                      //     color: Colors.red),
                      labelStyle: TextStyle(fontSize: 14.0

                          // deviceWidth > 600
                          //     ? Fontsizes.tabletTextFormInputFieldSize
                          //     : Fontsizes.textFormInputFieldSize
                          ),

                      labelText: "Company name",

                      // border: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.red),
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child:
                    //  Container(
                    //     margin: EdgeInsets.only(bottom: 10.0),
                    //     decoration: BoxDecoration(
                    //         border: Border.all(
                    //             color: Get.theme.primaryColor,
                    //             style: BorderStyle.solid),
                    //         borderRadius: BorderRadius.circular(10.0)),
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10.0, horizontal: 20.0),
                    //     child:
                    Text(
                  "Cancel",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.red,
                    // color: Colors.black,
                    //fontSize: deviceWidth > 600 ? 25 : 17
                  ),
                )
                //  ),
                ),
            const SizedBox(
              width: 10.0,
            ),
            GestureDetector(
                onTap: () {
                  loginController.resetPassword();
                },
                child: Obx(
                  () => ButtonWidget(
                    isLoading: loginController.sendingResetMail.value,
                    width: 200.0,
                    color: Get.theme.primaryColor,
                    text: "Reset password",
                    textColor: Colors.white,
                  ),
                )
                //  Container(
                //     decoration: BoxDecoration(
                //         color: Theme.of(context).primaryColor,
                //         borderRadius: BorderRadius.circular(20.0)),
                //     padding: const EdgeInsets.symmetric(
                //         vertical: 10.0, horizontal: 20.0),
                //     child: Text(
                //       "Reset password",
                //       style: TextStyle(
                //           fontSize: 16,
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold
                //           //fontSize: deviceWidth > 600 ? 25 : 17
                //           ),
                //     )),
                ),
          ],
        );
      },
    ).then((value) {
      loginController.resetUsernameController.clear();
      loginController.resetCompanyController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 30.0, right: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Login to Task manager",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19.0,
                              //  deviceWidth > 600
                              //     ? Fontsizes.tabletHeadingSize
                              //     : Fontsizes.headingSize,
                            )),
                        const SizedBox(
                          height: 40.0,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Login as",
                                style: TextStyle(
                                  fontSize: 16,
                                  // fontFamily: 'Inter',
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            // Container(
                            //     color: Colors.red,
                            //     //height: 200.0,
                            //     width: Get.width * 0.65,
                            //     height: 40.0,
                            //     child: RadioGroup(
                            //       scrollDirection: Axis.horizontal,
                            //       items: roles,
                            //       onChanged: (value) {},
                            //       labelBuilder: (context, index) {
                            //         Container(
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.all(
                            //                 Radius.circular(20.0)),
                            //             border: Border.all(
                            //                 color: Theme.of(context)
                            //                     .primaryColor,
                            //                 width: 1.0),
                            //           ),
                            //           child:
                            //               // GetBuilder<loginController>(
                            //               //   builder: (controller) {
                            //               //     return
                            //               Obx(
                            //             () => RadioMenuButton(
                            //                 toggleable: true,
                            //                 value: "Manager",
                            //                 groupValue: loginController
                            //                     .role.value,
                            //                 onChanged: (value) {
                            //                   loginController.role.value =
                            //                       value.toString();
                            //                 },
                            //                 style: ButtonStyle(
                            //                     iconColor:
                            //                         WidgetStateProperty
                            //                             .all(Theme.of(
                            //                                     context)
                            //                                 .primaryColor)),
                            //                 child: Text(
                            //                   "Manager",
                            //                   style: TextStyle(
                            //                       fontSize: 17,
                            //                       color: loginController
                            //                                   .role.value ==
                            //                               "Manager"
                            //                           ? Theme.of(context)
                            //                               .primaryColor
                            //                           : Colors.black),
                            //                 )),
                            //           )
                            //           //         ;
                            //           //   },
                            //           // ),
                            //           ),

                            //         return Text(
                            //           roles[index],
                            //           style: TextStyle(
                            //               fontSize: 17,
                            //               color: loginController.role.value ==
                            //                       roles[index]
                            //                   ? Theme.of(context).primaryColor
                            //                   : Colors.black),
                            //         );
                            //       },
                            //     )),

                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => RadioMenuButton(
                                        toggleable: true,
                                        value: "Manager",
                                        groupValue: loginController.role.value,
                                        onChanged: (value) {
                                          loginController.role.value =
                                              value.toString();
                                        },
                                        style: ButtonStyle(
                                            iconColor: WidgetStateProperty.all(
                                                Theme.of(context)
                                                    .primaryColor)),
                                        child: Text(
                                          "Manager",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  loginController.role.value ==
                                                          "Manager"
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.black),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Obx(
                                    () => RadioMenuButton(
                                        toggleable: true,
                                        value: "Employee",
                                        groupValue: loginController.role.value,
                                        onChanged: (value) {
                                          loginController.role.value =
                                              value.toString();
                                        },
                                        style: ButtonStyle(
                                            iconColor: WidgetStateProperty.all(
                                                Theme.of(context)
                                                    .primaryColor)),
                                        child: Text(
                                          "Employee",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  loginController.role.value ==
                                                          "Employee"
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.black),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Obx(
                                    () => RadioMenuButton(
                                        toggleable: true,
                                        value: "Admin",
                                        groupValue: loginController.role.value,
                                        onChanged: (value) {
                                          loginController.role.value =
                                              value.toString();
                                        },
                                        style: ButtonStyle(
                                            iconColor: WidgetStateProperty.all(
                                                Theme.of(context)
                                                    .primaryColor)),
                                        child: Text(
                                          "Admin",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  loginController.role.value ==
                                                          "Admin"
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.black),
                                        )),
                                  ),
                                ]),
                          ],
                        ),

                        const SizedBox(
                          height: 30.0,
                        ),

                        Obx(() {
                          if (loginController.role.value == "Admin") {
                            return TextFormField(
                              style: TextStyle(
                                  fontSize: FontSizes.textFormFieldFontSize
                                  //  deviceWidth > 600
                                  //     ? Fontsizes.tabletTextFormInputFieldSize
                                  //     : Fontsizes.textFormInputFieldSize
                                  ),
                              controller: loginController.emailController.value,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                return ValidationHelper.isEmailValid(value);
                              },
                              onChanged: (value) {
                                print("onChanged");
                                loginController.companyNameController.text =
                                    loginController.guessCompanyName(value);
                              },
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
                                labelText: "Enter your email",
                              ),
                            );
                          } else {
                            return TextFormField(
                              style: TextStyle(
                                  fontSize: FontSizes.textFormFieldFontSize
                                  //  deviceWidth > 600
                                  //     ? Fontsizes.tabletTextFormInputFieldSize
                                  //     : Fontsizes.textFormInputFieldSize
                                  ),
                              controller: loginController.usernameController,
                              keyboardType: TextInputType.name,
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
                                labelText: "Enter your username",
                              ),
                            );
                          }
                        }),

                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          style: TextStyle(
                              fontSize: FontSizes.textFormFieldFontSize
                              //  deviceWidth > 600
                              //     ? Fontsizes.tabletTextFormInputFieldSize
                              //     : Fontsizes.textFormInputFieldSize
                              ),
                          controller: loginController.companyNameController,
                          keyboardType: TextInputType.name,
                          // validator: (value) {
                          //   return ValidationHelper.isEmailValid(value);
                          // },
                          decoration: InputDecoration(
                            // errorStyle: TextStyle(
                            //     fontSize: FontSizes.errorFontSize,
                            //     //  deviceWidth > 600
                            //     //     ? Fontsizes.tabletErrorTextSize
                            //     //     : Fontsizes.errorTextSize,
                            //     color: Colors.red),
                            labelStyle: TextStyle(fontSize: 14.0

                                // deviceWidth > 600
                                //     ? Fontsizes.tabletTextFormInputFieldSize
                                //     : Fontsizes.textFormInputFieldSize
                                ),

                            labelText: "Company name",

                            // border: OutlineInputBorder(
                            //     borderSide: BorderSide(color: Colors.red),
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(20.0))),
                          ),
                        ),

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
                            controller: loginController.passwordController,
                            obscureText:
                                loginController.isPasswordInvisible.value,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontSize: FontSizes.errorFontSize,
                                  color: Colors.red),
                              labelStyle: TextStyle(
                                  fontSize: FontSizes.textFormFieldFontSize),

                              suffixIcon: IconButton(
                                onPressed: () {
                                  loginController.isPasswordInvisible.value =
                                      !loginController
                                          .isPasswordInvisible.value;
                                },
                                icon: Icon(
                                  loginController.isPasswordInvisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 24.0,
                                ),
                              ),
                              // errorText: ,
                              labelText: "Enter your password",
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                            //color: Colors.amber,
                            alignment: Alignment.centerRight,
                            width: Get.width,
                            child: GestureDetector(
                              onTap: () {
                                // Get.to(() => ResetPassword());
                                // Get.dialog(
                                //   barrierColor: Colors.white.withOpacity(0.5),
                                //   ResetPasswordDialog(),
                                // );
                                // showDialog(
                                //   context: context,
                                //   builder: (context) => ResetPasswordDialog(),
                                // );
                                showResetPasswordDialog(context);
                              },
                              child: Text("Reset password",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                    color: Get.theme.primaryColor,
                                  )),
                            )),
                        const SizedBox(
                          height: 40.0,
                        ),

                        GestureDetector(
                            onTap: () {
                              print(
                                  "_formKey.currentState!.validate() ${_formKey.currentState!.validate()}");
                              if (_formKey.currentState!.validate()) {
                                loginController.login();
                              }
                            },
                            child: Obx(
                              () => ButtonWidget(
                                  isLoading:
                                      loginController.logingAccount.value,
                                  width: Get.width,
                                  text: loginController.role.value == "Admin"
                                      ? "Login as Admin"
                                      : loginController.role.value == "Manager"
                                          ? "Login as Manager"
                                          : "Login as Employee",
                                  textColor: Colors.white,
                                  color: Get.theme.primaryColor),
                            )),
                        // const SizedBox(
                        //   height: 20.0,
                        // ),

                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(() => DashboardScreen());
                        //   },
                        //   child: ButtonWidget(
                        //       isLoading: false,
                        //       width: Get.width,
                        //       text: "Go to user side",
                        //       textColor: Colors.white,
                        //       color: Get.theme.primaryColor),
                        // ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        Obx(() {
                          if (loginController.role.value == "Admin") {
                            return Center(
                                child: RichText(
                                    text: TextSpan(
                                        children: <TextSpan>[
                                  TextSpan(
                                    text: 'Not have an account?',
                                    style: TextStyle(
                                        // fontSize: deviceWidth > 600
                                        // ? Fontsizes.tabletTextFormInputFieldSize
                                        // : Fontsizes.textFormInputFieldSize,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: '   Register',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // fontSize: deviceWidth > 600
                                      // ? Fontsizes.tabletTextFormInputFieldSize
                                      // : Fontsizes.textFormInputFieldSize,
                                      color: Get.theme.primaryColor,
                                      //  Color(int.parse(
                                      //     "0xff${layoutDesignProvider.primary.substring(1)}"))
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //   builder: (context) => const LoginPage(
                                        //     isComeFromCart: false,
                                        //   ),
                                        // ));
                                        //  Navigator.pop(context);
                                        Get.to(() => SignupPage());
                                      },
                                  ),
                                ],
                                        style: TextStyle(fontSize: 14.0
                                            // deviceWidth > 600 ? 24 : 16
                                            ))));
                          } else {
                            return SizedBox();
                          }
                        }),
                      ]),
                )),
          )),
    );
  }
}
