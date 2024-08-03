// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, unnecessary_import, unused_field, deprecated_member_use, use_build_context_synchronously, unused_import

import 'package:app_ventos/controller/contr_calc_velo.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_ventos/keys/key.dart';
import 'package:app_ventos/views/Drawer.dart';
import 'package:flutter/services.dart';
import 'package:app_ventos/views/DialogHelp.dart';

class LocalMapScreen extends StatefulWidget {
  const LocalMapScreen({super.key});

  @override
  _LocationMapScreenState createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocalMapScreen> {
  Position? _currentPosition;
  final String _mapUrl = '';
  String? _mapType;
  double? _nearestVelocity;
  String _error = '';
  final bool _isLoading = false;
  final TextEditingController alturaControler = TextEditingController();
  final TextEditingController anguloTetaController = TextEditingController();
  final TextEditingController dtController = TextEditingController();

  bool _showAdditionalFields = false;

  double? _calculatedVelocidade;
  double? _calculatedVelocidadeVD;

  String _selectedFatorS1 = 'Terreno plano ou fracamente acidentado';
  final List<String> fatorS1List = [
    'Terreno plano ou fracamente acidentado',
    'Taludes e morros',
    'Vales profundos'
  ];

  String _selectedcategoryS2 = 'I';
  final List<String> fatorS2Category = ['I', 'II', 'III', 'IV', 'V'];

  String _selectedrajS2 = 'A';
  final List<String> fatorS2raj = ['A', 'B', 'C'];

  String _selectedS3 = '1';
  final List<String> fatorS3 = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndGetLocation();
    Future.microtask(() {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      _mapType = args?['mapType'];
    });
  }

  Future<void> _checkPermissionsAndGetLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          setState(() {
            _error = 'Permissões de localização negadas';
          });
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        setState(() {
          _error =
              'Permissões de localização permanentemente negadas, não podemos solicitar permissões.';
        });
      }
      return;
    }

    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }

      //_sendLocationToAPI(position.latitude, position.longitude);
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Erro ao obter localização: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculo Velocidade Vk Norma',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              HelpDialog.showHelpDialog(context);
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      backgroundColor: Theme.of(context).primaryColor,
      body: _currentPosition == null
          ? const Center()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    buildTextField(alturaControler, 'Altura (z)', Icons.height,
                        const TextInputType.numberWithOptions(decimal: true)),
                    const SizedBox(height: 16),
                    buildDropdownButtonS1(),
                    if (_showAdditionalFields) ...[
                      const SizedBox(height: 16),
                      buildTextField(
                          anguloTetaController,
                          'Ângulo Teta (θ)',
                          Icons.height,
                          const TextInputType.numberWithOptions(decimal: true)),
                      const SizedBox(height: 16),
                      buildTextField(dtController, 'Valor dt', Icons.height,
                          const TextInputType.numberWithOptions(decimal: true)),
                    ],
                    const SizedBox(height: 16),
                    buildDropdownButtonS2cat(),
                    const SizedBox(height: 16),
                    buildDropdownButtonS2raj(),
                    const SizedBox(height: 16),
                    buildDropdownButtonS3(),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () async {
                        final anguloTeta =
                            double.tryParse(anguloTetaController.text) ?? 0;
                        final dt = double.tryParse(dtController.text) ?? 0;

                        VelocityResult? result = await calcVelo(
                          context,
                          _currentPosition?.latitude ?? 0,
                          _currentPosition?.longitude ?? 0,
                          double.parse(alturaControler.text),
                          _selectedFatorS1,
                          anguloTeta,
                          dt,
                          _selectedcategoryS2,
                          _selectedrajS2,
                          _selectedS3,
                          _mapType.toString(),
                        );
                        if (mounted) {
                          setState(() {
                            _calculatedVelocidade = result?.velocity;
                            _calculatedVelocidadeVD = result?.velocityVD;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255)),
                      child: const Text('Calcular',
                          style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(height: 32),
                    if (_calculatedVelocidade != null)
                      Text(
                        'Velocidade Característica: ${_calculatedVelocidade?.toStringAsFixed(2)} m/s',
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 16),
                    if (_calculatedVelocidadeVD != null)
                      Text(
                        'Velocidade para Vedações: ${_calculatedVelocidadeVD?.toStringAsFixed(2)} m/s',
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (_error.isNotEmpty)
                      Text(
                        _error,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      IconData icon, TextInputType keyboardType,
      {bool obscureText = false, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
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
    );
  }

  Widget buildDropdownButtonS1() {
    return DropdownButtonFormField(
      value: _selectedFatorS1,
      icon: const Icon(Icons.terrain, color: Colors.white),
      dropdownColor: Theme.of(context).primaryColor,
      items: fatorS1List.map((String tipo) {
        return DropdownMenuItem(
          value: tipo,
          child: Text(tipo, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedFatorS1 = newValue!;
          _showAdditionalFields = _selectedFatorS1 == 'Taludes e morros';
        });
      },
      decoration: InputDecoration(
          labelText: 'Fator S1',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          labelStyle: const TextStyle(color: Colors.white),
          iconColor: Theme.of(context).colorScheme.secondary),
    );
  }

  Widget buildDropdownButtonS2cat() {
    return DropdownButtonFormField(
      value: _selectedcategoryS2,
      icon: const Icon(Icons.terrain, color: Colors.white),
      dropdownColor: Theme.of(context).primaryColor,
      items: fatorS2Category.map((String tipo) {
        return DropdownMenuItem(
          value: tipo,
          child: Text(tipo, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedcategoryS2 = newValue!;
        });
      },
      decoration: InputDecoration(
          labelText: 'Fator S2 Categoria',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          labelStyle: const TextStyle(color: Colors.white),
          iconColor: Theme.of(context).colorScheme.secondary),
    );
  }

  Widget buildDropdownButtonS2raj() {
    return DropdownButtonFormField(
      value: _selectedrajS2,
      icon: const Icon(Icons.terrain, color: Colors.white),
      dropdownColor: Theme.of(context).primaryColor,
      items: fatorS2raj.map((String tipo) {
        return DropdownMenuItem(
          value: tipo,
          child: Text(tipo, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedrajS2 = newValue!;
        });
      },
      decoration: InputDecoration(
          labelText: 'Fator Rajada S2',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          labelStyle: const TextStyle(color: Colors.white),
          iconColor: Theme.of(context).colorScheme.secondary),
    );
  }

  Widget buildDropdownButtonS3() {
    return DropdownButtonFormField(
      value: _selectedS3,
      icon: const Icon(Icons.terrain, color: Colors.white),
      dropdownColor: Theme.of(context).primaryColor,
      items: fatorS3.map((String tipo) {
        return DropdownMenuItem(
          value: tipo,
          child: Text(tipo, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedS3 = newValue!;
        });
      },
      decoration: InputDecoration(
          labelText: 'Fator Estatistico S3',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          labelStyle: const TextStyle(color: Colors.white),
          iconColor: Theme.of(context).colorScheme.secondary),
    );
  }
}
