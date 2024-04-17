import 'package:flutter/material.dart';
import 'package:riverpod_prueba/features/auth/pages/home_page.dart';
import 'package:riverpod_prueba/features/auth/pages/login_page.dart';
import 'package:riverpod_prueba/features/auth/pages/otp_page.dart';

class Routes {
  static const String login = 'login';
  static const String otp = 'otp';
  static const String home = 'home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case otp:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => OtpPage(
                  smsCodeId: args['phone'],
                  phone: args['smsCodeId'],
                ));
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
