// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, unnecessary_import

import 'package:app_ventos/controller/contr_caduser.dart';
import 'package:app_ventos/models/user.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';

class CadastroUser extends StatefulWidget {
  const CadastroUser({super.key});

  @override
  _CadastroUserState createState() => _CadastroUserState();
}

class _CadastroUserState extends State<CadastroUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController sobrenomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  String tipoUsuarioSelecionado = 'Estudante';
  final List<String> tiposUsuario = [
    'Estudante',
    'Professor',
    'Engenheiro',
    'Outro'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor:
            const Color.fromARGB(255, 44, 44, 44), // Cor de fundo da tela,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          onPressed: () {
            Navigator.pop(context); // Retorna para a tela de login
          },
        ),
      ),
      backgroundColor:
          const Color.fromARGB(255, 44, 44, 44), // Cor de fundo da tela
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextField(nomeController, 'Nome', Icons.person),
              const SizedBox(height: 16),
              buildTextField(sobrenomeController, 'Sobrenome', Icons.person),
              const SizedBox(height: 16),
              buildTextField(
                emailController,
                'E-mail',
                Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              buildTextField(senhaController, 'Senha', Icons.lock,
                  obscureText: true),
              const SizedBox(height: 16),
              buildDropdownButton(),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // A validação passou, processar os dados aqui

                    Usuario novoUser = Usuario(
                        nome: nomeController.text,
                        sobrenome: sobrenomeController.text,
                        email: emailController.text,
                        senha: senhaController.text,
                        tipoUsuario: tipoUsuarioSelecionado);

                    cadUser(context, novoUser);
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
                child: const Text('Cadastrar',
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      TextEditingController controller, String labelText, IconData icon,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon:
              Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        style: const TextStyle(color: Colors.white), // Cor do texto
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira seu $labelText';
          }
          if (labelText == 'E-mail' && !EmailValidator.validate(value)) {
            return 'E-mail inválido';
          }
          return null;
        });
  }

  Widget buildDropdownButton() {
    return DropdownButtonFormField(
      value: tipoUsuarioSelecionado,
      // ignore: prefer_const_constructors
      dropdownColor: const Color.fromARGB(255, 44, 44, 44),
      items: tiposUsuario.map((String tipo) {
        return DropdownMenuItem(
          value: tipo,
          child: Text(tipo,
              style:
                  const TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          tipoUsuarioSelecionado = newValue!;
        });
      },
      decoration: InputDecoration(
        labelText: 'Tipo de usuário',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        labelStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }
}
