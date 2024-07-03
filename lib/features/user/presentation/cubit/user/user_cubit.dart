import 'package:bloc/bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/user/get_all_users_use_case.dart';
import '../../../domain/usecases/user/update_user_use_case.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;

  UserCubit({
    required this.updateUserUseCase,
    required this.getAllUsersUseCase,
  }) : super(UserInitial());

  Future<void> getAllUsers() async {
    emit(UserLoading());
    final streamResponse = getAllUsersUseCase.call();
    streamResponse.listen((users) {
      emit(UserLoaded(users: users));
    });
  }

  Future<void> updateUser({required UserEntity user}) async {
    try {
      await updateUserUseCase.call(user);
    } catch (e) {
      emit(UserFailure());
    }
  }
}
