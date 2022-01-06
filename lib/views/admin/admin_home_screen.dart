import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:yearbook/views/shared/custom_scaffold.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Text("Admin Homepage"),
      ),
    );
  }
}
