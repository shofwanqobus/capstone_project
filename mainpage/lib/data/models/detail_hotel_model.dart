import 'package:equatable/equatable.dart';

class DetailHotelModel extends Equatable {
  DetailItem detail;

  DetailHotelModel({required this.detail});

  factory DetailHotelModel.fromJson(Map<String, dynamic> json) =>
      DetailHotelModel(
        detail: DetailItem.fromJson(json["hotels"]),
      );

  Map<String, dynamic> toJson() => {
        "hotels": detail.toJson(),
      };

  @override
  List<Object?> get props => [DetailItem];
}

class DetailItem extends Equatable {
  String id;
  String name;
  String? photoUrl;
  String description;
  String address;
  int price;
  double rating;
  List<AccomodationsModel> accomodations;

  DetailItem({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.address,
    required this.price,
    required this.rating,
    required this.accomodations,
  });

  factory DetailItem.fromJson(Map<String, dynamic> json) => DetailItem(
        id: json["id"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        description: json["description"],
        address: json["address"],
        price: json["price"].toInt() as int,
        rating: json["rating"].toDouble() as double,
        accomodations: List<AccomodationsModel>.from(
          json["accomodations"].map(
            (x) => AccomodationsModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photoUrl": photoUrl,
        "description": description,
        "address": address,
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
        address,
        price,
        rating,
        accomodations,
      ];
}

class AccomodationsModel extends Equatable {
  final String accomodations;

  const AccomodationsModel({required this.accomodations});

  factory AccomodationsModel.fromJson(Map<String, dynamic> json) =>
      AccomodationsModel(
        accomodations: json["accomodations"],
      );

  Map<String, dynamic> toJson() => {
        "accomodations": accomodations,
      };

  @override
  List<Object?> get props => [accomodations];
}
