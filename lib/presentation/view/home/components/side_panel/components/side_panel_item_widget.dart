import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/utils/utils.dart';
import 'package:grabby_babby_admin/presentation/view/home/components/side_panel/components/side_panel_item.dart';
import '../../../../../../core/styles/app_color.dart';

class SidePanelItemWidget extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final SidePanelItem item;

  const SidePanelItemWidget({
    super.key,
    required this.isSelected,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        gradient: isSelected ? appGradient2 : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Image.asset(
          item.image,
          width: 24,
          height: 24,
          color: isSelected ? AppColors.white : AppColors.black,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
