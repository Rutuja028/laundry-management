import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var phoneNumber = ''.obs;
  var verificationId = ''.obs;
  var otpCode = ''.obs;
  var isLoading = false.obs;

  void sendOTP(String number) async {
    isLoading.value = true;

    Future.delayed(Duration(seconds: 30), () {
      isLoading.value = false;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$number",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Get.offAllNamed('/home');
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar("Error", e.message ?? "Verification failed");
        isLoading.value = false;
      },
      codeSent: (String verId, int? resendToken) {
        verificationId.value = verId;
        isLoading.value = false;
        Get.toNamed('/otp');
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId.value = verId;
      },
    );
  }

  void verifyOTP(String otp) async {
    try {
      isLoading.value = true;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      isLoading.value = false;
      Get.offAllNamed('/home');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Invalid OTP");
    }
  }
}
