import 'package:flutter/material.dart';

import 'components/user_stats.dart';

class UserManagement extends StatelessWidget {
  const UserManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserStats(),
      ],
    );
  }
}
