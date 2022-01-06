import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key? key}) : super(key: key);

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
                  title: Text("My Profile"),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("Logout"),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
