import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text("User Accounts"),
                  onTap: () {
                    Get.back();
                    Get.toNamed('/admin/users');
                  },
                ),
                ListTile(
                  title: Text("Manage Yearbooks"),
                  onTap: () {
                    Get.back();
                    Get.toNamed('/admin/yearbooks');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
