import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/widgets/jumping_dots.dart';
import 'package:grabby_babby_admin/presentation/logic/dashboard/dashboard_cubit.dart';
import 'package:intl/intl.dart';
import '../../../../../logic/dashboard/dashboard_state.dart';

class UserMetricsChart extends StatelessWidget {
  const UserMetricsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final cubit = context.read<DashboardCubit>();
        final userMetrics = cubit.state.dashboardStats;
        final buyerMetrics = userMetrics.buyerStats;
        final sellerMetrics = userMetrics.sellerStats;
        final dates = buyerMetrics.map((e) => DateTime.parse(e.date)).toList();
        final isEmpty = buyerMetrics.isEmpty && sellerMetrics.isEmpty;
        final isLoading = cubit.state.isLoading;

        return SizedBox(
          height: 400,
          child: isLoading
              ? Center(
                  child: Row(
                  children: [
                    Spacer(),
                    JumpingDots(numberOfDots: 3),
                    Spacer(),
                  ],
                ))
              : isEmpty
                  ? Center(child: Text("No Data Found"))
                  : LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          horizontalInterval: 1,
                          verticalInterval: 1,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: Colors.grey[200],
                            strokeWidth: 1,
                          ),
                          getDrawingVerticalLine: (value) => FlLine(
                            color: Colors.grey[200],
                            strokeWidth: 1,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              interval: 7,
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final startDate = dates.first;
                                final date = startDate
                                    .add(Duration(days: value.toInt()));
                                if (date.isBefore(dates.last) ||
                                    date.isAtSameMomentAs(dates.last)) {
                                  return Text(
                                    DateFormat('d MMM').format(date),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                );
                              },
                            ),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: buyerMetrics.map((data) {
                              final date = DateTime.parse(data.date);
                              final daysSinceStart = date
                                  .difference(dates.first)
                                  .inDays
                                  .toDouble();
                              return FlSpot(
                                  daysSinceStart, data.usersCreated.toDouble());
                            }).toList(),
                            isCurved: true,
                            color: Colors.blue[200],
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.blue[200]?.withOpacity(0.3),
                            ),
                          ),
                          LineChartBarData(
                            spots: sellerMetrics.map((data) {
                              final date = DateTime.parse(data.date);
                              final daysSinceStart = date
                                  .difference(dates.first)
                                  .inDays
                                  .toDouble();
                              return FlSpot(
                                  daysSinceStart, data.usersCreated.toDouble());
                            }).toList(),
                            isCurved: true,
                            color: Colors.green[200],
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.green[200]?.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
