import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yearbook/models/yearbook.dart';

class YearbookViewerController extends GetxController {
  Rx<Yearbook?> yearbook = Rx<Yearbook?>(null);
  @override
  void onInit() {
    getYearbook();
    super.onInit();
  }

  void getYearbook() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('yearbooks').doc(Get.parameters['uid']!).get();
    yearbook.value = Yearbook.fromDocumentSnapshot(doc);
  }
}
