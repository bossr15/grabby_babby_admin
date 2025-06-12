import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/presentation/logic/dashboard/dashboard_cubit.dart';
import 'package:grabby_babby_admin/presentation/logic/dashboard/dashboard_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/jumping_dots.dart';

class DashboardStatisticsGraph extends StatelessWidget {
  const DashboardStatisticsGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final isLoading = state.isRevenueLoading;
        final revenueList = state.revenueModel.revenueAxis;
        final isEmpty = !isLoading && revenueList.isEmpty;
        List<FlSpot> indexedRevenueList = isLoading
            ? []
            : revenueList
                .asMap()
                .entries
                .map((entry) =>
                    FlSpot(entry.key.toDouble(), entry.value.y.toDouble()))
                .toList();

        return SizedBox(
          height: 500,
          child: isLoading
              ? Row(
                  children: [
                    Spacer(),
                    JumpingDots(numberOfDots: 3),
                    Spacer(),
                  ],
                )
              : isEmpty
                  ? Center(child: Text("No Data Found"))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  if (index >= 0 &&
                                      index < revenueList.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 2),
                                      child: Text(
                                        revenueList[index].x,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: indexedRevenueList,
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 2,
                              isStrokeCapRound: true,
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 4,
                                    color: Colors.white,
                                    strokeWidth: 2,
                                    strokeColor: Colors.blue,
                                  );
                                },
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.blue.withOpacity(0.1),
                              ),
                            ),
                          ],
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipColor: (_) => Colors.blueAccent,
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots
                                    .map((LineBarSpot touchedSpot) {
                                  return LineTooltipItem(
                                    '\$${touchedSpot.y.toStringAsFixed(2)}',
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
