import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yearbook/models/yearbook.dart';

class AdminYearbooksController extends GetxController {
  var loading = false.obs;
  RxList<Yearbook> yearbooks = RxList<Yearbook>();
  @override
  void onInit() {
    yearbooks.bindStream(getYearbooks());
    super.onInit();
  }

  Future createYearbook({required String title, required String schoolYear}) async {
    loading.value = true;
    DocumentReference doc = await FirebaseFirestore.instance.collection('yearbooks').add({
      "title": title,
      "school_year": schoolYear,
      "prayer": "",
      "song": "",
      "yearbook_url": "",
      "students": [],
      "teachers": [],
      "published": false,
    });
    Get.snackbar("Success", "Yearbook created.");
    loading.value = false;
  }

  Stream<List<Yearbook>> getYearbooks() {
    Stream<QuerySnapshot> stream =
        FirebaseFirestore.instance.collection('yearbooks').orderBy('school_year').snapshots();
    return stream.map((QuerySnapshot snapshot) =>
        snapshot.docs.map((QueryDocumentSnapshot doc) => Yearbook.fromQueryDocumentSnapshot(doc)).toList());
  }

  void deleteYearbook(String uid) async {
    await FirebaseFirestore.instance.collection('yearbooks').doc(uid).delete();
    Get.snackbar("Success", "Yearbook deleted.");
  }
}
