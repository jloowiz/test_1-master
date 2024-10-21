import 'package:flutter/material.dart';
import 'package:test_1/pages/maps/jeep_map.dart';

class JeepneysPage extends StatefulWidget {
  const JeepneysPage({super.key});

  @override
  _JeepneysPageState createState() => _JeepneysPageState();
}

class _JeepneysPageState extends State<JeepneysPage> {
  String selectedStatus = 'None';

  final List<Map<String, dynamic>> jeepneys = [
    {
      'name': 'Purple',
      'description': 'Route: CHECKPOINT - Holy - Highway, Capacity: 16',
      'terminal': 'Astro Terminal',
      'fare': 10.0,
      'image': 'assets/images/purple_jeepney.png',
      'mapUrl': 'https://api.mapbox.com/styles/v1/kctiru/cm2hzhwp500ke01po5xal4ajg/tiles/256/{z}/{x}/{y}@2x?access_token=YOUR_ACCESS_TOKEN',
      'isExpanded': false,
    },
    {
      'name': 'Yellow',
      'description': 'Route: Villa Pampang - SM Telebastagan, Capacity: 18',
      'terminal': 'Villa Pampang Terminal',
      'fare': 12.0,
      'image': 'assets/images/yellow_jeepney.png',
      'mapUrl': 'https://api.mapbox.com/styles/v1/kctiru/cm2iolxi800mh01po85al34l7/tiles/256/{z}/{x}/{y}@2x?access_token=YOUR_ACCESS_TOKEN',
      'isExpanded': false,
    },
    {
      'name': 'Green',
      'description': 'Route: Marisol - Pampang, Capacity: 15',
      'terminal': 'Marisol Terminal',
      'fare': 11.0,
      'image': 'assets/images/green_jeepney.png',
      'mapUrl': 'https://api.mapbox.com/styles/v1/kctiru/cm2hzi2dn003x01pl13lu1xv5/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2N0aXJ1IiwiYSI6ImNtMmVhaGxnczBzMmMya3NiZTNmYmc0NGsifQ.X4OpU9Ajb6UvH4DOPneHig',
      'isExpanded': false,
    },
    {
      'name': 'Brown',
      'description': 'Route: Main Gate - Friendship, Capacity: 20',
      'terminal': 'Main Gate Terminal',
      'fare': 13.0,
      'image': 'assets/images/brown_jeepney.png',
      'mapUrl' : 'https://api.mapbox.com/styles/v1/kctiru/cm2ip3uad006801py86eygnoe/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2N0aXJ1IiwiYSI6ImNtMmVhaGxnczBzMmMya3NiZTNmYmc0NGsifQ.X4OpU9Ajb6UvH4DOPneHig',
      'isExpanded': false,
    },
  ];

  void _toggleExpansion(int index) {
    setState(() {
      jeepneys[index]['isExpanded'] = !jeepneys[index]['isExpanded'];
    });
  }

  void _showRoute(String mapUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JeepneyMapPage(mapUrl: mapUrl), // Pass the map URL
      ),
    );
  }

  double _calculateFare(double fare) {
    switch (selectedStatus) {
      case 'Student':
      case 'Senior Citizen':
        return fare - 2;
      default:
        return fare;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark; // Check if dark mode is enabled

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Color.fromARGB(255, 0, 1, 85), Colors.black]
                : [Colors.white, Colors.grey.shade200], // Change based on theme
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: jeepneys.length,
            itemBuilder: (context, index) {
              final jeepney = jeepneys[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut, 
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow:  [
                      BoxShadow(
                        color: isDarkMode ? Color.fromARGB(255, 2, 0, 94):const Color.fromARGB(255, 189, 188, 188),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _toggleExpansion(index),
                        child: Row(
                          children: [
                            Container(
                              height: 200, 
                              width: 200, 
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(jeepney['image']),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10), 
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jeepney['name'],
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    jeepney['terminal'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              jeepney['isExpanded']
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: const Color.fromARGB(255, 59, 59, 59),
                              size: 35, 
                            ),
                          ],
                        ),
                      ),
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        firstChild: Container(),
                        secondChild: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                jeepney['description'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Select Discount:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ChoiceChip(
                                    label: const Text(
                                      'Student',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    selected: selectedStatus == 'Student',
                                    onSelected: (bool selected) {
                                      setState(() {
                                        selectedStatus = selected ? 'Student' : 'None';
                                      });
                                    },
                                    selectedColor: Colors.transparent,
                                    backgroundColor: Colors.transparent, 
                                    side: const BorderSide(
                                      color: Colors.blueGrey, 
                                    ),
                                  ),
                                  ChoiceChip(
                                    label: const Text(
                                      'Senior Citizen',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    selected: selectedStatus == 'Senior Citizen',
                                    onSelected: (bool selected) {
                                      setState(() {
                                        selectedStatus = selected ? 'Senior Citizen' : 'None';
                                      });
                                    },
                                    selectedColor: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                    side: const BorderSide(
                                      color: Colors.blueGrey, 
                                    ),
                                  ),
                                  ChoiceChip(
                                    label: const Text(
                                      'None',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    selected: selectedStatus == 'None',
                                    onSelected: (bool selected) {
                                      setState(() {
                                        selectedStatus = selected ? 'None' : selectedStatus;
                                      });
                                    },
                                    selectedColor: Colors.transparent,
                                    backgroundColor: Colors.transparent, 
                                    side: const BorderSide(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Fare: ₱${_calculateFare(jeepney['fare']).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () => _showRoute(jeepney['mapUrl']),
                                child: Text(
                                  'Show Route',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.blueAccent : Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        crossFadeState: jeepney['isExpanded']
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
