import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId; 
  final String senderUid; 
  final String senderMail; 
  final String receiverEmail; 
  final String subject; 
  final String body; 
  final DateTime timestamp; 

  MessageModel({
    required this.messageId, //docId
    required this.senderUid,
    required this.senderMail,
    required this.receiverEmail,
    required this.subject,
    required this.body,
    required this.timestamp,
  });

  // Method to convert Firebase snapshot to Message object
  factory MessageModel.fromSnapshot(snapshot) {
    return MessageModel(
      messageId: snapshot['messageId'] ?? '',
      senderUid: snapshot['senderUid'] ?? '',
      senderMail: snapshot['senderMail'] ?? '',
      receiverEmail: snapshot['receiverEmail'] ?? '',
      subject: snapshot['subject'] ?? '',
      body: snapshot['body'] ?? '',
      timestamp: (snapshot['timestamp'] as Timestamp).toDate(),
    );
  }

  // Method to convert Message object to JSON map for storing in Firebase
  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'senderUid': senderUid,
      'senderMail': senderMail,
      'receiverEmail': receiverEmail,
      'subject': subject,
      'body': body,
      'timestamp': timestamp,
    };
  }
}
