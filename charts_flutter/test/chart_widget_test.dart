import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

void main() {
  group('Chart Widget Tests', () {
    testWidgets('BarChart renders correctly', (WidgetTester tester) async {
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

      await expectLater(
        find.byType(charts.BarChart),
        matchesGoldenFile('golden_bar_chart.png'),
      );
    });

    testWidgets('LineChart renders correctly', (WidgetTester tester) async {
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

      await expectLater(
        find.byType(charts.LineChart),
        matchesGoldenFile('golden_line_chart.png'),
      );
    });

    testWidgets('TimeSeriesChart renders correctly', (WidgetTester tester) async {
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

      await expectLater(
        find.byType(charts.TimeSeriesChart),
        matchesGoldenFile('golden_time_series_chart.png'),
      );
    });

    testWidgets('BarChart with custom colors renders correctly', (WidgetTester tester) async {
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

      await expectLater(
        find.byType(charts.BarChart),
        matchesGoldenFile('golden_bar_chart_custom_colors.png'),
      );
    });

    testWidgets('LineChart with points renders correctly', (WidgetTester tester) async {
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

      await expectLater(
        find.byType(charts.LineChart),
        matchesGoldenFile('golden_line_chart_with_points.png'),
      );
    });

    testWidgets('TimeSeriesChart with multiple series renders correctly', (WidgetTester tester) async {
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

      await expectLater(
        find.byType(charts.TimeSeriesChart),
        matchesGoldenFile('golden_time_series_chart_multiple.png'),
      );
    });
  });
}

/// Creates sample data for a bar chart.
List<charts.Series<OrdinalSales, String>> createSampleBarData() =>
  [
    charts.Series<OrdinalSales, String>(
      id: 'Sales',
      data: [
        OrdinalSales('2014', 5),
        OrdinalSales('2015', 25),
        OrdinalSales('2016', 100),
        OrdinalSales('2017', 75),
      ],
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
    )
  ];

/// Creates sample data for a line chart.
List<charts.Series<LinearSales, int>> createSampleLineData() =>
  [
    charts.Series<LinearSales, int>(
      id: 'Sales',
      data: [
        LinearSales(0, 5),
        LinearSales(1, 25),
        LinearSales(2, 100),
        LinearSales(3, 75),
      ],
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
    )
  ];

/// Creates sample data for a time series chart.
List<charts.Series<TimeSeriesSales, DateTime>> createSampleTimeSeriesData() =>
  [
    charts.Series<TimeSeriesSales, DateTime>(
      id: 'Sales',
      data: [
        TimeSeriesSales(DateTime(2017, 9, 19), 5),
        TimeSeriesSales(DateTime(2017, 9, 26), 25),
        TimeSeriesSales(DateTime(2017, 10, 3), 100),
        TimeSeriesSales(DateTime(2017, 10, 10), 75),
      ],
      domainFn: (TimeSeriesSales sales, _) => sales.time,
      measureFn: (TimeSeriesSales sales, _) => sales.sales,
    )
  ];

/// Creates sample data for a bar chart with custom colors.
List<charts.Series<OrdinalSales, String>> createSampleBarDataWithCustomColors() =>
  [
    charts.Series<OrdinalSales, String>(
      id: 'Sales',
      data: [
        OrdinalSales('2014', 5),
        OrdinalSales('2015', 25),
        OrdinalSales('2016', 100),
        OrdinalSales('2017', 75),
      ],
      domainFn: (OrdinalSales sales, _) => sales.year,
      measureFn: (OrdinalSales sales, _) => sales.sales,
      colorFn: (OrdinalSales sales, _) {
        switch (sales.year) {
          case '2014': return charts.MaterialPalette.blue.shadeDefault;
          case '2015': return charts.MaterialPalette.red.shadeDefault;
          case '2016': return charts.MaterialPalette.green.shadeDefault;
          case '2017': return charts.MaterialPalette.yellow.shadeDefault;
          default: return charts.MaterialPalette.gray.shadeDefault;
        }
      },
    )
  ];

/// Creates sample data for a line chart with points.
List<charts.Series<LinearSales, int>> createSampleLineDataWithPoints() =>
  [
    charts.Series<LinearSales, int>(
      id: 'Sales',
      data: [
        LinearSales(0, 5),
        LinearSales(1, 25),
        LinearSales(2, 100),
        LinearSales(3, 75),
      ],
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
    )
  ];

/// Creates sample data for a time series chart with multiple series.
List<charts.Series<TimeSeriesSales, DateTime>> createSampleMultipleTimeSeriesData() =>
  [
    charts.Series<TimeSeriesSales, DateTime>(
      id: 'Desktop',
      data: [
        TimeSeriesSales(DateTime(2017, 9, 19), 5),
        TimeSeriesSales(DateTime(2017, 9, 26), 25),
        TimeSeriesSales(DateTime(2017, 10, 3), 100),
        TimeSeriesSales(DateTime(2017, 10, 10), 75),
      ],
      domainFn: (TimeSeriesSales sales, _) => sales.time,
      measureFn: (TimeSeriesSales sales, _) => sales.sales,
    ),
    charts.Series<TimeSeriesSales, DateTime>(
      id: 'Mobile',
      data: [
        TimeSeriesSales(DateTime(2017, 9, 19), 10),
        TimeSeriesSales(DateTime(2017, 9, 26), 50),
        TimeSeriesSales(DateTime(2017, 10, 3), 200),
        TimeSeriesSales(DateTime(2017, 10, 10), 150),
      ],
      domainFn: (TimeSeriesSales sales, _) => sales.time,
      measureFn: (TimeSeriesSales sales, _) => sales.sales,
    ),
  ];

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}