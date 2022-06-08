import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/io_client.dart';
import 'package:login/data/models/users_detail_model.dart';
import 'package:login/data/models/user_model.dart';
import 'package:login/data/models/user_response.dart';

abstract class UsersRemoteDataSource {
  Future<List<UsersModel>> getUsersList();
  Future<UsersDetailResponse> getUsersDetail(String id);
  Future<List<UsersModel>> addUsers(String id, String username, String password,
      String email, String phoneNumber, String birthDate);
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final IOClient ioClient;

  UsersRemoteDataSourceImpl({required this.ioClient});

  @override
  Future<List<UsersModel>> getUsersList() async {
    final response = await ioClient.get(Uri.parse(USER_URL));

    if (response.statusCode == 200) {
      return UsersResponse.fromJson(json.decode(response.body)).usersList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UsersDetailResponse> getUsersDetail(String id) async {
    final response = await ioClient.get(Uri.parse(USER_URL + id));

    if (response.statusCode == 200) {
      return UsersDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<UsersModel>> addUsers(String id, String username, String password,
      String email, String phoneNumber, String birthDate) async {
    final response = await ioClient.post(Uri.parse(USER_URL));
    body:
    jsonEncode(<String, String>{
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate
    });

    if (response.statusCode == 201) {
      return UsersResponse.fromJson(jsonDecode(response.body)).usersList;
    } else {
      throw ServerException();
    }
  }
}
