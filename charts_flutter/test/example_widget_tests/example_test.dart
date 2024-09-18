// ignore_for_file: avoid_relative_lib_imports

import 'package:flutter/material.dart';
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
      'Main Menu',
      (tester) async {
        final galleryApp = m.GalleryApp();

        await tester.pumpWidget(galleryApp);

        tester.viewOf(find.byWidget(galleryApp))
          ..physicalSize = const Size(2000, 7000)
          ..devicePixelRatio = 1;

        await tester.pumpAndSettle();

        await matchesGolden<m.GalleryApp>(
          'example_menu',
        );
      },
    );

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

    testWidgets(
      'Navigates to Grouped Stacked Bar Chart and Renders',
      (tester) async =>
          tester.navigateToChartAndGolden(b.groupedStackedBarChartTileTitle),
    );

    testWidgets(
      'Navigates to Grouped Bar Target Line Chart and Renders',
      (tester) async =>
          tester.navigateToChartAndGolden(b.groupedBarTargetLineChartTileTitle),
    );

    testWidgets(
      'Navigates to Grouped Bar Single Target Line Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden(
        b.groupedBarSingleTargetLineChartTileTitle,
      ),
    );

    testWidgets(
      'Navigates to Stacked Bar Target Line Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden(
        b.stackedBarTargetLineChart,
        scroll: true,
      ),
    );

    testWidgets(
      'Navigates to Horizontal Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden(
        b.horizontalBarChart,
        scroll: true,
      ),
    );
  });
}

extension ExampleWidgetTestExtensions on WidgetTester {
  /// Taps on the button and takes a golden screenshot of the chart.
  Future<void> navigateToChartAndGolden(
    String buttonText, {
    Future<void> Function()? extra,
    bool scroll = false,
  }) async {
    final galleryApp = m.GalleryApp();

    await pumpWidget(galleryApp);

    viewOf(find.byWidget(galleryApp))
      ..physicalSize = const Size(1200, 700)
      ..devicePixelRatio = 1;

    expect(find.byType(h.Home), findsOneWidget);
    if (scroll) {
      await scrollUntilVisible(find.text(buttonText), 200);
    }
    await tap(find.text(buttonText));
    await pumpAndSettle();
    expect(find.byType(charts.BarChart), findsOneWidget);
    await extra?.call();
    await matchesGolden<charts.BarChart>(
      'example_${buttonText.replaceAll(' ', '_').toLowerCase()}',
    );
  }
}
