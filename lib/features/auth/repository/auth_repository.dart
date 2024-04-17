import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_prueba/common/routes/routes.dart';
import 'package:riverpod_prueba/common/widgets/showDialoge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_prueba/features/auth/pages/otp_page.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(auth: FirebaseAuth.instance);
});

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({required this.auth});

  void verifyOtp({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);
      await auth.signInWithCredential(credential);

      if (!mounted) {
        return;
      }
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    } on FirebaseAuth catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void sendOtp({
    required BuildContext context,
    required String phone,
  }) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            showAlertDialog(context: context, message: e.toString());
          },
          codeSent: (smsCodeId, resendCodeId) async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(auth.currentUser?.uid)
                .set({
              'phone': phone,
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpPage(
                  phone: phone,
                  smsCodeId: smsCodeId,
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String smsCodeId) {});
    } on FirebaseAuth catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
