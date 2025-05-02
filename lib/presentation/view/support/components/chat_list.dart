import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/date_helpers.dart';
import 'package:grabby_babby_admin/presentation/logic/support/support_cubit.dart';
import 'package:grabby_babby_admin/presentation/logic/support/support_state.dart';
import '../../../../core/styles/app_images.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportCubit, SupportState>(builder: (context, state) {
      final cubit = context.read<SupportCubit>();
      final chats = state.chats.getCachedData();
      final isEmpty = chats.isEmpty;

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            onChanged: (val) {
                              cubit.searchChats(val);
                            },
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: isEmpty
                  ? Center(child: Text("No Chats Found"))
                  : ListView.builder(
                      controller: cubit.chatsScrollController,
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        final name = chat.user.fullName ?? "";
                        final message = chat.lastMessage;
                        final isSelected = chat.id == state.selectedChat.id;
                        return _buildChatItem(
                          name,
                          message.messageBody ?? "",
                          DateHelpers.formatMessageDate(message.sentAt),
                          () {
                            cubit.setSelectedChat(chat);
                          },
                          isSelected: isSelected,
                        );
                      },
                    ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildChatItem(
    String name,
    String message,
    String time,
    VoidCallback onTap, {
    bool isSelected = false,
  }) {
    return Container(
      color: isSelected ? Color(0xff2563eb).withOpacity(0.37) : null,
      child: ListTile(
        onTap: onTap,
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(AppImages.dummyUser),
            ),
          ],
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          message,
          maxLines: 1,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
