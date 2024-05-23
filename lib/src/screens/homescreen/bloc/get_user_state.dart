import 'package:flutter_task/src/domain/model/user_entity.dart';

class GetUserState {
  GetUserState({required this.message, required this.isLoading, this.users});

  static GetUserState initialState() {
    return GetUserState(isLoading: false, message: null);
  }

  final bool isLoading;
  final String? message;
  final List<User>? users;

  GetUserState copyWith({bool? isLoading, String? message, List<User>? users}) {
    return GetUserState(
        message: message ?? this.message,
        users: users ?? this.users,
        isLoading: isLoading ?? this.isLoading);
  }
}
