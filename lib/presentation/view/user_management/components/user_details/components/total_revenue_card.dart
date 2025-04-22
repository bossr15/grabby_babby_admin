import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import 'package:grabby_babby_admin/presentation/logic/users_management/user_detail/user_detail_cubit.dart';
import 'package:grabby_babby_admin/presentation/logic/users_management/user_detail/user_detail_state.dart';

import '../../../../../../core/styles/app_color.dart';
import '../../../../../../core/widgets/app_indicator.dart';

class TotalRevenueCard extends StatelessWidget {
  const TotalRevenueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailCubit, UserDetailState>(
      builder: (context, state) {
        final totalMonthlyRevenue = state.revenueModel.totalRevenue;
        final difference = state.sellerDetail.revenuePercentageDifference;
        final cubit = context.read<UserDetailCubit>();
        final isLoading = state.isRevenueLoading;
        final revenueList = state.revenueModel.revenueAxis;
        final isEmpty = !isLoading && revenueList.isEmpty;

        return Container(
          constraints: BoxConstraints(maxHeight: context.height * 0.3),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Revenue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: state.revenueFilter,
                        icon: const Icon(
                          Icons.filter_list,
                          size: 18,
                          color: Colors.grey,
                        ),
                        items: ['Week', 'Month', 'Year'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            cubit.setRevenueFilter(newValue);
                          }
                        },
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '\$${totalMonthlyRevenue.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_downward,
                            size: 12, color: Colors.red[700]),
                        Text(
                          '-${difference.toStringAsFixed(2)}% from last week',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              isLoading
                  ? const AppIndicator(color: AppColors.darkBlue)
                  : isEmpty
                      ? const Center(child: Text("No Data Found"))
                      : Expanded(
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceBetween,
                              maxY: revenueList.isEmpty
                                  ? 0
                                  : revenueList
                                          .map((e) => e.y)
                                          .reduce((a, b) => a > b ? a : b) +
                                      50,
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipColor: (_) => Colors.blueGrey,
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                    return BarTooltipItem(
                                      '${rod.toY.toInt()}',
                                      const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      if (value.toInt() >= revenueList.length) {
                                        return const Text('');
                                      }
                                      return Text(
                                        revenueList[value.toInt()].x,
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.grey),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: Colors.grey[200],
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              borderData: FlBorderData(show: false),
                              barGroups:
                                  List.generate(revenueList.length, (index) {
                                final data = revenueList[index];
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      toY: data.y.toDouble(),
                                      color: Colors.blue,
                                      width: 16,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
            ],
          ),
        );
      },
    );
  }
}
