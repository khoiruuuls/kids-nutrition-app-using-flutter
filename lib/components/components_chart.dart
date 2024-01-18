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
  final String dateOne;
  final String dateTwo;
  final String dateThree;
  final String dateFour;
  final String dateFive;
  final String dateSix;
  final String dateSeven;

  const ComponentsChart({
    Key? key,
    required this.dayOne,
    required this.dayTwo,
    required this.dayThree,
    required this.dayFour,
    required this.dayFive,
    required this.daySix,
    required this.daySeven,
    required this.dateOne,
    required this.dateTwo,
    required this.dateThree,
    required this.dateFour,
    required this.dateFive,
    required this.dateSix,
    required this.dateSeven,
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
            maxY: 11000,
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
                          toY: 11000,
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
      fontSize: 12,
    );

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(
          dateOne,
          style: style,
        );
        break;
      case 1:
        text = Text(
          dateTwo,
          style: style,
        );
        break;
      case 2:
        text = Text(
          dateThree,
          style: style,
        );
        break;
      case 3:
        text = Text(
          dateFour,
          style: style,
        );
        break;
      case 4:
        text = Text(
          dateFive,
          style: style,
        );
        break;
      case 5:
        text = Text(
          dateSix,
          style: style,
        );
        break;
      case 6:
        text = Text(
          dateSeven,
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
