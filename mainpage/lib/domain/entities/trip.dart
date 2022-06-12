import 'package:equatable/equatable.dart';

class Trip extends Equatable {
  List<TripItems> trip;

  Trip({required this.trip});

  @override
  List<Object?> get props => [trip];
}

class TripItems extends Equatable {
  int id;
  String? name;
  String? photoUrl;
  String? description;
  String? location;
  int? price;
  double? rating;
  List<Accomodations>? accomodations;

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
  String? accomodations;

  Accomodations({required this.accomodations});

  @override
  List<Object?> get props => [accomodations];
}
