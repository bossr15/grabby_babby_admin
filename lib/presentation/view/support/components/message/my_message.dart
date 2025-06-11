import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/utils/date_helpers.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';

import '../../../../../data/models/chat_model/message_model.dart';

class MyMessage extends StatelessWidget {
  const MyMessage({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Spacer(),
          Container(
            constraints: BoxConstraints(maxWidth: context.width * 0.3),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xff365BE5).withOpacity(0.15),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.messageBody ?? "",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateHelpers.formatMessageDate(message.sentAt),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
