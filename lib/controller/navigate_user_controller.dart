import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
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

  Future<void> getStoragePermissions() async {
    AndroidDeviceInfo androidDeviceInfo = await DeviceInfoPlugin().androidInfo;

    if (androidDeviceInfo.version.sdkInt >= 30) {
      PermissionStatus request =
          await Permission.manageExternalStorage.request();

      if (request.isDenied) {
        await Permission.manageExternalStorage.request();
      } else if (request.isPermanentlyDenied) {
        await openAppSettings();
      }

      // else if (permissionStatus.isPermanentlyDenied) {
      //   await openAppSettings();
      // } else {}
    } else {
//  final permissionStatus = await Permission.storage.status;

//     if (permissionStatus.isDenied) {
//       //PermissionStatus permissionStatus2 =
//       await Permission.storage.request().then(
//         (value) async {
//           Get.snackbar("Storage permission requested", "",
//               colorText: Colors.white,
//               backgroundColor: Get.theme.primaryColor,
//               duration: Duration(seconds: 4),
//               borderRadius: 20.0,
//               snackPosition: SnackPosition.TOP);

//           if (await Permission.storage.isGranted) {
//             Get.snackbar("Storage permission granted", "",
//                 colorText: Colors.white,
//                 backgroundColor: Get.theme.primaryColor,
//                 duration: Duration(seconds: 4),
//                 borderRadius: 20.0,
//                 snackPosition: SnackPosition.TOP);
//           } else {
//             Get.snackbar("Error", "Storage permission denied",
//                 backgroundColor: Colors.red,
//                 colorText: Colors.white,
//                 duration: Duration(seconds: 5),
//                 borderRadius: 20.0,
//                 snackPosition: SnackPosition.TOP);
//           }
//         },
//       ).onError(
//         (error, stackTrace) {
//           print("Permission Error: $error");

//           String cleanedError =
//               error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim();

//       //    sendingResetMail.value = false;
//           Get.snackbar("Error", cleanedError,
//               backgroundColor: Colors.red,
//               colorText: Colors.white,
//               duration: Duration(seconds: 5),
//               borderRadius: 20.0,
//               snackPosition: SnackPosition.TOP);
//         },
//       );

//       // if (permissionStatus2.isDenied) {
//       //   await openAppSettings();
//       // }
//     }

      PermissionStatus permissionStatus = await Permission.storage.request();
      if (permissionStatus.isDenied) {
        await Permission.storage.request();
      } else if (permissionStatus.isPermanentlyDenied) {
        await openAppSettings();
      }
    }
  }
}
