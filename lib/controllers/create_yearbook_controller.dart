import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:yearbook/models/user_model.dart';
import 'package:yearbook/models/yearbook.dart';

class CreateYearbookController extends GetxController {
  Rx<Yearbook?> yearbook = Rx<Yearbook?>(null);
  List<UserModel> students = [];
  List<UserModel> teachers = [];
  var loading = true.obs;
  var studentPicsToBeDownloaded = 0.obs;
  var teacherPicsToBeDownloaded = 0.obs;
  @override
  void onInit() {
    fetchYearbook();
    super.onInit();
  }

  void fetchYearbook() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('yearbooks')
        .doc(Get.parameters['uid']!)
        .get();
    yearbook.value = Yearbook.fromDocumentSnapshot(doc);
    if (yearbook.value!.students!.isEmpty ||
        yearbook.value!.teachers!.isEmpty) {
      Get.back();
      Get.snackbar('Error', 'Yearbook must have students and teachers!');
      return;
    }
    var studentDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('__name__', whereIn: yearbook.value!.students!)
        .get();
    var teacherDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('__name__', whereIn: yearbook.value!.teachers!)
        .get();
    for (var doc in studentDoc.docs) {
      students.add(UserModel.fromDocumentSnapshot(doc));
    }
    for (var doc in teacherDoc.docs) {
      teachers.add(UserModel.fromDocumentSnapshot(doc));
    }
    loading.value = false;
  }

  void createYearbook() async {
    loading.value = true;
    Directory? dir = await getExternalStorageDirectory();
    for (var student in students) {
      File photo = File("${dir!.path}/${student.uid}.jpg");
      await FirebaseStorage.instance.ref(student.imagePath).writeToFile(photo);
    }
    for (var teacher in teachers) {
      File photo = File("${dir!.path}/${teacher.uid}.jpg");
      await FirebaseStorage.instance.ref(teacher.imagePath).writeToFile(photo);
    }
    final PdfDocument doc = PdfDocument();
    PdfPage page = doc.pages.add();
    var title = yearbook.value!.title;
    PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 40);
    Size size = font.measureString(title!);
    page.graphics.drawString(title, font,
        bounds: Rect.fromLTWH(
            page.getClientSize().width / 2 - size.width / 2, 0, 0, 0));
    page.graphics.drawString(
        yearbook.value!.theme!, PdfStandardFont(PdfFontFamily.helvetica, 32),
        bounds: Rect.fromLTWH(0, 48, 0, 0));
    page = doc.pages.add();
    page.graphics.drawString(
      "Prayer",
      PdfStandardFont(PdfFontFamily.helvetica, 24),
    );
    page.graphics.drawString(
        yearbook.value!.prayer!, PdfStandardFont(PdfFontFamily.helvetica, 16),
        bounds: Rect.fromLTWH(0, 30, 0, 0));
    page = doc.pages.add();
    page.graphics.drawString(
      "Song",
      PdfStandardFont(PdfFontFamily.helvetica, 24),
    );
    page.graphics.drawString(
        yearbook.value!.song!, PdfStandardFont(PdfFontFamily.helvetica, 16),
        bounds: Rect.fromLTWH(0, 30, 0, 0));

    page = doc.pages.add();
    page.graphics.drawString(
      "Students",
      PdfStandardFont(PdfFontFamily.helvetica, 40),
    );

    for (var j = 0; j < students.length; j++) {
      var i = j % 4;
      if (i == 0) {
        page = doc.pages.add();
      }
      double margin = 20;
      double left =
          (i % 2) * (page.getClientSize().width / 2) + (i % 2) * margin;
      double top = (i < 2 ? 0 : page.getClientSize().height / 2);
      double width = page.getClientSize().width / 2 - margin;
      double height = page.getClientSize().height / 2 - 60;
      page.graphics.drawImage(
          PdfBitmap(
              File('${dir!.path}/${students[j].uid}.jpg').readAsBytesSync()),
          Rect.fromLTWH(left, top, width, height));
      page.graphics.drawString(
          students[j].fullName, PdfStandardFont(PdfFontFamily.helvetica, 20),
          bounds: Rect.fromLTWH(left, top + height + 16, width, 0));
    }

    page = doc.pages.add();
    page.graphics.drawString(
      "Teachers",
      PdfStandardFont(PdfFontFamily.helvetica, 40),
    );

    for (var j = 0; j < teachers.length; j++) {
      var i = j % 4;
      if (i == 0) {
        page = doc.pages.add();
      }
      double margin = 20;
      double left =
          (i % 2) * (page.getClientSize().width / 2) + (i % 2) * margin;
      double width = page.getClientSize().width / 2 - margin;
      double height = page.getClientSize().height / 2 - 60;
      double top = (i < 2 ? 0 : page.getClientSize().height / 2);
      page.graphics.drawImage(
          PdfBitmap(
              File('${dir!.path}/${teachers[j].uid}.jpg').readAsBytesSync()),
          Rect.fromLTWH(left, top, width, height));
      page.graphics.drawString(
          teachers[j].fullName, PdfStandardFont(PdfFontFamily.helvetica, 20),
          bounds: Rect.fromLTWH(left, top + height + 16, width, 0));
    }

    var file = await File('${dir!.path}/${yearbook.value!.title!}.pdf')
        .writeAsBytes(doc.save());
    doc.dispose();
    await FirebaseStorage.instance
        .ref('yearbooks/${yearbook.value!.uid}')
        .putFile(file);
    var yearbook_url = await FirebaseStorage.instance
        .ref('yearbooks/${yearbook.value!.uid}')
        .getDownloadURL();
    await FirebaseFirestore.instance
        .collection('yearbooks')
        .doc(yearbook.value!.uid!)
        .update({
      'published': true,
      'yearbook_url': yearbook_url,
    });
    loading.value = false;
    Get.toNamed('/view_yearbook/${yearbook.value!.uid}');
  }
}
