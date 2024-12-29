import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigateUserController extends GetxController {
  SharedPreferencesAsync sharedPreferencesAsync = SharedPreferencesAsync();

  RxString roleName = "".obs;
  RxBool checkingUserRole = false.obs;

  Future<void> checkUserRole() async {
    checkingUserRole.value = true;
    if (await sharedPreferencesAsync.getString("role") != null) {
      roleName.value = (await sharedPreferencesAsync.getString("role"))!;

      print("Role Name1: ${roleName.value}");
    }
    checkingUserRole.value = false;
  }
}
