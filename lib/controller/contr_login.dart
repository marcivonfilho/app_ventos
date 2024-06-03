// ignore_for_file: depend_on_referenced_packages, unnecessary_brace_in_string_interps, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:app_ventos/keys/key.dart";

Future<void> login(BuildContext context, String email, String senha) async {
  try {
    final response = await http.post(
      Uri.parse('${key_server}/login'),
      body: {
        'email': email,
        'senha': senha,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Center(
            child: Text(
              'Login Efetuado com Sucesso!',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

      Navigator.pushReplacementNamed(context, '/historia-norma');
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Center(
            child: Text(
              'Credenciais incorretas!',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    } else if (response.statusCode == 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro na requisição HTTP: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erro na requisição HTTP: ${error}'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
