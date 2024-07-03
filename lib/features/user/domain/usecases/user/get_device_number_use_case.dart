
import '../../entities/contact_entity.dart';
import '../../repository/user_repository.dart';

class GetDeviceNumberUseCase {
  final UserRepository repository;

  GetDeviceNumberUseCase({required this.repository});

  Future<List<ContactEntity>> call() async{
    return repository.getDeviceNumber();
  }
}
