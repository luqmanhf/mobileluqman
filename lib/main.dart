import 'package:flutter/material.dart';
import 'package:mobileluqman/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'JetBrainsMono',
      ),
      home: const HomePage(),
    );
  }
}
