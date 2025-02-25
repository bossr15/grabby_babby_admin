import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/presentation/view/home/components/app_bar/g_b_admin_app_bar.dart';

import '../../../core/styles/app_color.dart';
import 'components/side_panel/side_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Row(
        children: [
          const SidePanel(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  const GBAdminAppBar(),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
