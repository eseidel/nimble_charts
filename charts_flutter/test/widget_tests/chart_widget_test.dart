import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

import '../test_functions.dart';

void main() {
  group('Chart Widget Tests', () {
    testWidgets('BarChart renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.BarChart(
                createSampleBarData(),
                animate: false,
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.BarChart>('golden_bar_chart');
    });

    testWidgets('LineChart renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.LineChart(
                createSampleLineData(),
                animate: false,
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.LineChart>('golden_line_chart');
    });

    testWidgets('TimeSeriesChart renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.TimeSeriesChart(
                createSampleTimeSeriesData(),
                animate: false,
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.TimeSeriesChart>('golden_time_series_chart');
    });

    testWidgets('BarChart with custom colors renders correctly',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.BarChart(
                createSampleBarDataWithCustomColors(),
                animate: false,
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.BarChart>('golden_bar_chart_custom_colors');
    });

    testWidgets('LineChart with points renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.LineChart(
                createSampleLineDataWithPoints(),
                animate: false,
                defaultRenderer: charts.LineRendererConfig(includePoints: true),
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.LineChart>('golden_line_chart_with_points');
    });

    testWidgets('TimeSeriesChart with multiple series renders correctly',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.TimeSeriesChart(
                createSampleMultipleTimeSeriesData(),
                animate: false,
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.TimeSeriesChart>(
        'golden_time_series_chart_multiple',
      );
    });

    testWidgets('NumericComboChart renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.NumericComboChart(
                createSampleNumericComboData(),
                animate: false,
                defaultRenderer: charts.LineRendererConfig<num>(),
                customSeriesRenderers: [
                  charts.BarRendererConfig<num>(customRendererId: 'customBar'),
                ],
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.NumericComboChart>(
        'golden_numeric_combo_chart',
      );
    });

    testWidgets('OrdinalComboChart renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.OrdinalComboChart(
                createSampleOrdinalComboData(),
                animate: false,
                defaultRenderer: charts.LineRendererConfig<String>(),
                customSeriesRenderers: [
                  charts.BarRendererConfig<String>(
                    customRendererId: 'customBar',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.OrdinalComboChart>(
        'golden_ordinal_combo_chart',
      );
    });

    testWidgets('LineChart with custom axis renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.LineChart(
                createSampleLineData(),
                animate: false,
                domainAxis: const charts.NumericAxisSpec(
                  tickProviderSpec: charts.BasicNumericTickProviderSpec(
                    desiredTickCount: 5,
                  ),
                ),
                primaryMeasureAxis: const charts.NumericAxisSpec(
                  tickProviderSpec: charts.BasicNumericTickProviderSpec(
                    desiredTickCount: 3,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.LineChart>(
        'golden_line_chart_custom_axis',
      );
    });

    testWidgets('BarChart with stacked bars renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.BarChart(
                createSampleStackedBarData(),
                animate: false,
                barGroupingType: charts.BarGroupingType.stacked,
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.BarChart>('golden_stacked_bar_chart');
    });

    testWidgets('BarChart with grouped bars renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.BarChart(
                createSampleGroupedBarData(),
                animate: false,
                barGroupingType: charts.BarGroupingType.grouped,
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.BarChart>('golden_grouped_bar_chart');
    });

    testWidgets('RTL BarChart renders correctly', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 400,
                child: charts.BarChart(
                  createSampleBarData(),
                  animate: false,
                  vertical: false,
                ),
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.BarChart>('golden_rtl_bar_chart');
    });
  });
}

/// Creates sample data for a bar chart.
List<charts.Series<OrdinalSales, String>> createSampleBarData() => [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        data: [
          OrdinalSales('2014', 5),
          OrdinalSales('2015', 25),
          OrdinalSales('2016', 100),
          OrdinalSales('2017', 75),
        ],
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
      ),
    ];

/// Creates sample data for a line chart.
List<charts.Series<LinearSales, int>> createSampleLineData() => [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        data: [
          LinearSales(0, 5),
          LinearSales(1, 25),
          LinearSales(2, 100),
          LinearSales(3, 75),
        ],
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
      ),
    ];

/// Creates sample data for a time series chart.
List<charts.Series<TimeSeriesSales, DateTime>> createSampleTimeSeriesData() => [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        data: [
          TimeSeriesSales(DateTime(2017, 9, 19), 5),
          TimeSeriesSales(DateTime(2017, 9, 26), 25),
          TimeSeriesSales(DateTime(2017, 10, 3), 100),
          TimeSeriesSales(DateTime(2017, 10, 10), 75),
        ],
        domainFn: (sales, _) => sales.time,
        measureFn: (sales, _) => sales.sales,
      ),
    ];

