import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

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
      // Add expectations for empty chart behavior
    });

    testWidgets('Handles large datasets', (WidgetTester tester) async {
      final largeSeriesList = [
        charts.Series<OrdinalSales, String>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: List.generate(1000, (index) => OrdinalSales(index.toString(), index)),
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
      // Add expectations for large dataset behavior
    });

    // Add more corner case tests:
    // - Test with negative values
    // - Test with very small or very large values
    // - Test with non-uniform data (e.g., some null values)
    // - Test responsiveness to different screen sizes
  });
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}