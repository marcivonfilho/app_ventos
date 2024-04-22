import 'package:app_ventos/views/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
