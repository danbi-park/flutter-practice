import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web/provider/login_provider.dart';
import 'package:gap/gap.dart';

import 'provider/counter_provider.dart';

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
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Example')),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Layout(child: loginCheckWidget(ref)),
              const Gap(30),
              Layout(
                child: counterWidget(ref),
              ),
            ],
          ))),
    );
  }

  // 로그인 상태를 확인하는 위젯
  Widget loginCheckWidget(WidgetRef ref) {
    return Column(
      children: [
        Text(
          ref.watch(loginMessageProvider),
          style: const TextStyle(fontSize: 30),
        ),
        const SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    );
  }

  // 카운터 위젯
  counterWidget(WidgetRef ref) {
    final count = ref.watch(counterProvider);
    ref.listen(counterProvider, ((previous, next) {
      if (previous != next) {
        print('previous: $previous, next: $next');
      }
    }));

    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(color: Colors.black),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text("+"),
            onPressed: () {
              ref.read(counterProvider.notifier).increment();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("-"),
            onPressed: () {
              ref.read(counterProvider.notifier).decrement();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("초기화"),
            onPressed: () {
              ref.invalidate(counterProvider);
            },
          )
        ])
      ],
    );
  }
}

class Layout extends StatelessWidget {
  const Layout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFE5E5E5),
      ),
      child: child,
    );
  }
}
