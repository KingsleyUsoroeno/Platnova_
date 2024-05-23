import 'package:flutter_task/src/domain/model/user_entity.dart';

abstract class UserRepository{
  Future<List<User>> getUsers();
}