import 'package:login/domain/entities/users.dart';
import 'package:login/domain/entities/users_detail.dart';
import 'package:equatable/equatable.dart';

class UsersTable extends Equatable {
  final String id;
  final String? username;
  final String? password;
  final String? email;

  const UsersTable({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
  });

  factory UsersTable.fromEntity(UsersDetail users) => UsersTable(
        id: users.id,
        username: users.username,
        password: users.password,
        email: users.email,
      );

  factory UsersTable.fromMap(Map<String, dynamic> map) => UsersTable(
        id: map['id'],
        username: map['username'],
        password: map['password'],
        email: map['email'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'email': email,
      };

  Users toEntity() => Users.userList(
        id: id,
        username: username,
        password: password,
        email: email,
      );

  @override
  List<Object?> get props => [id, username, password, email];
}
