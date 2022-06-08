import 'package:dartz/dartz.dart';
import 'package:login/domain/entities/users.dart';
import 'package:login/domain/repositories/user_repository.dart';
import 'package:core/core.dart';

class GetUsersList {
  final UsersRepository repository;

  GetUsersList(this.repository);

  Future<Either<Failure, List<Users>>> execute() {
    return repository.getUsersList();
  }
}
