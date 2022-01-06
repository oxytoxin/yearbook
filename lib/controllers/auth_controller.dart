import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:yearbook/models/user_model.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<UserModel?> user = Rx<UserModel?>(null);

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void validateUser() async {
    var doc = await FirebaseFirestore.instance.doc('users/${firebaseUser.value?.uid}').get();
    if (doc.data() != null) {
      user.value = UserModel.fromDocumentSnapshot(doc);
      if (user.value?.role == 'admin') {
        Get.offAllNamed('/admin/home');
      } else {
        Get.offAllNamed('/user/home');
      }
    }
  }

  void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Signing In", e.message!);
    }
  }

  void logout() async {
    await _auth.signOut();
  }
}
