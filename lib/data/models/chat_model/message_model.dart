import '../user_model/user_model.dart';

class MessageModel {
  int? id;
  DateTime? sentAt;
  int? senderId;
  String? messageBody;
  UserModel? user;

  MessageModel({
    this.id,
    this.sentAt,
    this.senderId,
    this.messageBody,
    this.user,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      sentAt: json['sentAt'] != null ? DateTime.parse(json['sentAt']) : null,
      senderId: json['userId'] ?? json['senderId'],
      messageBody: json['messageBody'],
      user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
    );
  }
}
