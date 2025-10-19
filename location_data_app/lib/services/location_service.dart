import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:location_data_app/models/location_model.dart';

class LocationService {
  // Server URL based on where the app is running
  static String get baseUrl {
    // Use localhost for web browsers
    if (kIsWeb) return 'http://localhost:3000';
    // Use special Android emulator host
    return 'http://10.0.2.2:3000';
  }

  Future<List<LocationModel>> getLocations() async {
    final response = await http.get(Uri.parse('${baseUrl}/locations'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => LocationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<bool> updateLocation(LocationModel location) async {
    final response = await http.put(
      Uri.parse('${baseUrl}/locations/${location.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(location.toJson()),
    );

    return response.statusCode == 200;
  }
}
