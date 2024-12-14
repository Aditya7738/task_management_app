import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/constants/fontsizes.dart';
import 'package:task_management_app/controller/signup_controller.dart';
import 'package:task_management_app/controller/validation_helper.dart';
import 'package:task_management_app/views/admin_dash_board.dart';
import 'package:task_management_app/views/create_task.dart';
import 'package:task_management_app/views/dashboard_screen.dart';
import 'package:task_management_app/views/login_page.dart';
import 'package:task_management_app/widgets/button_widget.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignupController signupController = Get.put(SignupController());

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
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 20.0, right: 20.0),
                child: Center(
                    child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Register to Task manager",
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
                          controller: signupController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            return ValidationHelper.isEmailValid(value);
                          },
                          onChanged: (value) {
                            print("onChanged");

                            if (value.contains("@")) {
                              signupController.companyNameController.text =
                                  signupController.guessCompanyName(value);
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
                          controller: signupController.companyNameController,
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
                                    signupController.firstNameController,
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
                                controller: signupController.lastNameController,
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

                        // Container(
                        //     height: 57.0,
                        //     child: TextFormField(
                        //       style: TextStyle(
                        //           fontSize: FontSizes.textFormFieldFontSize),
                        //       controller: _companyNameController,
                        //       //keyboardType: TextInputType.name,
                        //       decoration: InputDecoration(
                        //         // hintText: "Select Option",
                        //         // hintStyle: TextStyle(
                        //         //   fontWeight: FontWeight.normal,
                        //         //   fontSize: 15.0,
                        //         //   color: const Color(0x7F555770),
                        //         // ),
                        //         labelStyle: TextStyle(
                        //           fontSize: FontSizes.textFormFieldFontSize,
                        //           // deviceWidth > 600
                        //           //     ? Fontsizes.tabletTextFormInputFieldSize
                        //           //     : Fontsizes.textFormInputFieldSize
                        //         ),
                        //         labelText: "Select your company",
                        //         suffix: DropdownButtonHideUnderline(
                        //           child: DropdownButton(
                        //             borderRadius: BorderRadius.circular(10.0),
                        //             iconSize: 25.0,
                        //             icon: Container(
                        //               margin: const EdgeInsets.only(right: 10.0),
                        //               child: const Icon(
                        //                   Icons.keyboard_arrow_down_rounded),
                        //             ),
                        //             items: companyNames
                        //                 .map<DropdownMenuItem<String>>(
                        //                     (companyName) {
                        //               return DropdownMenuItem<String>(
                        //                 value: companyName,
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.only(
                        //                     left: 10.0,
                        //                   ),
                        //                   child: Text(companyName),
                        //                 ),
                        //               );
                        //             }).toList(),
                        //             onChanged: (value) {
                        //               print("COMPANY ${value.toString()}");

                        //               _companyNameController.text =
                        //                   value.toString();

                        //               print(
                        //                   "_companyNameController.text ${_companyNameController.text}");
                        //             },
                        //           ),
                        //         ),
                        //         // border: const OutlineInputBorder(
                        //         //     borderSide: BorderSide(
                        //         //       color: Color.fromARGB(255, 221, 221, 221),
                        //         //     ),
                        //         //     borderRadius:
                        //         //         BorderRadius.all(Radius.circular(10.0))),
                        //       ),
                        //       maxLines: 1,
                        //     )),

                        // const SizedBox(
                        //   height: 30.0,
                        // ),
                        Obx(
                          () => TextFormField(
                            style: TextStyle(
                                fontSize: FontSizes.textFormFieldFontSize
                                //  deviceWidth > 600
                                //     ? Fontsizes.tabletTextFormInputFieldSize
                                //     : Fontsizes.textFormInputFieldSize
                                ),
                            controller: signupController.passwordController,
                            obscureText:
                                signupController.isPasswordInvisible.value,
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
                              //  deviceWidth > 600
                              //     ? Fontsizes.tabletTextFormInputFieldSize
                              //     : Fontsizes.textFormInputFieldSize),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  // if (mounted) {
                                  //   setState(() {
                                  //     isObscured = !isObscured;
                                  //   });
                                  // }

                                  signupController.isPasswordInvisible.value =
                                      !signupController
                                          .isPasswordInvisible.value;
                                },
                                icon: Icon(
                                  // isObscured
                                  //     ? Icons.visibility
                                  //     : Icons.visibility_off,

                                  signupController.isPasswordInvisible.value
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
                          height: 30.0,
                        ),
                        Obx(
                          () => TextFormField(
                            style: TextStyle(
                              fontSize: FontSizes.textFormFieldFontSize,
                              //  deviceWidth > 600
                              //     ? Fontsizes.tabletTextFormInputFieldSize
                              //     : Fontsizes.textFormInputFieldSize
                            ),
                            controller:
                                signupController.confirmPasswordController,
                            obscureText: signupController
                                .isConfirmPasswordInvisible.value,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              return ValidationHelper.isPassAndConfirmPassSame(
                                  signupController.passwordController.text,
                                  value!);
                            },
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontSize: FontSizes.errorFontSize,
                                  // fontSize: deviceWidth > 600
                                  //     ? Fontsizes.tabletErrorTextSize
                                  //     : Fontsizes.errorTextSize,
                                  color: Colors.red),
                              labelStyle: TextStyle(
                                  fontSize: FontSizes.textFormFieldFontSize
                                  // deviceWidth > 600
                                  //     ? Fontsizes.tabletTextFormInputFieldSize
                                  //     : Fontsizes.textFormInputFieldSize
                                  ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  signupController
                                          .isConfirmPasswordInvisible.value =
                                      !signupController
                                          .isConfirmPasswordInvisible.value;
                                  // if (mounted) {
                                  //   setState(() {
                                  //     isObscured2 = !isObscured2;
                                  //   });
                                  // }
                                },
                                icon: Icon(
                                  // isObscured
                                  //     ? Icons.visibility
                                  //     : Icons.visibility_off,
                                  signupController
                                          .isConfirmPasswordInvisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 24.0,
                                ),
                              ),
                              // errorText: ,
                              labelText: "Confirm your password",
                              // border: const OutlineInputBorder(
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(20.0))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        // Center(
                        //     child: RichText(
                        //         text: TextSpan(
                        //   text: 'By clicking on Save chage, you accept our ',
                        //   style: TextStyle(
                        //       fontSize:
                        //       deviceWidth > 600 ? 24.sp : 16.sp,
                        //       color: Colors.black),
                        //   children: <TextSpan>[
                        //     TextSpan(
                        //       text: 'T&C',
                        //       style: TextStyle(
                        //           // fontSize: deviceWidth > 600
                        //           // ? Fontsizes.tabletTextFormInputFieldSize
                        //           // : Fontsizes.textFormInputFieldSize,
                        //           color: Color(int.parse(
                        //               "0xff${layoutDesignProvider.primary.substring(1)}")),
                        //           fontWeight: FontWeight.bold),
                        //       recognizer: TapGestureRecognizer()
                        //         ..onTap = () {
                        //           // Handle the click event for the specific word.
                        //           print('You clicked on T&C');
                        //           onLinkClicked(
                        //               "https://tiarabytj.com/terms-conditions/");
                        //           // Add your custom action here.
                        //         },
                        //     ),
                        //     TextSpan(
                        //       text: ' and ',
                        //       style: TextStyle(
                        //           // fontSize: deviceWidth > 600
                        //           // ? Fontsizes.tabletTextFormInputFieldSize
                        //           // : Fontsizes.textFormInputFieldSize
                        //           ),
                        //     ),
                        //     TextSpan(
                        //       text: 'Privacy Policy',
                        //       style: TextStyle(
                        //           //  fontSize: deviceWidth > 600
                        //           // ? Fontsizes.tabletTextFormInputFieldSize
                        //           // : Fontsizes.textFormInputFieldSize,
                        //           color: Color(int.parse(
                        //               "0xff${layoutDesignProvider.primary.substring(1)}")),
                        //           fontWeight: FontWeight.bold),
                        //       recognizer: TapGestureRecognizer()
                        //         ..onTap = () {
                        //           // Handle the click event for the specific word.
                        //           print('You clicked on Privacy Policy');
                        //           onLinkClicked(
                        //               "https://tiarabytj.com/privacy-policy/");
                        //           // Add your custom action here.
                        //         },
                        //     ),
                        //   ],
                        // ))),
                        // SizedBox(
                        //   height: deviceWidth > 600 ? 80.0 : 30.0,
                        // ),
                        GestureDetector(
                            onTap: () {
                              print(
                                  "_formKey.currentState!.validate() ${_formKey.currentState!.validate()}");
                              if (_formKey.currentState!.validate()) {
                                // try {
                                signupController.signupAdmin();
                              }
                            },
                            child: Obx(
                              () => ButtonWidget(
                                  isLoading:
                                      signupController.creatingAccount.value,
                                  width: Get.width,
                                  text: "Admin sign up",
                                  textColor: Colors.white,
                                  color: Get.theme.primaryColor),
                            )
                            //  Container(
                            //     width: Get.width,
                            //     //  MediaQuery.of(context).size.width > 600
                            //     //     ? 600.sp
                            //     //     : MediaQuery.of(context).size.width,
                            //     decoration: BoxDecoration(
                            //         color: Get.theme.primaryColor,
                            //         borderRadius: BorderRadius.circular(15.0)),
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: 10.0, horizontal: 20.0),
                            //     child: Center(
                            //       child:
                            //           //  isLoading
                            //           //     ? Container(
                            //           //         padding:
                            //           //             EdgeInsets.symmetric(vertical: 5.0),
                            //           //         width: (deviceWidth / 28) + 4,
                            //           //         height: (deviceWidth / 28) + 13,
                            //           //         child: CircularProgressIndicator(
                            //           //           color: Colors.white,
                            //           //           strokeWidth: 2.0,
                            //           //           backgroundColor: Color(0xffCC868A),
                            //           //         ),
                            //           //       )
                            //           //     :
                            //           Text(
                            //         "Sign up",
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 18,
                            //           // deviceWidth > 600
                            //           //     ? Fontsizes.tabletButtonTextSize
                            //           //     : Fontsizes.buttonTextSize
                            //         ),
                            //       ),
                            //     )),

                            ),
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
                                text: 'Already have an account?',
                                style: TextStyle(
                                    // fontSize: deviceWidth > 600
                                    // ? Fontsizes.tabletTextFormInputFieldSize
                                    // : Fontsizes.textFormInputFieldSize,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: '   Login',
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
                                    Get.to(() => LoginPage());
                                  },
                              ),
                            ],
                                    style: TextStyle(fontSize: 14.0
                                        // deviceWidth > 600 ? 24.sp : 16.sp
                                        )))),
                      ]),
                ))),
          )),
    );
  }
}
