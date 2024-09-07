import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

void main() {
  group('Chart Interactions', () {
    testWidgets('Supports tap selection', (WidgetTester tester) async {
      final seriesList = [
        charts.Series<OrdinalSales, String>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: [
            OrdinalSales('2014', 5),
            OrdinalSales('2015', 25),
            OrdinalSales('2016', 100),
            OrdinalSales('2017', 75),
          ],
        )
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
                    type: charts.SelectionModelType.info,
                    changedListener: (charts.SelectionModel<String> model) {
                      selectionModel = model;
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(charts.BarChart));
      await tester.pump();

      expect(selectionModel, isNotNull);
      expect(selectionModel!.selectedDatum, isNotEmpty);
      // Add more specific expectations about the selection
    });

    // Add more interaction tests:
    // - Test pan and zoom behaviors
    // - Test tooltip display
    // - Test legend interactions
  });
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}