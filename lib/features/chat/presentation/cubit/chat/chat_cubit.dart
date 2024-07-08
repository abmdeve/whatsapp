import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:whatsapp/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp/features/chat/domain/usecases/delete_my_chat_usecase.dart';

import '../../../domain/usecases/get_my_chat_usecase.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetMyChatUseCase getMyChatUseCase;
  final DeleteMyChatUseCase deleteMyChatUseCase;

  ChatCubit({
    required this.deleteMyChatUseCase,
    required this.getMyChatUseCase,
  }) : super(ChatInitial());

  Future<void> getMyChat({required ChatEntity chat}) async {
    try {
      emit(ChatLoading());

      final streamResponse = getMyChatUseCase.call(chat);

      streamResponse.listen((chatContacts) {
        emit(ChatLoaded(chatContacts: chatContacts));
      });
    } on SocketException {
      emit(ChatFailure());
    } catch (_) {
      emit(ChatFailure());
    }
  }

  Future<void> deleteChat({required ChatEntity chat}) async {
    try {
      await deleteMyChatUseCase.call(chat);
    } on SocketException {
      emit(ChatFailure());
    } catch (_) {
      emit(ChatFailure());
    }
  }
}
