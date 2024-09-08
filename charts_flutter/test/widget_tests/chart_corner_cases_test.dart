import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

import '../test_functions.dart';

void main() {
  group('Chart Corner Cases', () {
    testWidgets('Handles empty data', (tester) async {
      final emptySeriesList = [
        charts.Series<OrdinalSales, String>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (sales, _) => sales.year,
          measureFn: (sales, _) => sales.sales,
          data: [],
        ),
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

      await matchesGolden<charts.BarChart>('golden_empty_bar_chart');
    });

    testWidgets('Handles large datasets', (tester) async {
      final largeSeriesList = [
        charts.Series<OrdinalSales, String>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (sales, _) => sales.year,
          measureFn: (sales, _) => sales.sales,
          data: List.generate(
            1000,
            (index) => OrdinalSales(index.toString(), index),
          ),
        ),
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

      await matchesGolden<charts.BarChart>('golden_large_dataset_bar_chart');
    });

    // Add more corner case tests here
  });
}

class OrdinalSales {
  OrdinalSales(this.year, this.sales);
  final String year;
  final int sales;
}
