import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

import 'test_functions.dart';

void main() {
  group('Chart Customization', () {
    testWidgets('Applies custom axis specifications', (tester) async {
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
                domainAxis: charts.OrdinalAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      fontSize: 18,
                      color: charts.MaterialPalette.red.shadeDefault,
                    ),
                  ),
                ),
                primaryMeasureAxis: const charts.NumericAxisSpec(
                  tickProviderSpec: charts.BasicNumericTickProviderSpec(
                    desiredTickCount: 5,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(charts.BarChart), findsOneWidget);

      await matchesGolden<charts.BarChart>('golden_customized_bar_chart.png');
    });

    // Add more customization tests here
  });
}

class OrdinalSales {
  OrdinalSales(this.year, this.sales);
  final String year;
  final int sales;
}
