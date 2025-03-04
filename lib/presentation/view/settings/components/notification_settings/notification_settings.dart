import 'package:flutter/material.dart';

import '../../../../../core/widgets/g_b_admin_switch.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        GbAdminSwitch(),
                        SizedBox(width: 16),
                        Text('Notification Name'),
                      ],
                    );
                  }))
        ],
      ),
    );
  }
}
