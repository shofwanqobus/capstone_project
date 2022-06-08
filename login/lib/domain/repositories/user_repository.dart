import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:login/domain/entities/users.dart';
import 'package:login/domain/entities/users_detail.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<Users>>> getUsersList();
  Future<Either<Failure, UsersDetail>> getUsersById(String id);
  Future<Either<Failure, String>> addUsers(UsersDetail user);
  Future<Either<Failure, String>> removeUsers(UsersDetail user);
  Future<bool> isUserAdded(String id);
}
