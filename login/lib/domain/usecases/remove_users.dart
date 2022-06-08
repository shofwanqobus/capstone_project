import 'package:dartz/dartz.dart';
import 'package:login/domain/entities/users_detail.dart';
import 'package:login/domain/repositories/user_repository.dart';
import 'package:core/core.dart';

class RemoveUsers {
  final UsersRepository repository;

  RemoveUsers(this.repository);

  Future<Either<Failure, String>> execute(UsersDetail user) {
    return repository.removeUsers(user);
  }
}
