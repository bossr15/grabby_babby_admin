import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:grabby_babby_admin/core/widgets/app_indicator.dart';
import 'package:grabby_babby_admin/presentation/logic/analytics/analytics_cubit.dart';
import '../../../logic/analytics/analytics_state.dart';

class AnalyticsChart extends StatelessWidget {
  const AnalyticsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        final cubit = context.read<AnalyticsCubit>();
        final isLoading = state.isRevenueLoading;
        final revenueList = state.revenueModel.revenueAxis;
        final isEmpty = !isLoading && revenueList.isEmpty;

        return Container(
          height: 365,
          padding: const EdgeInsets.all(24),
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
                  const Text(
                    'Revenue',
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
              const SizedBox(height: 24),
              isLoading
                  ? const AppIndicator(color: AppColors.darkBlue)
                  : isEmpty
                      ? const Center(child: Text("No Data Found"))
                      : Expanded(
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: revenueList.isEmpty
                                  ? 0
                                  : revenueList
                                          .map((e) => e.y)
                                          .reduce((a, b) => a > b ? a : b) +
                                      50, // Max value with padding
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
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
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
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2)),
                              ),
                              barGroups:
                                  List.generate(revenueList.length, (index) {
                                final data = revenueList[index];
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      toY: data.y.toDouble(),
                                      color: Colors.blue,
                                      width: 15,
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
