import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/s_colors.dart';

class Graph extends StatelessWidget {
  final List<FlSpot> flSpot;

  Graph({required this.flSpot});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: ClipRect(
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: SideTitles(
                showTitles: true,
                interval: 1.0, // Interval between each label on the y-axis
              ),
              bottomTitles: SideTitles(
                showTitles: true,
                interval: 5.0, // Increase the interval for the x-axis (e.g., 5)
                getTitles: (value) {
                  // Return dates as labels for x-axis (1 to 31)
                  if (value >= 1 && value <= 31) {
                    return value.toInt().toString();
                  }
                  return '';
                },
              ),
              topTitles: SideTitles(
                showTitles: false,
              ),
              rightTitles: SideTitles(
                showTitles: false,
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            minX: 1,
            maxX: 31,
            minY: 0,
            maxY: 12.5,
            lineBarsData: [
              LineChartBarData(
                spots: flSpot,
                isCurved: false,
                colors: [Colors.green, Colors.yellow, Colors.red],
                belowBarData: BarAreaData(
                  show: true,
                  colors: [Colors.green.withOpacity(0.3), Colors.yellow.withOpacity(0.3), SColors.rozgarRed.withOpacity(0.3)],
                ), // Fill below the line with multiple colors
                dotData: FlDotData(show: false), // No dots
              ),
            ],
          ),
        ),
      ),
    );
  }
}
