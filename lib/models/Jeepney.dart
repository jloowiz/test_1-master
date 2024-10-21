import 'package:latlong2/latlong.dart';

class Jeepney {
  final String jeepneyName;
  final double fare;
  final List<LatLng> polyline;

  Jeepney(this.jeepneyName, this.fare, this.polyline);
}