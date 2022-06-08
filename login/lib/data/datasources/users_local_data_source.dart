import 'package:core/core.dart';
import 'package:login/data/models/user_table.dart';

abstract class UsersLocalDataSource {
  Future<String> addUsers(UsersTable user);
  Future<String> removeUsers(UsersTable user);
  Future<UsersTable?> getUsersById(String id);
  Future<List<UsersTable>> getUsersList();
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  final DatabaseHelper databaseHelper;

  UsersLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> addUsers(UsersTable user) async {
    try {
      await databaseHelper.addUsers(user);
      return 'User has been added';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<UsersTable?> getUsersById(String id) async {
    final result = await databaseHelper.getUsersById(id);
    if (result != null) {
      return UsersTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<UsersTable>> getUsersList() async {
    final result = await databaseHelper.getUsersList();
    return result.map((data) => UsersTable.fromMap(data)).toList();
  }

  @override
  Future<String> removeUsers(UsersTable user) async {
    try {
      await databaseHelper.removeUsers(user);
      return 'User has been removed';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
