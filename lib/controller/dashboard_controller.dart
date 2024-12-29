import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  var count = 0.obs;
  RxInt currentIndex = 0.obs;

  RxString companyName = "".obs;

  RxString roleName = "".obs;

  RxString username = "".obs;

  RxString workEmail = "".obs;

  SharedPreferencesAsync sharedPreferencesAsync = SharedPreferencesAsync();

  RxBool fetchingSharedRefData = false.obs;

  Future<void> fetchSharedRefData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchingSharedRefData.value = true;
    });
    if (await sharedPreferencesAsync.getString("role") != null) {
      roleName.value = (await sharedPreferencesAsync.getString("role"))!;
    }

    if (await sharedPreferencesAsync.getString("username") != null) {
      username.value = (await sharedPreferencesAsync.getString("username"))!;
    }

    if (await sharedPreferencesAsync.getString("company_name") != null) {
      companyName.value =
          (await sharedPreferencesAsync.getString("company_name"))!;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchingSharedRefData.value = false;
    });
  }
}
