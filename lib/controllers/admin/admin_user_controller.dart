import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:yearbook/firebase_options.dart';
import 'package:yearbook/models/user_model.dart';

class AdminUserController extends GetxController {
  Rx<UserModel?> user = Rx<UserModel?>(null);
  var loading = false.obs;
  FirebaseApp? _temp;
  var image_path = "".obs;

  @override
  void onInit() {
    user.bindStream(getUser());
    super.onInit();
  }

  Stream<UserModel> getUser() {
    String uid = Get.parameters['uid']!;
    Stream<DocumentSnapshot> stream = FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
    return stream.map((doc) => UserModel.fromDocumentSnapshot(doc));
  }

  Future updateUser({required String firstName, required String lastName, required String role}) async {
    loading.value = true;
    if (!['admin', 'student', 'teacher'].contains(role)) {
      Get.snackbar("Error saving", "The role must either be admin, student, or teacher.");
      loading.value = false;
      return Future.value(false);
    }
    String? path;
    String? image_url;
    try {
      if (image_path.value != "") {
        File file = File(image_path.value);
        path = "uploads/${const Uuid().v4()}";
        await firebase_storage.FirebaseStorage.instance.ref(path).putFile(file);
        image_url = await firebase_storage.FirebaseStorage.instance.ref(path).getDownloadURL();
      }
      await FirebaseFirestore.instance.collection('users').doc(user.value!.uid).update({
        'first_name': firstName,
        'last_name': lastName,
        'role': role,
        'image_url': image_url ?? user.value!.imageUrl,
        'image_path': path ?? user.value!.imagePath,
      });
      image_path.value = "";
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message!);
      loading.value = false;
      print(e.message);
      return Future.value(false);
    }
    Get.snackbar("Success", "User details updated.");
    loading.value = false;
    return Future.value(true);
  }

  Future deleteUser() async {
    _temp = await Firebase.initializeApp(name: "temporary", options: DefaultFirebaseOptions.currentPlatform);
    loading.value = true;
    await FirebaseFirestore.instance.collection('users').doc(user.value!.uid).delete();
    loading.value = false;
    Get.back(result: 'deleted');
  }
}
