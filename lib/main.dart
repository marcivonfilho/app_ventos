// ignore_for_file: prefer_const_constructors

import 'package:app_ventos/views/cadastro_user.dart';
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
      routes: {
        '/': (context) => LoginPage(), // Rota Tela principal
        '/login': (context) => LoginPage(), // Rota nomeada para a tela de login
        '/cadastro': (context) =>
            CadastroUser(), // Rota nomeada para a tela de cadastro
      },
    );
  }
}
