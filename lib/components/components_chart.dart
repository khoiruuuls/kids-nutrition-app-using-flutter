// ignore_for_file: unused_local_variable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kids_nutrition_app/config/config_color.dart';
import 'package:kids_nutrition_app/model/model_bar.dart';

class ComponentsChart extends StatelessWidget {
  final String dayOne;
  final String dayTwo;
  final String dayThree;
  final String dayFour;
  final String dayFive;
  final String daySix;
  final String daySeven;

  const ComponentsChart({
    Key? key,
    required this.dayOne,
    required this.dayTwo,
    required this.dayThree,
    required this.dayFour,
    required this.dayFive,
    required this.daySix,
    required this.daySeven,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Bar bar = Bar(
      amountOne: double.parse(dayOne),
      amountTwo: double.parse(dayTwo),
      amountThree: double.parse(dayThree),
      amountFour: double.parse(dayFour),
      amountFive: double.parse(dayFive),
      amountSix: double.parse(daySix),
      amountSeven: double.parse(daySeven),
    );

    bar.initialDataBar();

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
            maxY: 3000,
            minY: 0,
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: setBottomTitle),
              ),
            ),
            barGroups: bar.dataBar
                .map(
                  (data) => BarChartGroupData(
                    x: data.x,
                    barRods: [
                      BarChartRodData(
                        toY: data.y,
                        color: ConfigColor.darkBlue,
                        width: 14,
                        backDrawRodData: BackgroundBarChartRodData(
                          toY: 3000,
                          show: true,
                          color: Colors.amber.shade300,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(), // Ensure the result is converted to a List

            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.amber.shade300,
              ),
            )),
      ),
    );
  }

  Widget setBottomTitle(double value, TitleMeta meta) {
    var style = const TextStyle(
      color: ConfigColor.darkBlue,
      fontWeight: FontWeight.bold,
    );

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(
          "1",
          style: style,
        );
        break;
      case 1:
        text = Text(
          "2",
          style: style,
        );
        break;
      case 2:
        text = Text(
          "3",
          style: style,
        );
        break;
      case 3:
        text = Text(
          "4",
          style: style,
        );
        break;
      case 4:
        text = Text(
          "5",
          style: style,
        );
        break;
      case 5:
        text = Text(
          "6",
          style: style,
        );
        break;
      case 6:
        text = Text(
          "7",
          style: style,
        );
        break;
      default:
        text = Text(
          "",
          style: style,
        );
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}
