import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String senderId;
  final String senderEmail;

  final String receiverId;
  final String Message;
  final Timestamp timestamp;

  Chat({
    required this.senderId,
    required this.receiverId,
    required this.Message,
    required this.timestamp,
    required this. senderEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': Message,
      'timestamp': timestamp,
    };
  }
}
