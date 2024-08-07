import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/features/app/const/firebase_collection_const.dart';
import 'package:whatsapp/features/app/const/message_type_const.dart';
import 'package:whatsapp/features/chat/data/models/chat_model.dart';
import 'package:whatsapp/features/chat/data/models/message_model.dart';
import 'package:whatsapp/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:whatsapp/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp/features/chat/domain/entities/message_entity.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firestore;

  ChatRemoteDataSourceImpl({required this.firestore});

  Future<void> addToChat(ChatEntity chat) async {
    // TODO users -> myChat -> uid -> messages -> messageIds

    final myChatRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.myChat);

    final otherChatRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.recipientUid)
        .collection(FirebaseCollectionConst.myChat);

    final myNewChat = ChatModel(
      createAt: chat.createAt,
      senderProfile: chat.senderProfile,
      recipientProfile: chat.recipientProfile,
      recentTextMessage: chat.recentTextMessage,
      recipientName: chat.recipientName,
      senderName: chat.senderName,
      recipientUid: chat.recipientUid,
      senderUid: chat.senderUid,
      totalUnReadMessages: chat.totalUnReadMessages,
    ).toDocument();

    final otherNewChat = ChatModel(
      createAt: chat.createAt,
      senderProfile: chat.recipientProfile,
      recipientProfile: chat.senderProfile,
      recentTextMessage: chat.recentTextMessage,
      recipientName: chat.senderName,
      senderName: chat.recipientName,
      recipientUid: chat.senderUid,
      senderUid: chat.recipientUid,
      totalUnReadMessages: chat.totalUnReadMessages,
    ).toDocument();

    try {
      myChatRef.doc(chat.recipientUid).get().then((myChatDoc) async {
        // CREATE
        if (!myChatDoc.exists) {
          await myChatRef.doc(chat.recipientUid).set(myNewChat);
          await otherChatRef.doc(chat.senderUid).set(otherNewChat);
          return;
        } else {
          await myChatRef.doc(chat.recipientUid).update(myNewChat);
          await otherChatRef.doc(chat.senderUid).update(otherNewChat);
        }
      });
    } catch (e) {
      debugPrint("ERROR OCCUR WHILE ADDING TO CHAT");
    }
  }

  Future<void> sendMessageBasedOnType(MessageEntity message) async {
    //TODO users -> uid -> myChat -> uid -> messages -> messageIds

    final myMessageRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.messages);

    final otherMessageRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.messages);

    String messageId = Uuid().v1();

    final newMessage = MessageModel(
      senderUid: message.senderUid,
      recipientUid: message.recipientUid,
      senderName: message.senderName,
      recipientName: message.recipientName,
      createAt: message.createAt,
      repliedTo: message.repliedTo,
      repliedMessage: message.repliedMessage,
      isSeen: message.isSeen,
      messageType: message.messageType,
      message: message.message,
      messageId: messageId,
      repliedMessageType: message.repliedMessageType,
    ).toDocument();

    try {
      await myMessageRef.doc(messageId).set(newMessage);
      await otherMessageRef.doc(messageId).set(newMessage);
    } catch (e) {
      debugPrint("ERROR OCCUR WHILE SENDING MESSAGE");
    }
  }

  @override
  Future<void> deleteChat(ChatEntity chat) async {
    final chatRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(chat.recipientUid);

    try {
      await chatRef.delete();
    } catch (e) {
      debugPrint("ERROR OCCUR WHILE DELETING CHAT CONVERSATION $e");
    }
  }

  @override
  Future<void> deleteMessage(MessageEntity message) async {
    final messageRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.messages)
        .doc(message.messageId);

    try {
      await messageRef.delete();
    } catch (e) {
      debugPrint("ERROR OCCUR WHILE DELETING MESSAGE $e");
    }
  }

  @override
  Stream<List<MessageEntity>> getMessages(MessageEntity message) {
    final messageRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.messages)
        .orderBy("createAt", descending: false);

    return messageRef.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (e) => MessageModel.fromSnapshot(e),
              )
              .toList(),
        );
  }

  @override
  Stream<List<ChatEntity>> getMyChat(ChatEntity chat) {
    final myChatRef = firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .orderBy("createAt", descending: true);

    return myChatRef.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((e) => ChatModel
            .fromSnapshot(e),
        )
            .toList());
  }

  @override
  Future<void> sendMessage(ChatEntity chat, MessageEntity message) async {
    await sendMessageBasedOnType(message);

    String recentTextMessage = "";

    switch (message.messageType) {
      case MessageTypeConst.photoMessage:
        recentTextMessage = 'Photo';
        break;
      case MessageTypeConst.videoMessage:
        recentTextMessage = 'Video';
        break;
      case MessageTypeConst.audioMessage:
        recentTextMessage = 'Audio';
        break;
      case MessageTypeConst.gifMessage:
        recentTextMessage = 'GIF';
        break;
      default:
        recentTextMessage = message.message!;
    }

    await addToChat(ChatModel(
      createAt: chat.createAt,
      senderProfile: chat.senderProfile,
      recipientProfile: chat.recipientProfile,
      recentTextMessage: recentTextMessage,
      recipientName: chat.recipientName,
      senderName: chat.senderName,
      recipientUid: chat.recipientUid,
      senderUid: chat.senderUid,
      totalUnReadMessages: chat.totalUnReadMessages,
    ));
  }
}
