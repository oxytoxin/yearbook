import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook/controllers/admin/admin_users_controller.dart';
import 'package:yearbook/views/shared/custom_scaffold.dart';

class AdminUserAccounts extends StatelessWidget {
  AdminUserAccounts({Key? key}) : super(key: key);
  AdminUsersController usersController = Get.put(AdminUsersController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      noDrawer: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/admin/users/add');
            },
            child: Text("Add User"),
          ),
          Expanded(
            child: Obx(
              () => ListView(
                children: usersController.users.value
                    .map((user) => Card(
                          child: InkWell(
                            onTap: () async {
                              var result =
                                  await Get.toNamed('/admin/user/${user.uid}');
                              if (result == 'deleted') {
                                Get.snackbar('Success', 'User deleted.');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.fullName,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(user.role!),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
