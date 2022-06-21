class HotelModel {
  List<HotelItemsModel> hotelItemsModel;

  HotelModel({required this.hotelItemsModel});

  factory HotelModel.fromJson(Map<String, dynamic> hotel) => HotelModel(
        hotelItemsModel: List<HotelItemsModel>.from(
          (hotel["hotels"] as List)
              .map((x) => HotelItemsModel.fromJson(x))
              .where((hotelItems) =>
                  hotelItems.id != null &&
                  hotelItems.name != null &&
                  hotelItems.photoUrl != null &&
                  hotelItems.description != null &&
                  hotelItems.address != null &&
                  hotelItems.price != null &&
                  hotelItems.address != null),
        ),
      );

  Map<String, dynamic> toJson() => {
        "hotels": List<dynamic>.from(
          hotelItemsModel.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class HotelItemsModel {
  String id;
  String name;
  String? photoUrl;
  String description;
  String address;
  int price;
  double rating;

  HotelItemsModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.address,
    required this.price,
    required this.rating,
  });

  factory HotelItemsModel.fromJson(Map<String, dynamic> json) =>
      HotelItemsModel(
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
