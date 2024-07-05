import 'package:whatsapp/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp/features/chat/domain/repository/chat_repository.dart';

class GetMyChatUseCase {
  final ChatRepository repository;

  GetMyChatUseCase({required this.repository});

  Stream<List<ChatEntity>> call(ChatEntity chat) {
    return repository.getMyChat(chat);
  }
}
