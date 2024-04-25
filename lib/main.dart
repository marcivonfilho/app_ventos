import 'package:app_ventos/views/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ventos',
      theme: ThemeData(),
      // ignore: prefer_const_constructors
      home: LoginPage(),
    );
  }
}
