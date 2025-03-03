import 'package:flutter/material.dart';

import '../../../../core/styles/app_color.dart';

class TotalBalance extends StatelessWidget {
  const TotalBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Total Balance"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$240,399",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text("All Accounts"),
            ],
          ),
          ...List.generate(3, (index) {
            return Row(
              children: [
                Text("Recieved"),
                Row(
                  children: [
                    Text(
                      "\$250",
                      style: TextStyle(
                        color: AppColors.darkBlue,
                      ),
                    ),
                    Icon(
                      Icons.arrow_upward,
                      color: AppColors.darkBlue,
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
