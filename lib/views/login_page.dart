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
    // TODO: implement initState
    super.initState();
    // loginController.init();
  }

  // FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // title: Text(
            //   "Sign up",
            //   style: TextStyle(fontSize: 17.0),
            // ),
          ),
          body: Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 30.0, right: 20.0),
              child: Form(
                key: _formKey,
                child: Container(
                  //    color: Colors.red,
                  height: Get.height,
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

                        TextFormField(
                          style: TextStyle(
                              fontSize: FontSizes.textFormFieldFontSize
                              //  deviceWidth > 600
                              //     ? Fontsizes.tabletTextFormInputFieldSize
                              //     : Fontsizes.textFormInputFieldSize
                              ),
                          controller: loginController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            return ValidationHelper.isEmailValid(value);
                          },
                          onChanged: (value) {
                            print("onChanged");
                            loginController.companyNameController.text =
                                loginController.guessCompanyName(value);
                          },
                          //  () {
                          //   print("onEditingComplete");
                          //   _companyNameController.text = loginController
                          //       .guessCompanyName(_emailController.text);
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
                            labelText: "Enter your email",
                            // border: OutlineInputBorder(
                            //     borderSide: BorderSide(color: Colors.red),
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(20.0))),
                          ),
                        ),

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
                        const SizedBox(
                          height: 40.0,
                        ),

                        GestureDetector(
                            onTap: () {
                              print(
                                  "_formKey.currentState!.validate() ${_formKey.currentState!.validate()}");
                              if (_formKey.currentState!.validate()) {
                                // try {
                                loginController.loginAdmin();
                              }
                            },
                            child: Obx(
                              () => ButtonWidget(
                                  isLoading:
                                      loginController.logingAccount.value,
                                  width: Get.width,
                                  text: "Admin login",
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
                        Center(
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
                                        // deviceWidth > 600 ? 24.sp : 16.sp
                                        )))),
                      ]),
                ),
              ))),
    );
  }
}
