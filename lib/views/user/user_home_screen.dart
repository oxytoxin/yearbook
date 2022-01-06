import 'package:flutter/material.dart';
import 'package:yearbook/views/shared/custom_scaffold.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Text("User homescreen"),
    );
  }
}
