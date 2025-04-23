import 'package:dartz/dartz.dart';
import 'package:grabby_babby_admin/data/models/chat_model/chat_model.dart';

import '../../../initializer.dart';
import '../../models/chat_model/message_model.dart';
import '../../models/paginate/paginate.dart';

class ChatRepository {
  Future<Either<String, Paginate<ChatModel>>> allChats({
    required Paginate<ChatModel> previousData,
    String? query,
  }) async {
    final response =
        await networkRepository.get(url: "/chat/get-all-chats", extraQuery: {
      "page": previousData.currentPage.toString(),
      "limit": previousData.pageSize.toString(),
      if (query != null) "search": query,
    });

    if (!response.failed) {
      final data = Paginate<ChatModel>.mergePagination(
        dataKey: "chats",
        previousData: previousData,
        newData: response.data,
        dataFromJson: ChatModel.fromJson,
      );
      return right(data);
    }

    return left(response.message);
  }

  Future<Either<String, Paginate<MessageModel>>> allMessages({
    required Paginate<MessageModel> previousData,
    required int roomId,
  }) async {
    final response =
        await networkRepository.get(url: "/chat/get-all-messages", extraQuery: {
      "roomId": roomId.toString(),
      "page": previousData.currentPage.toString(),
      "limit": previousData.pageSize.toString()
    });

    if (!response.failed) {
      final data = Paginate<MessageModel>.mergePagination(
        dataKey: "messages",
        previousData: previousData,
        newData: response.data,
        dataFromJson: MessageModel.fromJson,
      );
      return right(data);
    }

    return left(response.message);
  }
}
