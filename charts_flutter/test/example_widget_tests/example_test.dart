// ignore_for_file: avoid_relative_lib_imports

import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

import '../../example/lib/bar_chart/bar_gallery.dart' as b;
import '../../example/lib/home.dart' as h;
import '../../example/lib/main.dart' as m;
import '../test_functions.dart';

void main() {
  group('ExampleApp Widget Tests', () {
    m.useRandomData = false;

    testWidgets(
      'Navigates to Simple Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden(
        b.simpleBarChartTileTitle,
        extra: () async {
          await tester.tap(find.byType(charts.BarChart));
          await tester.pumpAndSettle();
        },
      ),
    );

    testWidgets(
      'Navigates to Stacked Bar Chart and Renders',
      (tester) async =>
          tester.navigateToChartAndGolden(b.stackedBarChartTileTitle),
    );

    testWidgets(
      'Navigates to Grouped Bar Chart and Renders',
      (tester) async =>
          tester.navigateToChartAndGolden(b.groupedBarChartTileTitle),
    );
  });
}

extension ExampleWidgetTestExtensions on WidgetTester {
  /// Taps on the button and takes a golden screenshot of the chart.
  Future<void> navigateToChartAndGolden(
    String buttonText, {
    Future<void> Function()? extra,
  }) async {
    await pumpWidget(m.GalleryApp());
    expect(find.byType(h.Home), findsOneWidget);
    await tap(find.text(buttonText));
    await pumpAndSettle();
    expect(find.byType(charts.BarChart), findsOneWidget);
    await extra?.call();
    await matchesGolden<charts.BarChart>(
      'example_${buttonText.replaceAll(' ', '_').toLowerCase()}',
    );
  }
}
