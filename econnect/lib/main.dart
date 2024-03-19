import 'package:econnect/view/home/home_page.dart';
import 'package:econnect/view/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECOnnect',
      theme: const MaterialTheme(TextTheme()).dark(),
      home: HomePage(),
    );
  }
}