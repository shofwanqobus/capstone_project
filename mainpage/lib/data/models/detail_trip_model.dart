import 'package:equatable/equatable.dart';

class DetailTripModel extends Equatable {
  TripItems trip;

  DetailTripModel({required this.trip});

  factory DetailTripModel.fromJson(Map<String, dynamic> json) =>
      DetailTripModel(
        trip: TripItems.fromJson(json["trips"]),
      );

  Map<String, dynamic> toJson() => {
        "hotels": trip.toJson(),
      };

  @override
  List<Object?> get props => [trip];
}

class TripItems extends Equatable {
  int id;
  String name;
  String? photoUrl;
  String description;
  String location;
  int price;
  double rating;
  List<Accomodations> accomodations;

  TripItems({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.location,
    required this.price,
    required this.rating,
    required this.accomodations,
  });

  factory TripItems.fromJson(Map<String, dynamic> json) => TripItems(
        id: json["id"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        description: json["description"],
        location: json["location"],
        price: json["price"].toInt() as int,
        rating: json["rating"].toDouble() as double,
        accomodations: List<Accomodations>.from(
          json["accomodations"].map(
            (x) => Accomodations.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photoUrl": photoUrl,
        "description": description,
        "location": location,
        "price": price,
        "rating": rating,
        "accomodations": List<dynamic>.from(
          accomodations.map(
            (x) => x.toJson(),
          ),
        ),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        photoUrl,
        description,
        location,
        price,
        rating,
        accomodations,
      ];
}

class Accomodations extends Equatable {
  String accomodations;

  Accomodations({required this.accomodations});

  factory Accomodations.fromJson(Map<String, dynamic> json) => Accomodations(
        accomodations: json["accomodations"],
      );

  Map<String, dynamic> toJson() => {
        "accomodations": accomodations,
      };

  @override
  List<Object?> get props => [accomodations];
}
