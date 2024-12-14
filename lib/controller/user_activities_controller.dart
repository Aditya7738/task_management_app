import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_management_app/constants/database_references.dart';

//String _ADMIN_COLLECTION_REFERENCE = "admins";
FirebaseAuth auth = FirebaseAuth.instance;
String _UNIQUE_ADMIN_DOC_REF = auth.currentUser!.uid;

class UserActivitiesController extends GetxController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  RxString companyName = "".obs;

  void getCompanyName() {
    _fireStore
        .collection(DatabaseReferences.ADMIN_COLLECTION_REFERENCE)
        .doc(_UNIQUE_ADMIN_DOC_REF)
        .get()
        .then(
      (value) {
        companyName.value = value.data()!['companyName'].toString();
      },
    );
  }
}