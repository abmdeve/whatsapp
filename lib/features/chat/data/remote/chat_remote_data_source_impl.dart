import 'package:whatsapp/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:whatsapp/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp/features/chat/domain/entities/message_entity.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ChatRemoteDataSource remoteDataSource;

  ChatRemoteDataSourceImpl({required this.remoteDataSource});

  @override
  Future<void> deleteChat(ChatEntity chat) async =>
      remoteDataSource.deleteChat(chat);

  @override
  Future<void> deleteMessage(MessageEntity message) async =>
      remoteDataSource.deleteMessage(message);

  @override
  Stream<List<MessageEntity>> getMessages(MessageEntity message) =>
      remoteDataSource.getMessages(message);

  @override
  Stream<List<ChatEntity>> getMyChat(ChatEntity chat) =>
      remoteDataSource.getMyChat(chat);

  @override
  Future<void> sendMessage(ChatEntity chat, MessageEntity message) async =>
      remoteDataSource.sendMessage(chat, message);
}
