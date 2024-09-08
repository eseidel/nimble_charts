import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

import '../test_functions.dart';

void main() {
  group('BarChart Widget Tests', () {
    testWidgets('Renders basic bar chart', (tester) async {
      final seriesList = [
        charts.Series<OrdinalSales, String>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (sales, _) => sales.year,
          measureFn: (sales, _) => sales.sales,
          data: [
            OrdinalSales('2014', 5),
            OrdinalSales('2015', 25),
            OrdinalSales('2016', 100),
            OrdinalSales('2017', 75),
          ],
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.BarChart(
                seriesList,
                animate: false,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(charts.BarChart), findsOneWidget);

      await matchesGolden<charts.BarChart>(
        'golden_bar_chart',
      );
    });

    // Add more test cases here, e.g.:
    // - Test with multiple series
    // - Test with different color schemes
    // - Test with custom axis specifications
    // - Test with behaviors like legends or tooltips
  });
}

class OrdinalSales {
  OrdinalSales(this.year, this.sales);
  final String year;
  final int sales;
}
