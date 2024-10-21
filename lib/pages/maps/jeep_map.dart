import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class JeepneyMapPage extends StatelessWidget {
  final String mapUrl;

  const JeepneyMapPage({super.key, required this.mapUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map widget
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(15.141875, 120.592787), // Example coordinates
              initialZoom: 14.07,
            ),
            children: [
              TileLayer(
                urlTemplate: mapUrl, // Use the passed map URL
                maxNativeZoom: 22,
              ),
            ],
          ),

          // Back button at the top-left corner
          Positioned(
            top: 60, // Distance from the top
            left: 20, // Distance from the left
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color.fromARGB(255, 0, 1, 85), Colors.black],
                ),
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove padding to fit text
                ),
                child: const Center(
                  child: Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16, // Adjust font size for better readability
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
