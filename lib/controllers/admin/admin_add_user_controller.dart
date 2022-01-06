import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:yearbook/firebase_options.dart';

class AdminAddUserController extends GetxController {
  var loading = false.obs;
  FirebaseApp? _temp;

  Future addUser(
      {required String firstName, required String lastName, required String email, required String role}) async {
    loading.value = true;
    if (!['admin', 'student', 'teacher'].contains(role)) {
      Get.snackbar("Error saving", "The role must either be admin, student, or teacher.");
      loading.value = false;
      return Future.value(false);
    }
    _temp = await Firebase.initializeApp(name: "temporary", options: DefaultFirebaseOptions.currentPlatform);
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instanceFor(app: _temp!)
          .createUserWithEmailAndPassword(email: email, password: "password");
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'first_name': firstName,
        'last_name': lastName,
        'role': role,
        'image_url': "",
        'image_path': "",
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Creating User", e.message!);
      loading.value = false;
      _temp?.delete();
      return Future.value(false);
    } catch (e) {
      print(e);
      loading.value = false;
      _temp?.delete();
      return Future.value(false);
    }
    _temp?.delete();
    loading.value = false;
    Get.snackbar("Success", "User created.");
    Get.offNamed('/admin/user/${userCredential.user!.uid}');
    return Future.value(true);
  }
}
