import 'package:flutter/material.dart';

import '../../navigation/app_navigation.dart';
import '../styles/app_color.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigation.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
        child: const Center(child: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
    );
  }
}
