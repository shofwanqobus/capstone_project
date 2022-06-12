import 'package:equatable/equatable.dart';

class PlaneTicket extends Equatable {
  List<PlaneTicketItems> tickets;

  PlaneTicket({required this.tickets});

  @override
  List<Object?> get props => [tickets];
}

class PlaneTicketItems extends Equatable {
  String id;
  String? name;
  String? photoUrl;
  String? routes;
  String? location;
  int? price;

  PlaneTicketItems({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.routes,
    required this.location,
    required this.price,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        photoUrl,
        routes,
        location,
        price,
      ];
}
