

import 'package:whatsapp/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<void> deleteChat(ChatEntity chat) {
    // TODO: implement deleteChat
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMessage(MessageEntity message) {
    // TODO: implement deleteMessage
    throw UnimplementedError();
  }

  @override
  Stream<List<MessageEntity>> getMessages(MessageEntity message) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Stream<List<ChatEntity>> getMyChat(ChatEntity chat) {
    // TODO: implement getMyChat
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage(ChatEntity chat, MessageEntity message) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
  
}