// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    // Limpar dados de autenticação
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Redirecionar para a tela de login
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 44, 44, 44),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('História da Norma'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/historia-norma');
            },
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Mapa Isopletas NBR'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/mapa-isopletas-nbr');
            },
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Mapa Isopletas Proposta'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, '/mapa-isopletas-proposta');
            },
          ),
          ListTile(
            leading: Icon(Icons.map_rounded),
            title: Text('Calcular Velocidade VK Norma'),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                '/calc-velocidade-norma',
                arguments: {'mapType': 'isopleta_nbr_calc'},
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.map_rounded),
            title: Text('Calcular Velocidade VK Proposta'),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                '/calc-velocidade-norma',
                arguments: {'mapType': 'isopleta_prop_calc'},
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
