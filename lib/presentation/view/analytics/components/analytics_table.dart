import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:grabby_babby_admin/core/styles/app_images.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import 'package:grabby_babby_admin/presentation/logic/analytics/analytics_cubit.dart';

import '../../../../core/widgets/app_indicator.dart';
import '../../../logic/analytics/analytics_state.dart';

class AnalyticsTable extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isBuyer;

  const AnalyticsTable({
    super.key,
    required this.title,
    required this.subtitle,
    this.isBuyer = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      constraints: BoxConstraints(maxHeight: context.height * 0.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),
          BlocBuilder<AnalyticsCubit, AnalyticsState>(
            builder: (context, state) {
              final data =
                  isBuyer ? state.analytics.buyers : state.analytics.sellers;
              final isEmpty = data.isEmpty;
              final isLoading = state.isLoading;
              return isLoading
                  ? AppIndicator(color: AppColors.darkBlue)
                  : isEmpty
                      ? Center(
                          child: Text(
                            "No Data Found",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 28),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final item = data[index];
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: _buildTableRow(
                                    item.fullName, item.orderCount),
                              );
                            },
                          ),
                        );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(String name, int count) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(AppImages.dummyUser),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Text(
          count.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
