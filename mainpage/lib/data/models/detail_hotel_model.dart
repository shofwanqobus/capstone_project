class DetailHotelModel {
  DetailItem detail;

  DetailHotelModel({required this.detail});

  factory DetailHotelModel.fromJson(Map<String, dynamic> json) =>
      DetailHotelModel(
        detail: DetailItem.fromJson(json["hotels"]),
      );

  Map<String, dynamic> toJson() => {
        "hotels": detail.toJson(),
      };
}

class DetailItem {
  String id;
  String name;
  String? photoUrl;
  String description;
  String address;
  int price;
  double rating;

  DetailItem({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.address,
    required this.price,
    required this.rating,
  });

  factory DetailItem.fromJson(Map<String, dynamic> json) => DetailItem(
        id: json["id"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        description: json["description"],
        address: json["address"],
        price: json["price"].toInt() as int,
        rating: json["rating"].toDouble() as double,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photoUrl": photoUrl,
        "description": description,
        "address": address,
        "price": price,
        "rating": rating,
      };
}
