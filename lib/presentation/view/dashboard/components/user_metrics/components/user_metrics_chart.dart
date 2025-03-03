import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UserMetricsChart extends StatelessWidget {
  const UserMetricsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 1,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey[200],
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.grey[200],
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          lineBarsData: [
            // Total Registered Users (Blue line)
            LineChartBarData(
              spots: [
                const FlSpot(0, 3),
                const FlSpot(2.6, 2),
                const FlSpot(4.9, 5),
                const FlSpot(6.8, 3.1),
                const FlSpot(8, 4),
                const FlSpot(9.5, 3),
                const FlSpot(11, 4),
              ],
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
            // Total Service Providers (Green line)
            LineChartBarData(
              spots: [
                const FlSpot(0, 4),
                const FlSpot(2.6, 3),
                const FlSpot(4.9, 6),
                const FlSpot(6.8, 4.1),
                const FlSpot(8, 5),
                const FlSpot(9.5, 4),
                const FlSpot(11, 5),
              ],
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
  }
}
