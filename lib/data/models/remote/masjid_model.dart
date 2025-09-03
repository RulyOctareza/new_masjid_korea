import 'package:equatable/equatable.dart';

class MasjidModel extends Equatable {
  final String id;
  final String name;
  final String city;
  final String imageUrl;
  final double rating;
  final String kitchen;
  final String bedroom;
  final String lemari;
  final String location;
  final String address;
  final List<String> photos;
  final String comunity;
  final double latitude;
  final double longitude;

  const MasjidModel({
    required this.id,
    this.name = '',
    this.city = '',
    this.imageUrl = '',
    this.rating = 0.0,
    this.bedroom = '',
    this.kitchen = '',
    this.lemari = '',
    this.location = '',
    this.address = '',
    this.photos = const [],
    this.comunity = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  factory MasjidModel.fromJson(String id, Map<String, dynamic> json) =>
      MasjidModel(
        id: id,
        name: json['name'] ?? '',
        city: json['city'] ?? '',
        location: json['location'] ?? '',
        address: json['address'] ?? '',
        rating: _parseDouble(json['rating']),
        imageUrl: json['imageUrl'] ?? '',
        photos: _parsePhotos(json),
        comunity: json['comunity'] ?? '',
        latitude: _parseDouble(json['latitude']),
        longitude: _parseDouble(json['longitude']),
      );
      
  // Helper method untuk mengkonversi nilai ke double dengan aman
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (_) {
        return 0.0;
      }
    }
    return 0.0;
  }
  
  // Helper method untuk mengekstrak photos dengan aman
  static List<String> _parsePhotos(Map<String, dynamic> json) {
    try {
      if (json['photos'] is List) {
        return List<String>.from(json['photos'].map((item) => item?.toString() ?? ''));
      } else {
        return json.entries
          .where((entry) => entry.key.startsWith('photo') && entry.value != null && entry.value.toString().isNotEmpty)
          .map((entry) => entry.value.toString())
          .toList();
      }
    } catch (_) {
      return [];
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'city': city,
    'imageUrl': imageUrl,
    'rating': rating,
    'location': location,
    'address': address,
    'photos': photos,
    'comunity': comunity,
    'latitude': latitude,
    'longitude': longitude,
  };

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    city,
    imageUrl,
    rating,
    kitchen,
    bedroom,
    lemari,
    photos,
    comunity,
    latitude,
    longitude,
  ];
}
