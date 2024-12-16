import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/constants/database_references.dart';
import 'package:task_management_app/controller/login_controller.dart';

//String _ADMIN_COLLECTION_REFERENCE = "admins";
//FirebaseAuth auth = FirebaseAuth.instance;
//String _UNIQUE_ADMIN_DOC_REF = auth.currentUser!.uid;

class UserActivitiesController extends GetxController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  LoginController _loginController = Get.put(LoginController());

  RxString companyName = "".obs;

  SharedPreferencesAsync sharedPreferencesAsync = SharedPreferencesAsync();

  Future<void> getCompanyName() async {
    // QuerySnapshot<Map<String, dynamic>> querySnapshot = await _fireStore
    //     .collection(DatabaseReferences.COMPANY_COLLECTION_REFERENCE)
    //     .get();

    // for (QueryDocumentSnapshot doc in querySnapshot.docs) {}

    //     .doc(_loginController.emailController.value.text)
    //     .get()
    //     .then(
    //   (value) {
    //     companyName.value = value.data()!['companyName'].toString();
    //   },
    // );

    if (await sharedPreferencesAsync.getString("company_name") != null) {
      companyName.value =
          (await sharedPreferencesAsync.getString("company_name"))!;
    }
  }
}
