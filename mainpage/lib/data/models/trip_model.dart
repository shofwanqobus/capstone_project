class TripModel {
  List<TripItemsModel> trip;

  TripModel({required this.trip});

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        trip: List<TripItemsModel>.from(
          (json["trips"] as List).map((x) => TripItemsModel.fromJson(x)).where(
              (tripItems) =>
                  tripItems.id != null &&
                  tripItems.name != null &&
                  tripItems.photoUrl != null &&
                  tripItems.description != null &&
                  tripItems.location != null &&
                  tripItems.price != null &&
                  tripItems.rating != null),
        ),
      );

  Map<String, dynamic> toJson() => {
        "trips": List<dynamic>.from(
          trip.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class TripItemsModel {
  int id;
  String name;
  String? photoUrl;
  String description;
  String location;
  int price;
  double? rating;

  TripItemsModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.location,
    required this.price,
    required this.rating,
  });

  factory TripItemsModel.fromJson(Map<String, dynamic> json) => TripItemsModel(
        id: json["id"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        description: json["description"],
        location: json["location"],
        price: json["price"].toInt() as int,
        rating: json["rating"],
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
