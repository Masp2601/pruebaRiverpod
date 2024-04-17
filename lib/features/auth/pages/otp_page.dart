import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:riverpod_prueba/common/utils/constants.dart';
import 'package:riverpod_prueba/common/widgets/appStyle.dart';
import 'package:riverpod_prueba/common/widgets/height_spacer.dart';
import 'package:riverpod_prueba/common/widgets/reusable_text.dart';
import 'package:riverpod_prueba/features/auth/controller/auth_controller.dart';

class OtpPage extends ConsumerWidget {
  const OtpPage({super.key, required this.smsCodeId, required this.phone});

  final String smsCodeId;
  final String phone;

  void verifyOtpCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifyOtpCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeightSpacer(height: AppConst.heigth * 0.15),
            ReusableText(
                text: 'Ingrese su código',
                style: appStyle(26, AppConst.dark, FontWeight.bold)),
            Pinput(
              length: 6,
              showCursor: true,
              onCompleted: (value) {
                if (value.length == 6) {
                  return verifyOtpCode(context, ref, value);
                }
              },
              onSubmitted: (value) {
                if (value.length == 6) {
                  return verifyOtpCode(context, ref, value);
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
