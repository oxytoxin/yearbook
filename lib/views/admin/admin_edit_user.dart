import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yearbook/controllers/admin/admin_user_controller.dart';
import 'package:yearbook/views/shared/custom_scaffold.dart';

class AdminEditUser extends StatelessWidget {
  AdminEditUser({Key? key}) : super(key: key);
  AdminUserController adminEditUserController = Get.put(AdminUserController());
  final _formKey = GlobalKey<FormBuilderState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScaffold(
          noDrawer: true,
          body: adminEditUserController.user.value == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : editUserWidget()),
    );
  }

  Widget getImage() {
    if (adminEditUserController.image_path.value == "") {
      if (adminEditUserController.user.value!.imageUrl != "") {
        return CachedNetworkImage(
          placeholder: (context, url) => const CircularProgressIndicator(),
          imageUrl: adminEditUserController.user.value!.imageUrl!,
        );
      } else {
        return const Placeholder();
      }
    }
    return Image.file(File(adminEditUserController.image_path.value));
  }

  Widget editUserWidget() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Obx(
            () => SizedBox(
              width: 200,
              height: 200,
              child: getImage(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        image = await _imagePicker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          adminEditUserController.image_path.value = image!.path;
                        }
                      },
                      child: const Text("CHOOSE PHOTO"),
                    ),
                    FormBuilderTextField(
                      name: 'first_name',
                      decoration: const InputDecoration(labelText: "First Name"),
                      initialValue: adminEditUserController.user.value!.firstName!,
                    ),
                    FormBuilderTextField(
                      name: 'last_name',
                      decoration: const InputDecoration(labelText: "Last Name"),
                      initialValue: adminEditUserController.user.value!.lastName!,
                    ),
                    FormBuilderTextField(
                      name: 'role',
                      decoration: const InputDecoration(labelText: "Role"),
                      initialValue: adminEditUserController.user.value!.role!,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => adminEditUserController.loading.value
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                _formKey.currentState?.save();
                                await adminEditUserController.updateUser(
                                  firstName: _formKey.currentState?.value['first_name'],
                                  lastName: _formKey.currentState?.value['last_name'],
                                  role: _formKey.currentState?.value['role'],
                                );
                              },
                              child: const Text("SAVE"),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
