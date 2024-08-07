import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String? senderUid;
  final String? recipientUid;
  final String? senderName;
  final String? recipientName;
  final String? recentTextMessage;
  final Timestamp? createAt;
  final String? senderProfile;
  final String? recipientProfile;
  final num? totalUnReadMessages;

  const ChatEntity({
    this.senderUid,
    this.recipientUid,
    this.senderName,
    this.recipientName,
    this.recentTextMessage,
    this.createAt,
    this.senderProfile,
    this.recipientProfile,
    this.totalUnReadMessages,
  });

  @override
  List<Object?> get props => [
        senderUid,
        recipientUid,
        senderName,
        recipientName,
        recentTextMessage,
        createAt,
        senderProfile,
        recipientProfile,
        totalUnReadMessages,
      ];
}
