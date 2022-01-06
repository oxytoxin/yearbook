import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook/controllers/admin/admin_yearbook_controller.dart';

class AdminYearbookStudents extends StatelessWidget {
  AdminYearbookStudents({Key? key}) : super(key: key);
  AdminYearbookController adminYearbookController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("Yearbook Students"),
        ),
        body: adminYearbookController.studentUsers.value.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Text("Included Student List"),
                  Expanded(
                      child: ListView(
                    children: adminYearbookController.students.map((student) {
                      return ListTile(
                        onLongPress: () {
                          adminYearbookController.removeStudent(student.uid);
                        },
                        onTap: () {
                          Get.toNamed('/admin/user/${student.uid}');
                        },
                        title: Text(student.fullName),
                      );
                    }).toList(),
                  )),
                  Text("Users List"),
                  Expanded(
                    child: ListView(
                      children: adminYearbookController.studentUsers.value
                          .map((user) => ListTile(
                                onLongPress: () {
                                  adminYearbookController.addStudent(user.uid);
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
