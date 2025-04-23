import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/debouncer.dart';
import 'package:grabby_babby_admin/data/models/chat_model/chat_model.dart';
import 'package:grabby_babby_admin/data/repositories/chat_repository/chat_repository.dart';
import 'package:grabby_babby_admin/presentation/logic/support/support_state.dart';

import '../../../data/models/chat_model/message_model.dart';
import '../../../data/models/paginate/paginate.dart';
import '../../../initializer.dart';

class SupportCubit extends Cubit<SupportState> {
  final chatRepository = ChatRepository();
  final debouncer = Debouncer();
  final chatsScrollController = ScrollController();
  final messagesScrollController = ScrollController();
  final userId = localStorage.getUser().id;

  SupportCubit() : super(SupportState.empty()) {
    initializeSupport();
  }

  void initializeSupport() async {
    await fetchChats();
    attachListeners();
    if (state.chats.getCachedData().isNotEmpty) {
      setSelectedChat(state.chats.getCachedData().first);
    }
  }

  void attachListeners() {
    listenSocketEvents();

    messagesScrollController.addListener(() {
      if (messagesScrollController.position.pixels >
          messagesScrollController.position.maxScrollExtent - 200) {
        if (!state.isMessagesScrolling &&
            state.messages.currentPage < state.messages.totalPages) {
          goToMessagesNextPage();
        }
      }
    });

    chatsScrollController.addListener(() {
      if (chatsScrollController.position.pixels >
          chatsScrollController.position.maxScrollExtent - 200) {
        if (!state.isChatsScrolling &&
            state.chats.currentPage < state.chats.totalPages) {
          goToChatsNextPage();
        }
      }
    });
  }

  Future<void> fetchChats({bool isRefresh = false, String? query}) async {
    log("[fetchAllChats] Fetching chats, refresh: $isRefresh");
    emit(state.copyWith(isChatsLoading: true));
    if (isRefresh) {
      final chats = Paginate<ChatModel>.empty();
      emit(state.copyWith(chats: chats));
    }
    final response =
        await chatRepository.allChats(previousData: state.chats, query: query);
    response.fold((error) {
      log("[fetchAllChats] Error fetching chats: $error");
      emit(state.copyWith(isChatsLoading: false, isChatsScrolling: false));
    }, (data) {
      emit(state.copyWith(
        isChatsLoading: false,
        isChatsScrolling: false,
        chats: data,
      ));
    });
  }

  void goToChatsNextPage() {
    log("[goToNextChatsPage] Loading next page: ${state.chats.currentPage + 1}");
    state.chats.currentPage++;
    updateChatsUi();
  }

  void updateChatsUi() {
    log("[updateChatsUi] Checking if next page is cached");
    if (!state.chats.hasPageCached(state.chats.currentPage)) {
      emit(state.copyWith(isChatsScrolling: true));
      fetchChats();
    } else {
      log("[updatechatsUi] Next page already cached");
    }
  }

  void setSelectedChat(ChatModel chat) {
    emit(state.copyWith(selectedChat: chat));
    joinRoom();
    fetchAllMessages(isRefresh: true);
  }

  void joinRoom() {
    log("[joinRoom] Joining room with roomId: ${state.selectedChat.id} and userId: $userId");
    appSocket.fireEvent('adminJoinRoom', {
      'roomId': state.selectedChat.id,
      'userId': userId,
    });
  }

  void listenSocketEvents() {
    log("[listenEvents] Listening to socket events");
    appSocket.listenToRecieveMessageEvent((data) {
      log("[listenEvents] Message received: $data");
      final message = MessageModel.fromJson(data);
      appendToList(message);
    });
  }

  void appendToList(MessageModel message) {
    log("[appendToList] Appending message: ${message.messageBody}");
    final messages =
        Paginate<MessageModel>.appendItem(data: state.messages, item: message);
    emit(state.copyWith(messages: messages));
  }

  void sendMessage() {
    if (state.textController.text.isNotEmpty) {
      final trimmedMessage = state.textController.text.trim();
      log("[sendMessage] Sending message: $trimmedMessage");
      final newMessage = MessageModel(
        messageBody: trimmedMessage,
        senderId: userId,
        sentAt: DateTime.now(),
      );
      appSocket.fireEvent('sendAdminMessage', {
        'roomId': state.selectedChat.id,
        'message': trimmedMessage,
        "userId": userId,
      });
      state.textController.clear();
      state.selectedChat.lastMessage = newMessage;
      emit(state.copyWith(selectedChat: state.selectedChat));
    } else {
      log("[sendMessage] Text field is empty, no message sent");
    }
  }

  Future<void> fetchAllMessages({bool isRefresh = false}) async {
    log("[fetchAllMessages] Fetching messages, refresh: $isRefresh");
    emit(state.copyWith(isMessagesLoading: true));
    if (isRefresh) {
      final messages = Paginate<MessageModel>.empty().copyWith(pageSize: 40);
      emit(state.copyWith(messages: messages));
    }
    final response = await chatRepository.allMessages(
      roomId: state.selectedChat.id,
      previousData: state.messages,
    );
    response.fold((error) {
      log("[fetchAllMessages] Error fetching messages: $error");
      emit(
          state.copyWith(isMessagesLoading: false, isMessagesScrolling: false));
    }, (data) {
      emit(state.copyWith(
        isMessagesLoading: false,
        isMessagesScrolling: false,
        messages: data.copyWith(pageSize: 40),
      ));
    });
  }

  void goToMessagesNextPage() {
    log("[goToNextPage] Loading next page: ${state.messages.currentPage + 1}");
    state.messages.currentPage++;
    updateMessagesUi();
  }

  void updateMessagesUi() {
    log("[updateUi] Checking if next page is cached");
    if (!state.messages.hasPageCached(state.messages.currentPage)) {
      emit(state.copyWith(isMessagesScrolling: true));
      fetchAllMessages();
    } else {
      log("[updateUi] Next page already cached");
    }
  }

  void searchChats(String query) {
    emit(state.copyWith(isChatsSearching: true));
    debouncer.call(() {
      fetchChats(isRefresh: true, query: query).then((_) {
        emit(state.copyWith(isChatsSearching: false));
      });
    });
  }

  @override
  Future<void> close() {
    messagesScrollController.dispose();
    chatsScrollController.dispose();
    return super.close();
  }
}
