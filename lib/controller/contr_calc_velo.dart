// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_ventos/keys/key.dart';

Future<double?> calcVelo(
    BuildContext context,
    double latitude,
    double longitude,
    double alturaz,
    String fatorS1,
    double anguloTeta,
    double dt,
    String categorias2,
    String rajadas2,
    String fators3) async {
  try {
    final response =
        await http.post(Uri.parse('$key_server/calc_velocidade'), body: {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'altura': alturaz.toString(),
      'fatorS1': fatorS1,
      'anguloTeta': anguloTeta.toString(),
      'dt': dt.toString(),
      'categoriaS2': categorias2,
      'rajadaS2': rajadas2,
      'fatorS3': fators3,
      'map_type': 'isopleta_nbr_calc',
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['velocity'];
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não autorizado'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    } else if (response.statusCode == 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro interno do servidor'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro desconhecido: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erro na requisição HTTP: $error'),
        backgroundColor: Colors.red,
      ),
    );
    return null;
  }
}
