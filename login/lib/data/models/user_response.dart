import 'package:login/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

class UsersResponse extends Equatable {
  final List<UsersModel> usersList;

  const UsersResponse({required this.usersList});

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        usersList: List<UsersModel>.from(
          (json["users"] as List)
              .map((x) => UsersModel.fromJson(x))
              .where((element) => element.username != null),
        ),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(
          usersList.map((x) => x.toJson()),
        ),
      };

  @override
  List<Object> get props => [usersList];
}
