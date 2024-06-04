// ignore_for_file: depend_on_referenced_packages, camel_case_types, library_private_types_in_public_api, avoid_print, use_rethrow_when_possible, prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:app_ventos/keys/key.dart';
import 'package:app_ventos/views/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class mapPROP extends StatefulWidget {
  const mapPROP({super.key});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<mapPROP> {
  Future<http.Response>? _futureImage;

  @override
  void initState() {
    super.initState();
    _futureImage = fetchImage();
  }

  Future<http.Response> fetchImage() async {
    try {
      print('Fetching image...');
      final response = await http
          .get(Uri.parse('${key_server}/img_isopleta?map_type=isopleta_prop'));
      if (response.statusCode == 200) {
        print('Image fetched successfully');
        return response;
      } else {
        print('Failed to fetch image with status: ${response.statusCode}');
        throw Exception('Failed to load image');
      }
    } catch (error) {
      print('Error fetching image: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mapa Isopletas Proposta',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: CustomDrawer(),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: FutureBuilder<http.Response>(
          future: _futureImage,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('Waiting for the image to load...');
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print('Error occurred: ${snapshot.error}');
              return Text('Error: ${snapshot.error}');
            } else {
              print('Image loaded successfully');
              return Image.memory(snapshot.data!.bodyBytes);
            }
          },
        ),
      ),
    );
  }
}
