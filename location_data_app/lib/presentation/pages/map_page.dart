import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_data_app/models/location_model.dart';

class MapPage extends StatelessWidget {
  final LocationModel location;
  const MapPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final latLng = LatLng(location.latitude, location.longitude);
    return Scaffold(
      appBar: AppBar(
        title: Text(location.placeName),
        backgroundColor: Colors.transparent,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: latLng,
          zoom: 11.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.location_data_app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: latLng,
                width: 80,
                height: 80,
                child: Icon(Icons.location_on, color: Colors.red, size: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}