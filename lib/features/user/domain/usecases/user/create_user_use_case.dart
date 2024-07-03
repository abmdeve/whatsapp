
import '../../entities/user_entity.dart';
import '../../repository/user_repository.dart';

class CreateUserUseCase {
  final UserRepository repository;

  CreateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.createUser(user);
  }
}
