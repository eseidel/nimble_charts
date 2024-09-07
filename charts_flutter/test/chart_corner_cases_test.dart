import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

import 'test_functions.dart';

void main() {
  group('Chart Corner Cases', () {
    testWidgets('Handles empty data', (WidgetTester tester) async {
      final emptySeriesList = [
        charts.Series<OrdinalSales, String>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: [],
        )
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.BarChart(
                emptySeriesList,
                animate: false,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(charts.BarChart), findsOneWidget);

      await matchesGolden<charts.BarChart>('golden_empty_bar_chart.png');
    });

    testWidgets('Handles large datasets', (WidgetTester tester) async {
      final largeSeriesList = [
        charts.Series<OrdinalSales, String>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: List.generate(
              1000, (index) => OrdinalSales(index.toString(), index)),
        )
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.BarChart(
                largeSeriesList,
                animate: false,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(charts.BarChart), findsOneWidget);

      await matchesGolden<charts.BarChart>(
          'golden_large_dataset_bar_chart.png');
    });

    // Add more corner case tests here
  });
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
