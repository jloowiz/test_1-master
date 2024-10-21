import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:test_1/models/Jeepney.dart';
import 'package:test_1/models/location.dart';
import 'package:test_1/models/Destination.dart';
import 'package:test_1/models/BarIndicator.dart';
import 'package:test_1/controllers/mapController.dart' as mapControl;
import 'package:test_1/controllers/dropdownController.dart';
import 'package:provider/provider.dart'; // Import provider
import '../models/app_settings.dart'; // Import your AppSettings model

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final GlobalKey<ScaffoldState> _ScreenKey = GlobalKey<ScaffoldState>();
  final MapController mapController = MapController();
  final mapControl.MapController routeControl = mapControl.MapController();
  LocationModel? currentLocation;
  bool isMapReady = false;
  bool isLocationFetched = false;
  List<LatLng> routePoints = [];
  final List<Jeepney> jeepneys = [
    Jeepney("Balibago - Dau Terminal", 20.0, [LatLng(14.6132, 121.0228)]),
    Jeepney("Dau Terminal - SM Clark", 20.0, [LatLng(14.6047, 121.0176)]),
  ];

  void _showLocationServiceDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void getCurrentLocation() async {
    try {
      LocationModel location = await routeControl.getCurrentLocation();

      setState(() {
        currentLocation = location;
        isLocationFetched = true;
      });

      _moveToCurrentLocation();
    } catch (error) {
      _showLocationServiceDialog('Error', error.toString());
    }
  }

  void _moveToCurrentLocation() {
    if (isMapReady && isLocationFetched && currentLocation != null) {
      mapController.move(
        LatLng(currentLocation!.latitude, currentLocation!.longitude),
        18.0,
      );
    }
  }

  void handleSearchSelect(Destination selectedDestination) async {
    if (currentLocation == null) {
      _showLocationServiceDialog('Current Location Not Found',
          'Please fetch your current location first.');
      return;
    }

    mapController.move(
      LatLng(selectedDestination.latitude, selectedDestination.longitude),
      18.0,
    );

    try {
      final route = await routeControl.fetchRoute(
        LatLng(currentLocation!.latitude, currentLocation!.longitude),
        LatLng(selectedDestination.latitude, selectedDestination.longitude),
      );

      setState(() {
        routePoints = route;
      });
    } catch (error) {
      _showLocationServiceDialog(
          'Error', 'Could not fetch route. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appSettings = Provider.of<AppSettings>(context); // Access AppSettings

    return Scaffold(
      key: _ScreenKey,
      body: Stack(
        children: [
          SlidingUpPanel(
            minHeight: 200,
            maxHeight: 300,
            color: Colors.transparent,
            panel: Container(
              decoration: BoxDecoration(
                gradient: appSettings.isDarkMode // Use dark mode gradient if enabled
                    ? const LinearGradient(
                        colors: [Color.fromARGB(255, 0, 1, 85), Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : const LinearGradient( // White background for light mode
                        colors: [Colors.grey, Colors.grey],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BarIndicator(),
                  JeepneyDropdown(jeepneys: jeepneys),
                  StartSearch(onPressed: getCurrentLocation),
                  const EndSearch(),
                ],
              ),
            ),
            body: Stack(
              children: [
                Scaffold(
                  body: Stack(
                    children: [
                      FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          initialCenter: const LatLng(15.143226, 120.592531),
                          initialZoom: 12.44,
                          minZoom: 5.0,
                          maxZoom: 23,
                          onMapReady: () {
                            setState(() {
                              isMapReady = true;
                            });
                            _moveToCurrentLocation();
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://api.mapbox.com/styles/v1/kctiru/cm2c3cdhl009l01poc7xihjc7/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2N0aXJ1IiwiYSI6ImNtMmVhaGxnczBzMmMya3NiZTNmYmc0NGsifQ.X4OpU9Ajb6UvH4DOPneHig',
                            maxNativeZoom: 22,
                          ),
                          LocationMarkerLayer(
                            position: LocationMarkerPosition(
                              latitude: currentLocation?.latitude ?? 0.0,
                              longitude: currentLocation?.longitude ?? 0.0,
                              accuracy: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StartSearch extends StatelessWidget {
  final VoidCallback onPressed;

  const StartSearch({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: const Text('Start Location'),
      ),
    );
  }
}

class EndSearch extends StatelessWidget {
  const EndSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Destination Location',
          labelStyle: TextStyle(color: const Color.fromARGB(179, 255, 255, 255)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
