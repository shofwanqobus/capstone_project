import 'package:equatable/equatable.dart';
import 'package:mainpage/domain/entities/hotel.dart';

class HotelModel extends Equatable {
  List<HotelItemsModel> hotelItemsModel;

  HotelModel({required this.hotelItemsModel});

  factory HotelModel.fromJson(Map<String, dynamic> hotel) => HotelModel(
        hotelItemsModel: List<HotelItemsModel>.from(
          hotel["hotels"].map(
            (x) => HotelItemsModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "hotels": List<dynamic>.from(
          hotelItemsModel.map(
            (x) => x.toJson(),
          ),
        ),
      };

  Hotel toEntity() {
    return Hotel(hotelItems: const []);
  }

  @override
  List<Object?> get props => [hotelItemsModel];
}

class HotelItemsModel extends Equatable {
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

  @override
  List<Object?> get props => [
        id,
        name,
        photoUrl,
        description,
        address,
        price,
        rating,
      ];
}
