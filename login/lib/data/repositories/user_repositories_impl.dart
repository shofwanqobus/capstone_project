import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:login/data/datasources/users_local_data_source.dart';
import 'package:login/data/datasources/user_remote_data_source.dart';
import 'package:login/data/models/user_table.dart';
import 'package:login/domain/entities/users.dart';
import 'package:login/domain/entities/users_detail.dart';
import 'package:login/domain/repositories/user_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersLocalDataSource usersLocalDataSource;
  final UsersRemoteDataSource usersRemoteDataSource;

  UsersRepositoryImpl({
    required this.usersLocalDataSource,
    required this.usersRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> addUsers(UsersDetail user) async {
    try {
      final result =
          await usersLocalDataSource.addUsers(UsersTable.fromEntity(user));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Users>>> getUsersList() async {
    final result = await usersLocalDataSource.getUsersList();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, UsersDetail>> getUsersById(String id) async {
    try {
      final result = await usersRemoteDataSource.getUsersDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<bool> isUserAdded(String id) async {
    final result = await usersLocalDataSource.getUsersById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeUsers(UsersDetail user) async {
    try {
      final result =
          await usersLocalDataSource.removeUsers(UsersTable.fromEntity(user));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
