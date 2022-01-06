import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:yearbook/controllers/auth_controller.dart';
import 'package:yearbook/views/shared/custom_scaffold.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),
              FormBuilderTextField(
                name: 'password',
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                child: const Text("LOGIN"),
                onPressed: () {
                  _formKey.currentState?.save();
                  authController.login(_formKey.currentState?.value['email'], _formKey.currentState?.value['password']);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
