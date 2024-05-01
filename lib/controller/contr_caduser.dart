// ignore_for_file: depend_on_referenced_packages, unnecessary_brace_in_string_interps, use_build_context_synchronously

import 'package:app_ventos/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_ventos/keys/key.dart';
import 'package:bcrypt/bcrypt.dart';

Future<void> cadUser(BuildContext context, Usuario usuario) async {
  try {
    final response = await http.post(
      Uri.parse('${key_server}/caduser'),
      body: {
        'nome': usuario.nome,
        'sobrenome': usuario.sobrenome,
        'email': usuario.email,
        'senha': criptoSenha(usuario.senha),
        'tipoUser': usuario.tipoUsuario,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Center(
            child: Text(
              'Usuário Cadastrado com Sucesso!',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

      await Future.delayed(const Duration(seconds: 4));

      Navigator.pushReplacementNamed(context, '/login');
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Center(
            child: Text(
              'Esse Usuário não está disponível!',
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

// Função para criptografar a senha durante o cadastro
String criptoSenha(String senha) {
  return BCrypt.hashpw(
    senha,
    BCrypt.gensalt(),
  );
}
