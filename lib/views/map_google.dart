// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSelectionScreen extends StatefulWidget {
  final Function(double latitude, double longitude) onLocationSelected;

  const MapSelectionScreen({required this.onLocationSelected, Key? key})
      : super(key: key);

  @override
  _MapSelectionScreenState createState() => _MapSelectionScreenState();
}

class _MapSelectionScreenState extends State<MapSelectionScreen> {
  late GoogleMapController mapController;
  LatLng selectedLocation = const LatLng(-14.235004, -51.92528);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedLocation,
              zoom: 4,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            onTap: (LatLng location) {
              setState(() {
                selectedLocation = location;
              });
            },
            markers: {
              Marker(
                markerId: const MarkerId('selectedLocation'),
                position: selectedLocation,
              ),
            },
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close,
                  color: Color.fromARGB(255, 255, 0, 0), size: 30),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha a tela
              },
            ),
          ),
          Positioned(
            bottom: 13,
            left: 13,
            child: ElevatedButton(
              onPressed: () {
                widget.onLocationSelected(
                    selectedLocation.latitude, selectedLocation.longitude);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 0, 148, 7), // Cor de fundo
                foregroundColor: Colors.white, // Cor do texto
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
              child: const Icon(Icons.check),
            ),
          ),
        ],
      ),
    );
  }
}
