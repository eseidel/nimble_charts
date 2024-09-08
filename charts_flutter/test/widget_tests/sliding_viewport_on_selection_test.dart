import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;
import 'package:nimble_charts/flutter.dart';

import '../test_functions.dart';

/// Creates sample data for the chart.
List<charts.Series<OrdinalSales, String>> createSampleData() => [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: [
          OrdinalSales('2014', 5),
          OrdinalSales('2015', 25),
          OrdinalSales('2016', 100),
          OrdinalSales('2017', 75),
          OrdinalSales('2018', 33),
          OrdinalSales('2019', 80),
          OrdinalSales('2020', 21),
          OrdinalSales('2021', 77),
        ],
      ),
    ];

/// Builds the chart widget for testing.
Widget buildTestChart() => MaterialApp(
      home: Scaffold(
        body: SizedBox(
          height: 400,
          width: 600,
          child: charts.BarChart(
            createSampleData(),
            animate: false,
            behaviors: [
              charts.SlidingViewport(),
              charts.PanAndZoomBehavior(),
            ],
            domainAxis: charts.OrdinalAxisSpec(
              viewport: charts.OrdinalViewport('2016', 3),
            ),
          ),
        ),
      ),
    );

/// Custom finder to get the BarChart widget
Finder findBarChart() => find.byType(charts.BarChart);

/// Helper function to get the current viewport
charts.OrdinalViewport getCurrentViewport(WidgetTester tester) {
  final chart = tester.widget<BarChart>(findBarChart());
  final domainAxis = chart.domainAxis! as OrdinalAxisSpec;
  return domainAxis.viewport!;
}

void main() {
  group('SlidingViewport Behavior Tests', () {
    testWidgets('Initial viewport is correct', (tester) async {
      await tester.pumpWidget(buildTestChart());
      await tester.pumpAndSettle();

      await matchesGolden<charts.BarChart>('sliding_viewport_initial');

      final viewport = getCurrentViewport(tester);
      expect(viewport.dataSize, 3);
      //Is this correct?
      //expect(viewport, ['2015', '2016', '2017']);
    });

    testWidgets('Sliding viewport updates on pan', (tester) async {
      await tester.pumpWidget(buildTestChart());
      await tester.pumpAndSettle();

      await tester.drag(findBarChart(), const Offset(-100, 0));
      await tester.pumpAndSettle();

      await matchesGolden<charts.BarChart>('sliding_viewport_after_pan');

      final viewport = getCurrentViewport(tester);
      expect(viewport.dataSize, 3);
      //expect(viewport, ['2017', '2018', '2019']);
    });

    testWidgets('Zoom in changes the number of visible bars', (tester) async {
      await tester.pumpWidget(buildTestChart());
      await tester.pumpAndSettle();

      // Simulate pinch to zoom in
      await tester.timedDrag(
        findBarChart(),
        const Offset(0, -50),
        const Duration(milliseconds: 300),
        pointer: 1,
      );
      await tester.pumpAndSettle();

      await matchesGolden<charts.BarChart>('sliding_viewport_zoomed_in');

      // ignore: unused_local_variable
      final viewport = getCurrentViewport(tester);
      //TODO: what should go here?
      //expect(viewport.dataSize, lessThan(3));
    });

    testWidgets('Zoom out changes the number of visible bars', (tester) async {
      await tester.pumpWidget(buildTestChart());
      await tester.pumpAndSettle();

      // Simulate pinch to zoom out
      await tester.timedDrag(
        findBarChart(),
        const Offset(0, 50),
        const Duration(milliseconds: 300),
        pointer: 1,
      );
      await tester.pumpAndSettle();

      await matchesGolden<charts.BarChart>('sliding_viewport_zoomed_out');

      // ignore: unused_local_variable
      final viewport = getCurrentViewport(tester);
      //TODO: what should go here?
      //expect(viewport.dataSize, greaterThan(3));
    });
  });
}

class OrdinalSales {
  OrdinalSales(this.year, this.sales);
  final String year;
  final int sales;
}
