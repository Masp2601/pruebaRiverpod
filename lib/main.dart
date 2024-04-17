import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_prueba/common/routes/routes.dart';
import 'package:riverpod_prueba/features/auth/pages/home_page.dart';
import 'package:riverpod_prueba/features/auth/pages/login_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_prueba/features/auth/pages/otp_page.dart';
import 'package:riverpod_prueba/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 825),
      minTextAdapt: true,
      builder: (context, child) {
        return ProviderScope(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Riverpod Prueba',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute: Routes.login, // Puedes definir la ruta inicial aquí
            routes: {
              Routes.home: (context) => const HomePage(),
              Routes.login: (context) => const LoginPage(),
              Routes.otp: (context) => const OtpPage(
                    smsCodeId: '',
                    phone: '',
                  ),
            },
          ),
        );
      },
    );
  }
}
