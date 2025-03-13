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
  final String photos1;
  final String photos2;
  final String photos3;
  final String photos4;
  final String photos5;
  final String photos6;
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
    this.photos1 = '',
    this.photos2 = '',
    this.photos3 = '',
    this.photos4 = '',
    this.photos5 = '',
    this.photos6 = '',
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
        photos1: json['photos1'],
        photos2: json['photos2'],
        photos3: json['photos3'],
        photos4: json['photos4'],
        photos5: json['photos5'],
        photos6: json['photos6'],
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
    'photos1': photos1,
    'photos2': photos2,
    'photos3': photos3,
    'photos4': photos4,
    'photos5': photos5,
    'photos6': photos6,
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
    photos1,
    photos2,
    photos3,
    photos4,
    photos5,
    photos6,
    comunity,
    latitude,
    longitude,
  ];
}
