import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/src/domain/repository/user_repository.dart';
import 'package:flutter_task/src/screens/homescreen/bloc/get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final UserRepository _userRepository;

  GetUserCubit(super.initialState, {required UserRepository userRepository})
      : _userRepository = userRepository;

  getUser() async {
    emit(state.copyWith(isLoading: true));
    try {
      var response = await _userRepository.getUsers();
      emit(state.copyWith(isLoading: false, users: response, message: null));
    } catch (e) {
      print(e);
      emit(state.copyWith(isLoading: false, message: e.toString()));
    }
    return null;
  }
}
