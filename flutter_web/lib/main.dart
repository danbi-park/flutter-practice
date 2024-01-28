import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web/provider/login_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String loginMessage = ref.watch(loginMessageProvider);

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Example')),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                loginMessage,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 30),
              Row(children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(loginStateProvider.notifier).doDeactivate();
                  },
                  child: const Text('비활성화'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    ref.read(loginStateProvider.notifier).doActivate();
                  },
                  child: const Text('활성화'),
                ),
              ]),
            ],
          ))),
    );
  }
}
