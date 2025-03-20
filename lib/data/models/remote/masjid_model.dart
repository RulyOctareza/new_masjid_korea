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
        name: json['name'],
        city: json['city'],
        location: json['location'],
        address: json['address'],
        rating: json['rating'].toDouble(),
        imageUrl: json['imageUrl'],
        photos: json.entries
          .where((entry) => entry.key.startsWith('photo') && entry.value.isNotEmpty)
          .map((entry) => entry.value as String)
          .toList(),
        comunity: json['comunity'],
        latitude: json['latitude'],
        longitude: json['longitude'],
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
