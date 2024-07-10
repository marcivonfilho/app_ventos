// ignore_for_file: depend_on_referenced_packages, use_super_parameters, deprecated_member_use, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Drawer.dart';

class HistoricoNorma extends StatelessWidget {
  const HistoricoNorma({Key? key}) : super(key: key);

  final String urlNorma =
      'https://online.fliphtml5.com/ffdkue/otlz/'; // URL para visualização detalhada

  void _launchURL(BuildContext context) async {
    try {
      await launch(urlNorma);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível abrir o link.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Histórico da Norma NBR 6123',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: CustomDrawer(),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text:
                    'A Norma NBR 6123 é uma referência fundamental para a engenharia civil e outras disciplinas, fornecendo diretrizes e padrões para a construção e segurança. Esta norma aborda principalmente as condições de vento e seus efeitos sobre estruturas. Desde sua primeira publicação, passou por várias revisões e atualizações para incorporar novos conhecimentos e tecnologias.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white60,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            buildTextSection(
              'Evolução da Norma',
              'A primeira versão da NBR 6123 foi publicada em 1988 e focava nas cargas de vento para edificações. Ao longo dos anos, a norma foi revisada para incluir novos métodos de cálculo e considerações sobre diferentes tipos de estruturas.',
            ),
            buildTextSection(
              'Principais Atualizações',
              'As atualização mais recente da norma foi em 20 de dezembro de 2023 que incluem novos critérios para análise de estruturas mais complexas e a consideração de mudanças climáticas que podem afetar as cargas de vento.',
            ),
            buildTextSection(
              'Importância da Norma',
              'A NBR 6123 é crucial para garantir a segurança e a durabilidade das edificações, especialmente em regiões sujeitas a ventos fortes. O cumprimento desta norma ajuda a prevenir falhas estruturais e a proteger vidas.',
            ),
            ElevatedButton(
              onPressed: () => _launchURL(context),
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
              child: const Text('Visualizar mais detalhes',
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white60,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
