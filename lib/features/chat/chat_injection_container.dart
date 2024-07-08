import 'package:whatsapp/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:whatsapp/features/chat/data/remote/chat_remote_data_source_impl.dart';
import 'package:whatsapp/features/chat/data/repository/chat_repository_impl.dart';
import 'package:whatsapp/features/chat/domain/repository/chat_repository.dart';
import 'package:whatsapp/features/chat/domain/usecases/delete_message_usecase.dart';
import 'package:whatsapp/features/chat/domain/usecases/delete_my_chat_usecase.dart';
import 'package:whatsapp/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:whatsapp/features/chat/domain/usecases/get_my_chat_usecase.dart';
import 'package:whatsapp/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:whatsapp/features/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:whatsapp/features/chat/presentation/cubit/message/message_cubit.dart';

import '../../main_injection_container.dart';

Future<void> chatInjectionContainer() async {
  //TODO * CUBITS INJECTION

  sl.registerFactory<ChatCubit>(
    () => ChatCubit(
      deleteMyChatUseCase: sl.call(),
      getMyChatUseCase: sl.call(),
    ),
  );

  sl.registerFactory<MessageCubit>(() => MessageCubit(
        getMessagesUseCase: sl.call(),
        sendMessageUseCase: sl.call(),
        deleteMessageUseCase: sl.call(),
      ));

  //TODO * USE CASES INJECTION

  sl.registerLazySingleton<DeleteMessageUseCase>(
    () => DeleteMessageUseCase(
      repository: sl.call(),
    ),
  );

  sl.registerLazySingleton<DeleteMyChatUseCase>(
    () => DeleteMyChatUseCase(
      repository: sl.call(),
    ),
  );

  sl.registerLazySingleton<GetMessagesUseCase>(
    () => GetMessagesUseCase(
      repository: sl.call(),
    ),
  );
  sl.registerLazySingleton<GetMyChatUseCase>(
    () => GetMyChatUseCase(
      repository: sl.call(),
    ),
  );

  sl.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(
      repository: sl.call(),
    ),
  );

  //TODO * REPOSITORY & DATA SOURCES INJECTION

  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      remoteDataSource: sl.call(),
    ),
  );

  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(
      firestore: sl.call(),
    ),
  );
}
