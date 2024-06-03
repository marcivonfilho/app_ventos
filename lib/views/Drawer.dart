// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
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
        ],
      ),
    );
  }
}
