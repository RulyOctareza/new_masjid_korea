class MasjidLocalModel {
  int id;
  String name;
  String imageUrl;

  String city;
  String country;
  int rating;
  String address;
  String phone;
  String mapUrl;
  List photos;
  String kitchens;
  String bedrooms;
  String bathrooms;

  MasjidLocalModel({
    required this.city,
    required this.country,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.address,
    required this.mapUrl,
    required this.kitchens,
    required this.bedrooms,
    required this.bathrooms,
    required this.phone,
    required this.photos,
  });
}
