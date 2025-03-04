import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/presentation/view/support/components/chat_room.dart';

import 'components/chat_list.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(flex: 2, child: ChatRoom()),
          const SizedBox(width: 12),
          Expanded(child: ChatList()),
        ],
      ),
    );
  }
}
