import 'package:equatable/equatable.dart';

import '../../../domain/entities/message_entity.dart';

abstract class MessageState extends Equatable {
  const MessageState();
}

class MessageInitial extends MessageState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MessageLoading extends MessageState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MessageLoaded extends MessageState {
  final List<MessageEntity> messages;

  const MessageLoaded({required this.messages});

  @override
  // TODO: implement props
  List<Object?> get props => [messages];
}

class MessageFailure extends MessageState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
