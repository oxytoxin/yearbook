import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yearbook/controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        Get.offAllNamed('/login');
      } else {
        authController.validateUser();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: LoadingScreen(),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Text("Loading your app..."),
            ],
          ),
        )
      ],
    );
  }
}
