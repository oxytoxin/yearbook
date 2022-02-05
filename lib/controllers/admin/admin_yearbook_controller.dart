import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yearbook/controllers/admin/admin_users_controller.dart';
import 'package:yearbook/models/user_model.dart';
import 'package:yearbook/models/yearbook.dart';

class AdminYearbookController extends GetxController {
  Rx<Yearbook?> yearbook = Rx<Yearbook?>(null);
  RxList<UserModel> studentUsers = RxList<UserModel>();
  RxList<UserModel> teacherUsers = RxList<UserModel>();
  @override
  void onInit() async {
    yearbook.bindStream(getYearbook(Get.parameters['uid']!));
    studentUsers.bindStream(getUsers('student'));
    teacherUsers.bindStream(getUsers('teacher'));
    super.onInit();
  }

  Iterable<UserModel> get students => studentUsers
      .where((element) => yearbook.value!.students!.contains(element.uid));
  Iterable<UserModel> get teachers => teacherUsers
      .where((element) => yearbook.value!.teachers!.contains(element.uid));

  Stream<Yearbook> getYearbook(String uid) {
    Stream<DocumentSnapshot> stream =
        FirebaseFirestore.instance.collection('yearbooks').doc(uid).snapshots();
    return stream.map((doc) => Yearbook.fromDocumentSnapshot(doc));
  }

  Stream<List<UserModel>> getUsers(String role) {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: role)
        .snapshots();
    return stream.map((QuerySnapshot querySnapshot) => querySnapshot.docs
        .map((doc) => UserModel.fromQueryDocumentSnapshot(doc))
        .toList());
  }

  Future saveYearbook() async {
    await FirebaseFirestore.instance
        .collection('yearbooks')
        .doc(yearbook.value!.uid)
        .update({
      'theme': yearbook.value!.theme!,
      'title': yearbook.value!.title!,
      'school_year': yearbook.value!.school_year!,
      'prayer': yearbook.value!.prayer!,
      'song': yearbook.value!.song!,
    });
    Get.snackbar('Success', 'Yearbook saved!');
  }

  void addStudent(uid) async {
    if (!yearbook.value!.students!.contains(uid)) {
      yearbook.value!.students!.add(uid);
      await FirebaseFirestore.instance
          .collection('yearbooks')
          .doc(yearbook.value!.uid)
          .update(
        {
          'students': yearbook.value!.students,
        },
      );
    }
  }

  void addTeacher(uid) async {
    if (!yearbook.value!.teachers!.contains(uid)) {
      yearbook.value!.teachers!.add(uid);
      await FirebaseFirestore.instance
          .collection('yearbooks')
          .doc(yearbook.value!.uid)
          .update(
        {
          'teachers': yearbook.value!.teachers,
        },
      );
    }
  }

  void removeStudent(uid) async {
    if (yearbook.value!.students!.contains(uid)) {
      yearbook.value!.students!.remove(uid);
      await FirebaseFirestore.instance
          .collection('yearbooks')
          .doc(yearbook.value!.uid)
          .update(
        {
          'students': yearbook.value!.students,
        },
      );
    }
  }

  void removeTeacher(uid) async {
    if (yearbook.value!.teachers!.contains(uid)) {
      yearbook.value!.teachers!.remove(uid);
      await FirebaseFirestore.instance
          .collection('yearbooks')
          .doc(yearbook.value!.uid)
          .update(
        {
          'teachers': yearbook.value!.teachers,
        },
      );
    }
  }
}
