import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import 'package:grabby_babby_admin/presentation/logic/transaction_management/transaction_cubit.dart';
import 'package:grabby_babby_admin/presentation/logic/transaction_management/transaction_state.dart';

import '../../../../core/styles/app_color.dart';

class TransactionStatistics extends StatelessWidget {
  const TransactionStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        final currentPeriod = state.transactionComparision.currentPeriod;
        final previousPeriod = state.transactionComparision.previousPeriod;
        final cubit = context.read<TransactionCubit>();
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          width: context.width * 0.6,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Statistics',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.3)),
                        ),
                        child: DropdownButton<String>(
                          value: state.transactionType,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 18,
                            color: Colors.grey,
                          ),
                          items: ['weekly', 'monthly', 'yearly']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                "${value[0].toUpperCase()}${value.substring(1)} Comparison", // Capitalize the first letter
                                style: const TextStyle(color: Colors.grey),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              cubit.setTransactionFilterType(newValue);
                            }
                          },
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          dropdownColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                            getTooltipColor: (_) => AppColors.darkBlue,
                            getTooltipItem:
                                (group, groupIndex, rod, rodIndex) =>
                                    BarTooltipItem(
                                        '\$${rod.toY.toStringAsFixed(2)}',
                                        TextStyle(color: Colors.white)))),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() < currentPeriod.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  currentPeriod[value.toInt()]
                                      .label, // Dynamic label
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '\$${value.toInt()}k',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            );
                          },
                          interval: 50,
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 50,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey[200],
                          strokeWidth: 1,
                        );
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(
                      currentPeriod.length,
                      (index) => _createBarGroup(
                        index,
                        currentPeriod[index].value.toDouble(),
                        previousPeriod[index].value.toDouble(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem('This week', Colors.blue),
                  const SizedBox(width: 24),
                  _buildLegendItem('Last week', Colors.grey[300]!),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  BarChartGroupData _createBarGroup(int x, double value1, double value2) {
    return BarChartGroupData(
      x: x,
      groupVertically: false,
      barRods: [
        BarChartRodData(
          toY: value1,
          color: Colors.blue,
          width: 8,
          borderRadius: BorderRadius.circular(2),
        ),
        BarChartRodData(
          toY: value2,
          color: Colors.grey[300],
          width: 8,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
