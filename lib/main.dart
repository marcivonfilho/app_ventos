// ignore_for_file: prefer_const_constructors

import 'package:app_ventos/themes/my_theme.dart';
import 'package:app_ventos/views/cadastro_user.dart';
import 'package:app_ventos/views/login.dart';
import 'package:app_ventos/views/history_norma.dart';
import 'package:app_ventos/views/map_nbr.dart';
import 'package:app_ventos/views/map_proposta.dart';
import 'package:app_ventos/views/calculo_velocidade.dart';
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
      theme: myTheme,
      initialRoute: '/historia-norma',
      routes: {
        '/login': (context) => LoginPage(), // Rota nomeada para a tela de login
        '/cadastro': (context) =>
            CadastroUser(), // Rota nomeada para a tela de cadastro
        '/historia-norma': (context) => HistoricoNorma(),
        '/mapa-isopletas-proposta': (context) => mapPROP(),
        '/mapa-isopletas-nbr': (context) => mapNBR(),
        '/calc-velocidade-norma': (context) => LocalMapScreen(),
      },
    );
  }
}
