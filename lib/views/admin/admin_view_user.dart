import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook/controllers/admin/admin_user_controller.dart';
import 'package:yearbook/views/shared/custom_scaffold.dart';

class AdminViewUser extends StatelessWidget {
  AdminViewUser({Key? key}) : super(key: key);
  AdminUserController adminUserController = Get.put(AdminUserController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScaffold(
          noDrawer: true,
          body: adminUserController.user.value == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : editUserWidget()),
    );
  }

  Widget getUserImage() {
    if (adminUserController.user.value!.imageUrl != "") {
      return CachedNetworkImage(
        placeholder: (context, url) => const CircularProgressIndicator(),
        imageUrl: adminUserController.user.value!.imageUrl!,
      );
    } else {
      return const Placeholder();
    }
  }

  Widget editUserWidget() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: getUserImage(),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            adminUserController.user.value!.fullName,
            style: TextStyle(fontSize: 24),
          ),
          Text(
            adminUserController.user.value!.role!.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed('/admin/user/${adminUserController.user.value!.uid}/edit');
            },
            child: Text("Edit User"),
          ),
          Obx(
            () => adminUserController.loading.value
                ? CircularProgressIndicator(
                    color: Colors.red,
                  )
                : TextButton(
                    onPressed: () async {
                      await adminUserController.deleteUser();
                    },
                    child: Text(
                      "Delete User",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
