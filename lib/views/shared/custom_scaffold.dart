import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook/controllers/auth_controller.dart';
import 'package:yearbook/views/admin/admin_drawer.dart';
import 'package:yearbook/views/user/user_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final bool noDrawer;
  CustomScaffold({Key? key, required this.body, this.noDrawer = false}) : super(key: key);
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Yearbook Gallery"),
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              onPressed: () {
                authController.logout();
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        drawer: noDrawer ? null : (authController.user.value?.role == 'admin' ? AdminDrawer() : UserDrawer()),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: body,
        ),
      ),
    );
  }
}
