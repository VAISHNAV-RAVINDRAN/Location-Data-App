import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:location_data_app/models/location_model.dart';
import 'package:location_data_app/services/location_service.dart';
import 'package:location_data_app/presentation/pages/map_page.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocationService _service = LocationService();
  List<LocationModel> _locations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    try {
      final data = await _service.getLocations();
      setState(() {
        _locations = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching locations: $e')),
      );
    }
  }

  void _editLocation(LocationModel location) {
    final placeNameController = TextEditingController(text: location.placeName);
    final countryController = TextEditingController(text: location.country);
    final latitudeController = TextEditingController(text: location.latitude.toString());
    final longitudeController = TextEditingController(text: location.longitude.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Edit Location',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: placeNameController,
                decoration: const InputDecoration(
                  labelText: 'Place Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: countryController,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: latitudeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Latitude',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: longitudeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Longitude',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Validate inputs
                  final placeName = placeNameController.text.trim();
                  final country = countryController.text.trim();
                  final latText = latitudeController.text.trim();
                  final longText = longitudeController.text.trim();

                  // Validation checks
                  if (placeName.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Place name is required')),
                    );
                    return;
                  }
                  if (country.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Country is required')),
                    );
                    return;
                  }

                  try {
                    final lat = double.parse(latText);
                    final long = double.parse(longText);
                    
                    // Validate latitude range (-90 to 90)
                    if (lat < -90 || lat > 90) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Latitude must be between -90 and 90')),
                      );
                      return;
                    }
                    
                    // Validate longitude range (-180 to 180)
                    if (long < -180 || long > 180) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Longitude must be between -180 and 180')),
                      );
                      return;
                    }

                    final updatedLocation = LocationModel(
                      id: location.id,
                      placeName: placeName,
                      country: country,
                      latitude: lat,
                      longitude: long,
                    );

                    // Update in backend
                    final success = await _service.updateLocation(updatedLocation);
                    
                    if (success) {
                      // Update in local state
                      setState(() {
                        final index = _locations.indexWhere((loc) => loc.id == location.id);
                        if (index != -1) {
                          _locations[index] = updatedLocation;
                        }
                      });
                      
                      if (mounted) {
                        Navigator.pop(context); // Close bottom sheet
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Location updated successfully')),
                        );
                      }
                    } else {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to update location')),
                        );
                      }
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid input: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Save Changes',style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background to black
      appBar: AppBar(
        title: const Text('Home',style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white,         // Make text visible on black background
          ),),
        backgroundColor: Colors.black,
      ),
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.blue,
                size: 50,
              ),
            )
          : ListView.builder(
              itemCount: _locations.length,
              itemBuilder: (context, index) {
                final location = _locations[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Text(
                      '${index + 1}',
                      style: GoogleFonts.firaSans(fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      '${location.placeName}, ${location.country}',
                      style: GoogleFonts.firaSans(fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editLocation(location),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPage(location: location),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
