import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:laundry_management/screens/auth/otp_page.dart';
import 'package:laundry_management/screens/auth/sign_in_page.dart';
import 'package:laundry_management/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Add firebase_options.dart if needed
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SignInPage()),
        GetPage(name: '/otp', page: () => OTPPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
    );
  }
}
