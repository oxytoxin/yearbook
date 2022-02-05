import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:yearbook/controllers/admin/admin_yearbooks_controller.dart';
import 'package:yearbook/views/shared/custom_scaffold.dart';

class AdminYearbooks extends StatelessWidget {
  AdminYearbooks({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  AdminYearbooksController adminYearbooksController =
      Get.put(AdminYearbooksController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      noDrawer: true,
      body: Column(
        children: [
          ElevatedButton(
              onPressed: (() => openDialog(context)),
              child: Text("NEW YEARBOOK")),
          Expanded(
            child: Obx(() => ListView(
                  children: adminYearbooksController.yearbooks.value
                      .map(
                        (yearbook) => Card(
                          child: InkWell(
                            onTap: () {
                              if (yearbook.published == true) {
                                Get.toNamed('/view_yearbook/${yearbook.uid}');
                              } else {
                                Get.toNamed('/admin/yearbook/${yearbook.uid}');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(yearbook.title!),
                                      yearbook.published!
                                          ? const Text(
                                              "Published",
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : const Text(
                                              "Unpublished",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(yearbook.school_year!),
                                      TextButton(
                                        onPressed: () {
                                          adminYearbooksController
                                              .deleteYearbook(yearbook.uid!);
                                        },
                                        child: Text('DELETE',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )),
          ),
        ],
      ),
    );
  }

  void openDialog(BuildContext context) {
    Get.dialog(Dialog(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Create a yearbook"),
            FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilderTextField(
                      name: 'title',
                      decoration: const InputDecoration(labelText: "Title"),
                    ),
                    FormBuilderTextField(
                      name: 'school_year',
                      decoration:
                          const InputDecoration(labelText: "School Year"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() => adminYearbooksController.loading.value
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              _formKey.currentState?.save();
                              await adminYearbooksController.createYearbook(
                                title: _formKey.currentState?.value['title'],
                                schoolYear:
                                    _formKey.currentState?.value['school_year'],
                              );
                              Navigator.of(context, rootNavigator: true)
                                  .pop(context);
                            },
                            child: Text("CREATE")))
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
