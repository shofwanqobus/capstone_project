import 'package:equatable/equatable.dart';
import 'package:login/domain/entities/users.dart';

class UsersModel extends Equatable {
  const UsersModel({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.phoneNumber,
    required this.dateBirth,
  });

  final String id;
  final String username;
  final String password;
  final String email;
  final String phoneNumber;
  final String dateBirth;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
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

  Users toEntity() {
    return Users(
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
