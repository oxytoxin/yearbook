import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:yearbook/controllers/admin/admin_yearbook_controller.dart';

class AdminManageYearbook extends StatelessWidget {
  final AdminYearbookController adminYearbookController = Get.put(AdminYearbookController());

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => adminYearbookController.yearbook.value == null
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(adminYearbookController.yearbook.value!.title!),
              ),
              body: SingleChildScrollView(
                child: FormBuilder(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'title',
                          initialValue: adminYearbookController.yearbook.value!.title,
                          decoration: InputDecoration(labelText: "Title"),
                        ),
                        FormBuilderTextField(
                          name: 'school_year',
                          initialValue: adminYearbookController.yearbook.value!.school_year,
                          decoration: InputDecoration(labelText: "School Year"),
                        ),
                        FormBuilderTextField(
                          name: 'prayer',
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          initialValue: adminYearbookController.yearbook.value!.prayer,
                          decoration: InputDecoration(
                            labelText: "Prayer",
                          ),
                        ),
                        FormBuilderTextField(
                          name: 'song',
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          initialValue: adminYearbookController.yearbook.value!.song,
                          decoration: InputDecoration(
                            labelText: "Song",
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text("# of Students: ${adminYearbookController.yearbook.value!.students!.length}"),
                        Text("# of Teachers: ${adminYearbookController.yearbook.value!.teachers!.length}"),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _formKey.currentState?.save();
                                adminYearbookController.yearbook.value!.title = _formKey.currentState?.value['title'];
                                adminYearbookController.yearbook.value!.school_year =
                                    _formKey.currentState?.value['school_year'];
                                adminYearbookController.yearbook.value!.prayer = _formKey.currentState?.value['prayer'];
                                adminYearbookController.yearbook.value!.song = _formKey.currentState?.value['song'];
                                adminYearbookController.saveYearbook();
                              },
                              child: Text("Save"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.toNamed('/admin/yearbook_members/students');
                              },
                              child: Text("Manage Students"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.toNamed('/admin/yearbook_members/teachers');
                              },
                              child: Text("Manage Teachers"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _formKey.currentState?.save();
                                adminYearbookController.yearbook.value!.title = _formKey.currentState?.value['title'];
                                adminYearbookController.yearbook.value!.school_year =
                                    _formKey.currentState?.value['school_year'];
                                adminYearbookController.yearbook.value!.prayer = _formKey.currentState?.value['prayer'];
                                adminYearbookController.yearbook.value!.song = _formKey.currentState?.value['song'];
                                adminYearbookController.saveYearbook();
                                Get.toNamed('/admin/publish/${adminYearbookController.yearbook.value!.uid}');
                              },
                              child: Text("Publish"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
    );
  }
}
