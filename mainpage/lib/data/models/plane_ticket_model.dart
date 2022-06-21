class PlaneTicketModel {
  List<PlaneTicketItems> tickets;

  PlaneTicketModel({required this.tickets});

  factory PlaneTicketModel.fromJson(Map<String, dynamic> json) =>
      PlaneTicketModel(
        tickets: List<PlaneTicketItems>.from(
          (json["tickets"] as List)
              .map((x) => PlaneTicketItems.fromJson(x))
              .where((ticketItems) =>
                  ticketItems.id != null &&
                  ticketItems.name != null &&
                  ticketItems.photoUrl != null &&
                  ticketItems.routes != null &&
                  ticketItems.location != null &&
                  ticketItems.price != null),
        ),
      );

  Map<String, dynamic> toJson() => {
        "tickets": List<dynamic>.from(
          tickets.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class PlaneTicketItems {
  String id;
  String name;
  String? photoUrl;
  String routes;
  String location;
  int? price;

  PlaneTicketItems({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.routes,
    required this.location,
    required this.price,
  });

  factory PlaneTicketItems.fromJson(Map<String, dynamic> json) =>
      PlaneTicketItems(
        id: json["id"],
        name: json["name"],
        photoUrl: json["url"],
        routes: json["routes"],
        location: json["location"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photoUrl": photoUrl,
        "routes": routes,
        "location": location,
        "price": price,
      };
}
