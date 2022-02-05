import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yearbook/controllers/auth_controller.dart';
import 'package:yearbook/firebase_options.dart';
import 'package:yearbook/views/admin/admin_add_user.dart';
import 'package:yearbook/views/admin/admin_edit_user.dart';
import 'package:yearbook/views/admin/admin_home_screen.dart';
import 'package:yearbook/views/admin/admin_manage_yearbook.dart';
import 'package:yearbook/views/admin/admin_publish_yearbook.dart';
import 'package:yearbook/views/admin/admin_user_accounts.dart';
import 'package:yearbook/views/admin/admin_view_user.dart';
import 'package:yearbook/views/admin/admin_yearbook_students.dart';
import 'package:yearbook/views/admin/admin_yearbook_teachers.dart';
import 'package:yearbook/views/admin/admin_yearbooks.dart';
import 'package:yearbook/views/login_screen.dart';
import 'package:yearbook/views/splash_screen.dart';
import 'package:yearbook/views/user/user_home_screen.dart';
import 'package:yearbook/views/yearbook_viewer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/view_yearbook/:uid', page: () => YearbookViewer()),
        GetPage(name: '/admin/home', page: () => AdminHomeScreen()),
        GetPage(name: '/admin/users', page: () => AdminUserAccounts()),
        GetPage(name: '/admin/user/:uid', page: () => AdminViewUser()),
        GetPage(name: '/admin/user/:uid/edit', page: () => AdminEditUser()),
        GetPage(name: '/admin/users/add', page: () => AdminAddUser()),
        GetPage(name: '/admin/yearbooks', page: () => AdminYearbooks()),
        GetPage(
            name: '/admin/yearbook/:uid', page: () => AdminManageYearbook()),
        GetPage(
            name: '/admin/publish/:uid', page: () => AdminPublishYearbook()),
        GetPage(
            name: '/admin/yearbook_members/students',
            page: () => AdminYearbookStudents()),
        GetPage(
            name: '/admin/yearbook_members/teachers',
            page: () => AdminYearbookTeachers()),
        GetPage(name: '/user/home', page: () => UserHomeScreen()),
      ],
    );
  }
}
