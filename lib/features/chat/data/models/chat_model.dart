import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/features/chat/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  final String? senderUid;
  final String? recipientUid;
  final String? senderName;
  final String? recipientName;
  final String? recentTextMessage;
  final Timestamp? createAt;
  final String? senderProfile;
  final String? recipientProfile;
  final num? totalUnReadMessages;

  const ChatModel({
    this.senderUid,
    this.recipientUid,
    this.senderName,
    this.recipientName,
    this.recentTextMessage,
    this.createAt,
    this.senderProfile,
    this.recipientProfile,
    this.totalUnReadMessages,
  }) : super(
          senderUid: senderUid,
          recipientUid: recipientUid,
          senderName: senderName,
          recipientName: recipientName,
          senderProfile: senderProfile,
          recipientProfile: recipientProfile,
          recentTextMessage: recentTextMessage,
          createAt: createAt,
          totalUnReadMessages: totalUnReadMessages,
        );

  factory ChatModel.fromSnapshot(DocumentSnapshot snapshot) {
    final  snap = snapshot.data() as Map<String, dynamic>;

    return ChatModel(
      recentTextMessage: snap['recentTextMessage'],
      recipientName: snap['recipientName'],
      totalUnReadMessages: snap['totalUnReadMessages'],
      recipientUid: snap['recipientUid'],
      senderName: snap['senderName'],
      senderUid: snap['senderUid'],
      senderProfile: snap['senderProfile'],
      recipientProfile: snap['recipientProfile'],
      createAt: snap['createAt'],
    );
  }

  Map<String, dynamic> toDocument() => {
        "recentTextMessage": recentTextMessage,
        "recipientName": recipientName,
        "totalUnReadMessages": totalUnReadMessages,
        "recipientUid": recipientUid,
        "senderName": senderName,
        "senderUid": senderUid,
        "senderProfile": senderProfile,
        "recipientProfile": recipientProfile,
        "createAt": createAt,
      };
}
