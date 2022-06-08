import 'package:equatable/equatable.dart';

class UsersDetail extends Equatable {
  UsersDetail({
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
