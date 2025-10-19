class LocationModel {
  int id;
  String placeName;
  String country;
  double latitude;
  double longitude;

  LocationModel({
    required this.id,
    required this.placeName,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] is String ? int.parse(json['id']) : json['id'] as int,
      placeName: json['place_name'] as String,
      country: json['country'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'place_name': placeName,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
