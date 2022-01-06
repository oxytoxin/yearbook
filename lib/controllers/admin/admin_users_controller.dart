import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yearbook/models/user_model.dart';

class AdminUsersController extends GetxController {
  RxList<UserModel> users = RxList<UserModel>();

  @override
  void onInit() {
    users.bindStream(getUsers());
    super.onInit();
  }

  Stream<List<UserModel>> getUsers() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection('users').orderBy('first_name').snapshots();
    return stream
        .map((QuerySnapshot snapshot) => snapshot.docs.map((doc) => UserModel.fromQueryDocumentSnapshot(doc)).toList());
  }
}
