// ignore_for_file: unused_element, prefer_const_declarations, deprecated_member_use, use_build_context_synchronously, depend_on_referenced_packages, file_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final String urlNorma = 'https://online.fliphtml5.com/ffdkue/otlz/';

void _launchURL(BuildContext context) async {
  try {
    await launch(urlNorma);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Não foi possível abrir o link.'),
      ),
    );
  }
}

class HelpDialog {
  static void showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Ajuda',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informações sobre a realização do cálculo:',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. Fator S1 é o fator topográfico, se for selecionado "Taludes e morros" será necessário informar o valor do ângulo teta e da altura dt.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Altura (z): é a altura medida a partir da superfície do terreno no ponto considerado.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ângulo Teta (θ): é a inclinação média do talude ou encosta do morro.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Altura dt: é a diferença de nível entre a base e o topo do talude ou morro.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '2. Utilize o campo "Fator S2" para selecionar a categoria da rugosidade do terreno e a seguir será explicado cada categoria que são cinco.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Categoria I: superfícies lisas de grandes dimensões, com mais de 5 km de extensão, medida na direção e sentido do vento incidente;',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 6),
                  Text(
                    ' EXEMPLOS: mar calmo, lagos, rios e pântanos sem vegetação',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Categoria II: terrenos abertos, em nível ou aproximadamente em nível, com poucos obstáculos isolados, tais como árvores e edifcações baixas;',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 6),
                  Text(
                    ' EXEMPLOS: zonas costeiras planas, pântanos com vegetação rala, campos de aviação, pradarias, charnecas e fazendas sem sebes ou muros.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Categoria III: terrenos planos ou ondulados com obstáculos, como sebes e muros, poucos quebra-ventos de árvores, edifcações baixas e esparsas;',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 6),
                  Text(
                    ' EXEMPLOS: granjas e casas de campo, com exceção das partes com matos, fazendas com sebes e/ou muros, subúrbios a considerável distância do centro, com casas baixas e esparsas.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Categoria IV: terrenos cobertos por obstáculos numerosos e pouco espaçados, em zona forestal, industrial ou urbanizada; ',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 6),
                  Text(
                    ' EXEMPLOS: zonas de parques e bosques com muitas árvores, cidades pequenas e seus arredores, subúrbios densamente construídos de grandes cidades, áreas industriais plena ou parcialmente desenvolvidas.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Categoria V: terrenos cobertos por obstáculos numerosos, grandes, altos e poucos espaçados.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 6),
                  Text(
                    ' EXEMPLOS: forestas com árvores altas de copas isoladas, centros de grandes cidades, complexos industriais bem desenvolvidos.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '2.1 Utilize o campo "Fator Rajada S2" para selecionar a classe da estrutura ou edificação, a seguir explicação de cada classe',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Classe A: toda edifcação, estrutura, parte de edifcação ou de estrutura, unidades e sistemas de vedação e seus elementos de fxação, cuja maior dimensão vertical ou horizontal não exceda 20 m;',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Classe B: toda edificação, estrutura, ou parte de edificação e estrutura, cuja maior dimensão horizontal ou vertical da superfície frontal seja maior do que 20 m e menor ou igual a 50 m;',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Classe C: toda edificação, estrutura ou parte de edificação e estrutura, cuja maior dimensão horizontal ou vertical da superfície frontal exceda 50 m.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '3. Utilize o campo "Fator Estatístico S3" para selecionar o grupo da estrutura, a seguir explicação de cada grupo.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Grupo 1: Estruturas cuja ruína total ou parcial pode afetar a segurança ou possibilidade de socorro a pessoas após uma tempestade destrutiva (hospitais, quartéis de bombeiros e de forças de segurança, edifícios de centrais de controle, etc.). Pontes rodoviárias e ferroviárias. Estruturas que abrigam substâncias infamáveis, tóxicas e/ou explosivas.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Grupo 2: Estruturas cuja ruína represente substancial risco à vida humana, particularmente a pessoas em aglomerações, crianças e jovens, incluindo, mas não limitado a: edifcações com capacidade de aglomeração de mais de 300 pessoas em um mesmo ambiente, como centros de convenções, ginásios, estádios etc. creches com capacidade maior do que 150 pessoas; escolas com capacidade maior do que 250 pessoas;',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Grupo 3: Edifcações para residências, hotéis, comércio, indústrias. Estruturas ou elementos estruturais desmontáveis com vistas a reutilização.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Grupo 4: Edifcações não destinadas à ocupação humana (depósitos, silos) e sem circulação de pessoas no entorno.',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Grupo 5: Edifcações temporárias não reutilizáveis',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Caso apresente alguma dúvida, consulte a norma clicando em "Visitar NBR 6123"!',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Visitar NBR 6123',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => _launchURL(context),
            ),
            TextButton(
              child:
                  const Text('Fechar', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
