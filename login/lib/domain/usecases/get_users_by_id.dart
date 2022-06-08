import 'package:dartz/dartz.dart';
import 'package:login/domain/entities/users_detail.dart';
import 'package:login/domain/repositories/user_repository.dart';
import 'package:core/core.dart';

class GetUsersById {
  final UsersRepository repository;

  GetUsersById(this.repository);

  Future<Either<Failure, UsersDetail>> execute(String id) {
    return repository.getUsersById(id);
  }
}
