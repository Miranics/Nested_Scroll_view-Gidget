import 'package:flutter/material.dart';
import 'src/nested_scroll_demo.dart';

void main() => runApp(const DemoApp());

/// Minimal app entrypoint. Keeps `main.dart` tiny and clean.
class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NestedScrollView — Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6D0EB5)),
      ),
      home: const NestedScrollDemo(),
    );
  }
}
