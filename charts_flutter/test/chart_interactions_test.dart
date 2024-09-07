import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

import 'test_functions.dart';

void main() {
  group('Chart Interactions', () {
    testWidgets('Supports tap selection', (tester) async {
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

      charts.SelectionModel<String>? selectionModel;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: charts.BarChart(
                seriesList,
                animate: false,
                selectionModels: [
                  charts.SelectionModelConfig(
                    changedListener: (model) {
                      selectionModel = model;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await matchesGolden<charts.BarChart>('golden_bar_chart_before_selection');

      await tester.tap(find.byType(charts.BarChart));
      await tester.pump();

      expect(selectionModel, isNotNull);
      expect(selectionModel!.selectedDatum, isNotEmpty);

      await matchesGolden<charts.BarChart>('golden_bar_chart_after_selection');
    });

    // Add more interaction tests here
  });
}

class OrdinalSales {
  OrdinalSales(this.year, this.sales);
  final String year;
  final int sales;
}
