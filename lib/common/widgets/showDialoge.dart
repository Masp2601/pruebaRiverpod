// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_prueba/common/utils/constants.dart';
import 'package:riverpod_prueba/common/widgets/appStyle.dart';
import 'package:riverpod_prueba/common/widgets/reusable_text.dart';

showAlertDialog(
    {required BuildContext context, required String message, String? btnText}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: ReusableText(
              text: message,
              style: appStyle(18, AppConst.dark, FontWeight.w600)),
          contentPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  btnText ?? 'OK',
                  style: appStyle(18, Colors.grey, FontWeight.w600),
                ))
          ],
        );
      });
}
