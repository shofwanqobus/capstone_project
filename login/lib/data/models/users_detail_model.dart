import 'package:login/domain/entities/users_detail.dart';
import 'package:equatable/equatable.dart';

class UsersDetailResponse extends Equatable {
  UsersDetailResponse({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.phoneNumber,
    required this.dateBirth,
  });

  String id;
  String username;
  String password;
  String email;
  String phoneNumber;
  String dateBirth;

  factory UsersDetailResponse.fromJson(Map<String, dynamic> json) =>
      UsersDetailResponse(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        dateBirth: json["dateBirth"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "email": email,
        "phone_number": phoneNumber,
        "date_birth": dateBirth,
      };

  UsersDetail toEntity() {
    return UsersDetail(
      id: id,
      username: username,
      password: password,
      email: email,
      phoneNumber: phoneNumber,
      dateBirth: dateBirth,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        password,
        email,
        phoneNumber,
        dateBirth,
      ];
}
