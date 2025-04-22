import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/presentation/logic/analytics/analytics_cubit.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/utils/date_helpers.dart';
import '../../../logic/analytics/analytics_state.dart';

class AnalyticsHeader extends StatelessWidget {
  const AnalyticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        final cubit = context.read<AnalyticsCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Analytics and Reporting',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 15),
            Container(
              width: 300,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Text('Timeframe: x '),
                  SizedBox(width: 10),
                  Text(
                    DateHelpers.formatDateRange(state.startDate, state.endDate),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      final pickedRange =
                          await DateHelpers.showDateRange(context: context);
                      if (pickedRange != null) {
                        cubit.setDate(pickedRange);
                      }
                    },
                    child: Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
