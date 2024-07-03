import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/user/get_device_number_use_case.dart';
import 'get_device_number_state.dart';

class GetDeviceNumberCubit extends Cubit<GetDeviceNumberState> {
  GetDeviceNumberUseCase getDeviceNumberUseCase;

  GetDeviceNumberCubit({
    required this.getDeviceNumberUseCase,
  }) : super(GetDeviceNumberInitial());

  Future<void> getDeviceNumber() async {
    try {
      final contactNumber = await getDeviceNumberUseCase.call();
      emit(GetDeviceNumberLoaded(contacts: contactNumber));
    } catch (_) {
      emit(GetDeviceNumberFailure());
    }
  }
}
