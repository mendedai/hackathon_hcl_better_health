import 'dart:math';

import 'package:dash_chat/dash_chat.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/theme/fonts.dart';

class InsightsChartWidget extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  _InsightsChartWidgetState createState() => _InsightsChartWidgetState();
}

class _InsightsChartWidgetState extends State<InsightsChartWidget> {
  final Color cardBackgroundColor = Colors.white;
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 18.0),
      child: AspectRatio(
        aspectRatio: 1.2,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: cardBackgroundColor,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      'Insights',
                      style:
                          TextStyles.sectionTitle.copyWith(color: kColorTitle),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BarChart(
                          isPlaying ? randomData() : mainBarData(),
                          swapAnimationDuration: animDuration,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: const Color(0xff0f4a3c),
                    ),
                    onPressed: () {
                      setState(() {
                        isPlaying = !isPlaying;
                        if (isPlaying) {
                          refreshState();
                        }
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 16,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
              show: true,
              y: 20,
              // color: barColor.withOpacity(0.2),
              color: Colors.black12),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        Color barColor = kColorAccent3;
        switch (i) {
          case 0:
            return makeGroupData(0, 5,
                isTouched: i == touchedIndex, barColor: barColor);
          case 1:
            return makeGroupData(1, 6.5,
                isTouched: i == touchedIndex, barColor: barColor);
          case 2:
            return makeGroupData(2, 5,
                isTouched: i == touchedIndex, barColor: barColor);
          case 3:
            return makeGroupData(3, 7.5,
                isTouched: i == touchedIndex, barColor: barColor);
          case 4:
            return makeGroupData(4, 9,
                isTouched: i == touchedIndex, barColor: barColor);
          case 5:
            return makeGroupData(5, 11.5,
                isTouched: i == touchedIndex, barColor: barColor);
          case 6:
            return makeGroupData(6, 6.5,
                isTouched: i == touchedIndex, barColor: barColor);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Sunday';
                  break;
                case 1:
                  weekDay = 'Monday';
                  break;
                case 2:
                  weekDay = 'Tuesday';
                  break;
                case 3:
                  weekDay = 'Wednesday';
                  break;
                case 4:
                  weekDay = 'Thursday';
                  break;
                case 5:
                  weekDay = 'Friday';
                  break;
                case 6:
                  weekDay = 'Saturday';
                  break;
              }
              return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(),
                  TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          margin: 16,
          getTitles: (double value) {
            String getLabel(int daysPrevious) {
              DateTime now =
                  DateTime.now().subtract(Duration(days: daysPrevious));
              DateFormat formatter = DateFormat('d\nE');
              String formatted = formatter.format(now);
              return formatted;
            }

            switch (value.toInt()) {
              case 0:
                return getLabel(7);
              case 1:
                return getLabel(6);
              case 2:
                return getLabel(5);
              case 3:
                return getLabel(4);
              case 4:
                return getLabel(3);
              case 5:
                return getLabel(2);
              case 6:
                return getLabel(1);
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return null;
        }
      }),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      refreshState();
    }
  }
}

// import 'package:charts_flutter/flutter.dart' as charts;

// /// Example of a stacked bar chart with three series, each rendered with
// /// different fill colors.
// class InsightsChartWidget extends StatelessWidget {
//   final List<charts.Series> seriesList;
//   final bool animate;

//   InsightsChartWidget(this.seriesList, {this.animate});

//   factory InsightsChartWidget.withSampleData() {
//     return new InsightsChartWidget(
//       _createSampleData(),
//       // Disable animations for image tests.
//       animate: true,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         // Padding(
//         //   padding: const EdgeInsets.only(left: 20.0),
//         //   child: Text(
//         //     'Insights',
//         //     style: TextStyle(
//         //       color: Colors.blueGrey,
//         //       fontSize: 20.0,
//         //       fontWeight: FontWeight.bold,
//         //       letterSpacing: 1.0,
//         //     ),
//         //   ),
//         // ),
//         SizedBox(
//           height: 250.0,
//           child: new charts.BarChart(
//             seriesList,
//             animate: animate,
//             // Configure a stroke width to enable borders on the bars.
//             defaultRenderer: new charts.BarRendererConfig(
//                 groupingType: charts.BarGroupingType.stacked,
//                 strokeWidthPx: 2.0),
//           ),
//         )
//       ],
//     );
//   }

//   /// Create series list with multiple series
//   static List<charts.Series<OrdinalSales, String>> _createSampleData() {
//     final desktopSalesData = [
//       new OrdinalSales('Sun', 5),
//       new OrdinalSales('Mon', 25),
//       new OrdinalSales('Tue', 100),
//       new OrdinalSales('Wed', 75),
//       new OrdinalSales('Thu', 15),
//       new OrdinalSales('Fri', 35),
//       new OrdinalSales('Sat', 5),
//     ];

//     final tableSalesData = [
//       new OrdinalSales('Sun', 25),
//       new OrdinalSales('Mon', 50),
//       new OrdinalSales('Tue', 10),
//       new OrdinalSales('Wed', 20),
//       new OrdinalSales('Thu', 15),
//       new OrdinalSales('Fri', 0),
//       new OrdinalSales('Sat', 5),
//     ];

//     final mobileSalesData = [
//       new OrdinalSales('Sun', 10),
//       new OrdinalSales('Mon', 50),
//       new OrdinalSales('Tue', 50),
//       new OrdinalSales('Wed', 45),
//       new OrdinalSales('Thu', 5),
//       new OrdinalSales('Fri', 15),
//       new OrdinalSales('Sat', 15),
//     ];

//     return [
//       // Blue bars with a lighter center color.
//       new charts.Series<OrdinalSales, String>(
//         id: 'Desktop',
//         domainFn: (OrdinalSales sales, _) => sales.day,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: desktopSalesData,
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         fillColorFn: (_, __) =>
//             charts.MaterialPalette.blue.shadeDefault.lighter,
//       ),
//       // Solid red bars. Fill color will default to the series color if no
//       // fillColorFn is configured.
//       new charts.Series<OrdinalSales, String>(
//         id: 'Tablet',
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: tableSalesData,
//         colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
//         domainFn: (OrdinalSales sales, _) => sales.day,
//       ),
//       // Hollow green bars.
//       new charts.Series<OrdinalSales, String>(
//         id: 'Mobile',
//         domainFn: (OrdinalSales sales, _) => sales.day,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: mobileSalesData,
//         colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
//         fillColorFn: (_, __) => charts.MaterialPalette.transparent,
//       ),
//     ];
//   }
// }

// /// Sample ordinal data type.
// class OrdinalSales {
//   final String day;
//   final int sales;

//   OrdinalSales(this.day, this.sales);
// }
