import 'package:grabby_babby_admin/data/models/chat_model/message_model.dart';
import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';

class ChatModel {
  int id;
  MessageModel lastMessage;
  UserModel user;

  ChatModel({required this.id, required this.lastMessage, required this.user});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final member = json["members"] != null && json["members"] is List
        ? json["members"][0]["user"]
        : UserModel();
    return ChatModel(
      id: json["id"],
      lastMessage: MessageModel.fromJson(json["lastMessage"]["messages"]),
      user: UserModel.fromJson(member),
    );
  }
}
