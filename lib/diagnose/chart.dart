import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PesticideUsageChart extends StatelessWidget {
  final String diseaseType;
  final Map<String, int> pesticideData; // e.g. {'Carbaryl 250g': 3, 'Carbaryl 500g': 6}

  const PesticideUsageChart({super.key, required this.diseaseType, required this.pesticideData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Pesticide Usage for $diseaseType',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
  height: 300,
  child: BarChart(
    BarChartData(
      titlesData: const FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: pesticideData.entries
          .map((entry) {
            final value = entry.value.toDouble();
            if (value.isNaN || value.isInfinite || value <= 0) {
              return null; // Skip this entry
            }
            return BarChartGroupData(
              x: pesticideData.keys.toList().indexOf(entry.key),
              barRods: [
                BarChartRodData(
                  toY: value,
                  color: Colors.blue,
                ),
              ],
            );
          })
          .whereType<BarChartGroupData>() // Filter out null entries
          .toList(),
    ),
  ),
),
        ],
      ),
    );
  }
}