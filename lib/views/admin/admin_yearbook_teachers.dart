import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook/controllers/admin/admin_yearbook_controller.dart';

class AdminYearbookTeachers extends StatelessWidget {
  AdminYearbookTeachers({Key? key}) : super(key: key);
  AdminYearbookController adminYearbookController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("Yearbook Teachers"),
        ),
        body: adminYearbookController.teacherUsers.value.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Text("Included Student List"),
                  Expanded(
                      child: ListView(
                    children: adminYearbookController.teachers.map((teacher) {
                      return ListTile(
                        onLongPress: () {
                          adminYearbookController.removeTeacher(teacher.uid);
                        },
                        onTap: () {
                          Get.toNamed('/admin/user/${teacher.uid}');
                        },
                        title: Text(teacher.fullName),
                      );
                    }).toList(),
                  )),
                  Text("Users List"),
                  Expanded(
                    child: ListView(
                      children: adminYearbookController.teacherUsers.value
                          .map((user) => ListTile(
                                onLongPress: () {
                                  adminYearbookController.addTeacher(user.uid);
                                },
                                onTap: () {
                                  Get.toNamed('/admin/user/${user.uid}');
                                },
                                title: Text(user.fullName),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
      ),
    ));
  }
}