/// Creates sample data for a bar chart with custom colors.
List<charts.Series<OrdinalSales, String>>
    createSampleBarDataWithCustomColors() => [
          charts.Series<OrdinalSales, String>(
            id: 'Sales',
            data: [
              OrdinalSales('2014', 5),
              OrdinalSales('2015', 25),
              OrdinalSales('2016', 100),
              OrdinalSales('2017', 75),
            ],
            domainFn: (sales, _) => sales.year,
            measureFn: (sales, _) => sales.sales,
            colorFn: (sales, _) {
              switch (sales.year) {
                case '2014':
                  return charts.MaterialPalette.blue.shadeDefault;
                case '2015':
                  return charts.MaterialPalette.red.shadeDefault;
                case '2016':
                  return charts.MaterialPalette.green.shadeDefault;
                case '2017':
                  return charts.MaterialPalette.yellow.shadeDefault;
                default:
                  return charts.MaterialPalette.gray.shadeDefault;
              }
            },
          ),
        ];

/// Creates sample data for a line chart with points.
List<charts.Series<LinearSales, int>> createSampleLineDataWithPoints() => [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        data: [
          LinearSales(0, 5),
          LinearSales(1, 25),
          LinearSales(2, 100),
          LinearSales(3, 75),
        ],
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
      ),
    ];

/// Creates sample data for a time series chart with multiple series.
List<charts.Series<TimeSeriesSales, DateTime>>
    createSampleMultipleTimeSeriesData() => [
          charts.Series<TimeSeriesSales, DateTime>(
            id: 'Desktop',
            data: [
              TimeSeriesSales(DateTime(2017, 9, 19), 5),
              TimeSeriesSales(DateTime(2017, 9, 26), 25),
              TimeSeriesSales(DateTime(2017, 10, 3), 100),
              TimeSeriesSales(DateTime(2017, 10, 10), 75),
            ],
            domainFn: (sales, _) => sales.time,
            measureFn: (sales, _) => sales.sales,
          ),
          charts.Series<TimeSeriesSales, DateTime>(
            id: 'Mobile',
            data: [
              TimeSeriesSales(DateTime(2017, 9, 19), 10),
              TimeSeriesSales(DateTime(2017, 9, 26), 50),
              TimeSeriesSales(DateTime(2017, 10, 3), 200),
              TimeSeriesSales(DateTime(2017, 10, 10), 150),
            ],
            domainFn: (sales, _) => sales.time,
            measureFn: (sales, _) => sales.sales,
          ),
        ];

/// Creates sample data for a numeric combo chart.
List<charts.Series<LinearSales, num>> createSampleNumericComboData() => [
      charts.Series<LinearSales, num>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: [
          LinearSales(2015, 5),
          LinearSales(2016, 25),
          LinearSales(2017, 100),
          LinearSales(2018, 75),
        ],
      ),
      charts.Series<LinearSales, num>(
        id: 'customBar',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: [
          LinearSales(2015, 25),
          LinearSales(2016, 50),
          LinearSales(2017, 200),
          LinearSales(2018, 150),
        ],
      ),
    ];

/// Creates sample data for an ordinal combo chart.
List<charts.Series<OrdinalSales, String>> createSampleOrdinalComboData() => [
      charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: [
          OrdinalSales('2015', 5),
          OrdinalSales('2016', 25),
          OrdinalSales('2017', 100),
          OrdinalSales('2018', 75),
        ],
      ),
      charts.Series<OrdinalSales, String>(
        id: 'customBar',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: [
          OrdinalSales('2015', 25),
          OrdinalSales('2016', 50),
          OrdinalSales('2017', 200),
          OrdinalSales('2018', 150),
        ],
      ),
    ];

/// Creates sample data for a stacked bar chart.
List<charts.Series<OrdinalSales, String>> createSampleStackedBarData() => [
      charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: [
          OrdinalSales('2015', 5),
          OrdinalSales('2016', 25),
          OrdinalSales('2017', 100),
          OrdinalSales('2018', 75),
        ],
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: [
          OrdinalSales('2015', 25),
          OrdinalSales('2016', 50),
          OrdinalSales('2017', 200),
          OrdinalSales('2018', 150),
        ],
      ),
    ];

/// Creates sample data for a grouped bar chart.
List<charts.Series<OrdinalSales, String>> createSampleGroupedBarData() => [
      charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: [
          OrdinalSales('2015', 5),
          OrdinalSales('2016', 25),
          OrdinalSales('2017', 100),
          OrdinalSales('2018', 75),
        ],
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: [
          OrdinalSales('2015', 25),
          OrdinalSales('2016', 50),
          OrdinalSales('2017', 200),
          OrdinalSales('2018', 150),
        ],
      ),
    ];

/// Sample ordinal data type.
class OrdinalSales {
  OrdinalSales(this.year, this.sales);
  final String year;
  final int sales;
}

/// Sample linear data type.
class LinearSales {
  LinearSales(this.year, this.sales);
  final int year;
  final int sales;
}

/// Sample time series data type.
class TimeSeriesSales {
  TimeSeriesSales(this.time, this.sales);
  final DateTime time;
  final int sales;
}
