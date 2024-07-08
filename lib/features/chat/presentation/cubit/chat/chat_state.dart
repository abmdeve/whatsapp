import 'package:equatable/equatable.dart';

import '../../../domain/entities/chat_entity.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChatLoaded extends ChatState {
  final List<ChatEntity> chatContacts;

  const ChatLoaded({required this.chatContacts});

  @override
  // TODO: implement props
  List<Object?> get props => [chatContacts];
}

class ChatFailure extends ChatState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
