import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_prueba/common/widgets/appStyle.dart';
import 'package:riverpod_prueba/common/widgets/reusable_text.dart';
import 'package:riverpod_prueba/features/auth/controller/code_provider.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String code = ref.watch(codeStateProvider);
    throw Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          ReusableText(
            text: code,
            style: appStyle(30, Colors.grey, FontWeight.bold),
          ),
          TextButton(
              onPressed: () {
                ref.read(codeStateProvider.notifier).setStart("Hola Miguel");
              },
              child: const Text("Presioname"))
        ],
      )),
    );
  }
}
