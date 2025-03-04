import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';

class ContentHeader extends StatelessWidget {
  const ContentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Content Moderation',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
              'Review and manage inappropriate content submitted by users.'),
          trailing: SizedBox(
            width: context.width * 0.3,
            height: 45,
            child: TextFormField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                hintText: 'Search...',
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.filter_list,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Divider(),
        const SizedBox(height: 10),
      ],
    );
  }
}
