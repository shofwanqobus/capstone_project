import 'package:equatable/equatable.dart';

class Hotel extends Equatable {
  List<HotelItems> hotelItems;

  Hotel({required this.hotelItems});

  @override
  List<Object?> get props => [hotelItems];
}

class HotelItems extends Equatable {
  String id;
  String name;
  String? photoUrl;
  String description;
  String address;
  int price;
  double rating;
  List<Accomodations> accomodations;

  HotelItems({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.address,
    required this.price,
    required this.rating,
    required this.accomodations,
  });

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

class Accomodations extends Equatable {
  final String accomodations;

  Accomodations({required this.accomodations});

  @override
  List<Object?> get props => [accomodations];
}
