import 'package:flutter_task/src/data/services/dio_client.dart';
import 'package:flutter_task/src/domain/model/user_entity.dart';
import 'package:flutter_task/src/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final DioClient dioClient;

  UserRepositoryImpl({required this.dioClient});
  @override
  Future<List<User>> getUsers() async {
    final response =
        await dioClient.dioGet('https://jsonplaceholder.typicode.com/users');
    print(response.data);
    if (response.data != null) {
      return  List.from(response.data).map((e) => User.fromJson(e)).toList();
    } else {
      print('data is null');
    }
    return [];
  }
}
