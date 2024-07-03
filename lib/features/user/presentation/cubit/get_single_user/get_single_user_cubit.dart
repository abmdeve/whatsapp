import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/user/get_single_user_use_case.dart';
import 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;

  GetSingleUserCubit({
    required this.getSingleUserUseCase,
  }) : super(GetSingleUserInitial());

  Future<void> getSingleUser({required String uid}) async {
    emit(GetSingleUserLoading());
    final streamResponse = getSingleUserUseCase.call(uid);
    streamResponse.listen((users) {
      emit(GetSingleUserLoaded(singleUser: users.first));
    });
  }
}
