import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_quote_api/test/testtest.dart';

import 'view/screens/navigation_bar_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Quote',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyWidget(),
    );
  }
}
