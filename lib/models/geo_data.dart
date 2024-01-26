class GeoData {
  final double latitude;
  final double longitude;

  const GeoData({
    required this.latitude,
    required this.longitude
  });

  factory GeoData.fromJson(Map<String, dynamic> json) {
    return GeoData(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double
    );
  }
}