import 'package:equatable/equatable.dart';
import 'package:mainpage/domain/entities/trip.dart';

class TripModel extends Equatable {
  List<TripItemsModel> trip;

  TripModel({required this.trip});

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        trip: List<TripItemsModel>.from(
          json["trips"].map(
            (x) => TripItemsModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "trips": List<dynamic>.from(
          trip.map(
            (x) => x.toJson(),
          ),
        ),
      };

  Trip toEntity() {
    return Trip(trip: const []);
  }

  @override
  List<Object?> get props => [trip];
}

class TripItemsModel extends Equatable {
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

  @override
  List<Object?> get props => [
        id,
        name,
        photoUrl,
        description,
        location,
        price,
        rating,
      ];
}
