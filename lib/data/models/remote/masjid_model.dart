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
        rating: (json['rating'] == null) ? 0.0 : (json['rating'] is double ? json['rating'] : double.tryParse(json['rating'].toString()) ?? 0.0),
        imageUrl: json['imageUrl'] ?? '',
        photos: (json['photos'] is List)
          ? List<String>.from(json['photos'])
          : [],
        comunity: json['comunity'] ?? '',
        latitude: (json['latitude'] == null) ? 0.0 : (json['latitude'] is double ? json['latitude'] : double.tryParse(json['latitude'].toString()) ?? 0.0),
        longitude: (json['longitude'] == null) ? 0.0 : (json['longitude'] is double ? json['longitude'] : double.tryParse(json['longitude'].toString()) ?? 0.0),
      );

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
