class DetailTripModel {
  TripItems trip;

  DetailTripModel({required this.trip});

  factory DetailTripModel.fromJson(Map<String, dynamic> json) =>
      DetailTripModel(
        trip: TripItems.fromJson(json["trips"]),
      );

  Map<String, dynamic> toJson() => {
        "hotels": trip.toJson(),
      };
}

class TripItems {
  int id;
  String name;
  String? photoUrl;
  String description;
  String location;
  int price;
  double rating;

  TripItems({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.location,
    required this.price,
    required this.rating,
  });

  factory TripItems.fromJson(Map<String, dynamic> json) => TripItems(
        id: json["id"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        description: json["description"],
        location: json["location"],
        price: json["price"].toInt() as int,
        rating: json["rating"].toDouble() as double,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photoUrl": photoUrl,
        "description": description,
        "location": location,
        "price": price,
        "rating": rating,
      };
}
