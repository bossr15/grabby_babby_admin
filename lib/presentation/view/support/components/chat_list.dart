import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import '../../../../core/styles/app_images.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
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
                      Image.asset(AppImages.filter),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff2563eb).withOpacity(0.37),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'All Users',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.close,
                        size: 16,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildChatItem(
                  'Krystal Norton',
                  'Hey Abiodun, I am looking for t...',
                  'Just now',
                  isOnline: true,
                  isSelected: true,
                ),
                _buildChatItem(
                  'Calvin Moore',
                  'Typing...',
                  '5 mins',
                  isOnline: true,
                ),
                _buildChatItem(
                  'William Stephens',
                  'Do you have design files for th...',
                  '35 mins',
                  isOnline: true,
                ),
                _buildChatItem(
                  'Natalie Maxwell',
                  'Looks clean and fresh UI.',
                  '09:40',
                  isOnline: false,
                ),
                _buildChatItem(
                  'Louie Mason',
                  'It should be Bootstrap 5 comp...',
                  '22:05',
                  isOnline: true,
                  hasUnread: true,
                ),
                _buildChatItem(
                  'First Pavilion Tech Team',
                  'Jega: It\'s perfect for my next...',
                  'Yesterday',
                  isOnline: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(
    String name,
    String message,
    String time, {
    bool isOnline = false,
    bool isSelected = false,
    bool hasUnread = false,
  }) {
    return Container(
      color: isSelected ? Color(0xff2563eb).withOpacity(0.37) : null,
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(AppImages.dummyUser),
            ),
            if (isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
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
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
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
            if (hasUnread)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
