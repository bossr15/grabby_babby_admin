import 'package:grabby_babby_admin/data/models/chat_model/message_model.dart';
import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';

class ChatModel {
  int id;
  MessageModel lastMessage;
  UserModel user;

  ChatModel({required this.id, required this.lastMessage, required this.user});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json["id"],
      lastMessage: MessageModel.fromJson(json["lastMessage"]),
      user: UserModel.fromJson(json["user"]),
    );
  }
}
