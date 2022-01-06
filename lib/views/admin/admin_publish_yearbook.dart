import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook/controllers/create_yearbook_controller.dart';

class AdminPublishYearbook extends StatelessWidget {
  AdminPublishYearbook({Key? key}) : super(key: key);
  CreateYearbookController createYearbookController = Get.put(CreateYearbookController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Publishing Yearbook"),
        ),
        body: Obx(() => createYearbookController.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      createYearbookController.createYearbook();
                    },
                    child: Text("Create PDF"),
                  ),
                ],
              )),
      ),
    );
  }
}
