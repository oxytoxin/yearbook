import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:yearbook/controllers/admin/admin_add_user_controller.dart';
import 'package:yearbook/views/shared/custom_scaffold.dart';

class AdminAddUser extends StatelessWidget {
  AdminAddUser({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  AdminAddUserController adminAddUserController = Get.put(AdminAddUserController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      noDrawer: true,
      body: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'first_name',
              decoration: const InputDecoration(labelText: "First Name"),
            ),
            FormBuilderTextField(
              name: 'last_name',
              decoration: const InputDecoration(labelText: "Last Name"),
            ),
            FormBuilderTextField(
              name: 'email',
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            FormBuilderDropdown(
              name: 'role',
              initialValue: 'student',
              decoration: const InputDecoration(focusColor: Colors.white, labelText: "Role"),
              items: const [
                DropdownMenuItem(
                  child: Text("student"),
                  value: 'student',
                ),
                DropdownMenuItem(
                  child: Text("teacher"),
                  value: 'teacher',
                ),
                DropdownMenuItem(
                  child: Text("admin"),
                  value: 'admin',
                ),
              ],
            ),
            Obx(
              () => adminAddUserController.loading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState?.save();
                        await adminAddUserController.addUser(
                          firstName: _formKey.currentState?.value['first_name'],
                          lastName: _formKey.currentState?.value['last_name'],
                          email: _formKey.currentState?.value['email'],
                          role: _formKey.currentState?.value['role'],
                        );
                      },
                      child: const Text("SAVE"),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
