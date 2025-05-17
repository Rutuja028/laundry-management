import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laundry_management/routes/routes.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  final user = FirebaseAuth.instance.currentUser;

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laundry Management',
      initialRoute: user != null ? Routes.home : Routes.signinpage,
      getPages: AppPages.route,
    ),
  );
}
