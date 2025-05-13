import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:laundry_management/controllers/customer_controller.dart';
import 'package:laundry_management/controllers/items_controller.dart';
import 'package:laundry_management/screens/auth/otp_page.dart';
import 'package:laundry_management/screens/auth/sign_in_page.dart';
import 'package:laundry_management/screens/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(); // Add firebase_options.dart if needed
  Get.put(CustomerController());
  Get.put(ItemController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
      getPages: [
        GetPage(name: '/otp', page: () => OTPPage()),
        GetPage(name: '/signin', page: () => SignInPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is logged in
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return HomePage(); // Send to home page if already logged in
          } else {
            return SignInPage(); // Send to sign in page
          }
        }
        // Waiting for auth state
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
