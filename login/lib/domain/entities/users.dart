import 'package:equatable/equatable.dart';

class Users extends Equatable {
  Users({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.phoneNumber,
    required this.dateBirth,
  });

  String id;
  String? username;
  String? password;
  String? email;
  String? phoneNumber;
  String? dateBirth;

  Users.userList({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
  });

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
