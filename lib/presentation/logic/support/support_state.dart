import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/data/models/chat_model/chat_model.dart';
import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';

import '../../../data/models/chat_model/message_model.dart';
import '../../../data/models/paginate/paginate.dart';

class SupportState {
  Paginate<MessageModel> messages;
  Paginate<ChatModel> chats;
  ChatModel selectedChat;
  bool isMessagesLoading;
  bool isMessagesScrolling;
  bool isChatsLoading;
  bool isChatsScrolling;
  bool isChatsSearching;
  final textController = TextEditingController();

  SupportState({
    required this.messages,
    required this.chats,
    required this.selectedChat,
    this.isChatsLoading = false,
    this.isChatsScrolling = false,
    this.isChatsSearching = false,
    this.isMessagesLoading = false,
    this.isMessagesScrolling = false,
  });

  factory SupportState.empty() => SupportState(
        messages: Paginate<MessageModel>.empty().copyWith(pageSize: 40),
        chats: Paginate<ChatModel>.empty(),
        selectedChat: ChatModel(
          id: 0,
          lastMessage: MessageModel(),
          user: UserModel(),
        ),
      );

  copyWith({
    Paginate<MessageModel>? messages,
    Paginate<ChatModel>? chats,
    ChatModel? selectedChat,
    bool? isMessagesLoading,
    bool? isMessagesScrolling,
    bool? isChatsLoading,
    bool? isChatsScrolling,
    bool? isChatsSearching,
  }) =>
      SupportState(
        messages: messages ?? this.messages,
        chats: chats ?? this.chats,
        selectedChat: selectedChat ?? this.selectedChat,
        isChatsLoading: isChatsLoading ?? this.isChatsLoading,
        isChatsScrolling: isChatsScrolling ?? this.isChatsScrolling,
        isChatsSearching: isChatsSearching ?? this.isChatsSearching,
        isMessagesLoading: isMessagesLoading ?? this.isMessagesLoading,
        isMessagesScrolling: isMessagesScrolling ?? this.isMessagesScrolling,
      );
}
