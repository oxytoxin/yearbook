import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:yearbook/controllers/yearbook_viewer_controller.dart';

class YearbookViewer extends StatelessWidget {
  YearbookViewer({Key? key}) : super(key: key);
  YearbookViewerController yearbookViewerController = Get.put(YearbookViewerController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => yearbookViewerController.yearbook.value == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  child: SfPdfViewer.network(yearbookViewerController.yearbook.value!.yearbookUrl!),
                ),
        ),
      ),
    );
  }
}
