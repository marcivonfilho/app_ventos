// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, prefer_const_constructors

import 'package:app_ventos/views/cadastro_user.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:app_ventos/controller/contr_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 44, 44, 44), // Cor de fundo da tela
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'lib/assets/Image_logo.png', // Substitua pelo caminho da sua imagem de logo
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bem-vindo de volta!',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                buildTextFormField('E-mail', emailController, Icons.email),
                const SizedBox(height: 16),
                buildTextFormField('Senha', senhaController, Icons.lock,
                    obscureText: true),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // A validação passou, processar os dados aqui

                      String email = emailController.text;
                      String senha = senhaController.text;

                      login(context, email, senha);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor:
                          const Color.fromARGB(255, 255, 255, 255)),
                  child: const Text('Entrar',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                ),
                const SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    children: [
                      const TextSpan(text: 'Ainda não tem uma conta? '),
                      TextSpan(
                        text: 'Crie uma agora',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color:
                              Color.fromARGB(255, 255, 255, 255), // Cor do link
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CadastroUser()));

                            emailController.clear();
                            senhaController.clear();
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(
      String labelText, TextEditingController controller, IconData prefixIcon,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(prefixIcon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white), // Cor da borda
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white), // Cor da borda
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white), // Cor da borda
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.white), // Cor do texto
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira seu $labelText';
        }
        if (labelText == 'E-mail' && !EmailValidator.validate(value)) {
          return 'E-mail inválido';
        }
        return null;
      },
    );
  }
}
