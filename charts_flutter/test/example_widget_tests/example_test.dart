// ignore_for_file: avoid_relative_lib_imports

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

import '../../example/lib/bar_chart/bar_gallery.dart' as b;

import '../../example/lib/home.dart' as h;
import '../../example/lib/main.dart' as m;

import '../test_functions.dart';

/// Widget tests for the example app.
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
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.simpleBarChartTileTitle,
        extra: () async {
          await tester.tap(find.byType(charts.BarChart));
          await tester.pumpAndSettle();
        },
      ),
    );

    testWidgets(
      'Navigates to Stacked Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.stackedBarChartTileTitle,
      ),
    );

    testWidgets(
      'Navigates to Grouped Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.groupedBarChartTileTitle,
      ),
    );

    testWidgets(
      'Navigates to Grouped Stacked Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.groupedStackedBarChartTileTitle,
      ),
    );

    testWidgets(
      'Navigates to Grouped Bar Target Line Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.groupedBarTargetLineChartTileTitle,
      ),
    );

    testWidgets(
      'Navigates to Grouped Bar Single Target Line Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.groupedBarSingleTargetLineChartTileTitle,
      ),
    );

    testWidgets(
      'Navigates to Stacked Bar Target Line Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.stackedBarTargetLineChart,
        scrollDelta: 200,
      ),
    );

    testWidgets(
      'Navigates to Horizontal Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.horizontalBarChart,
        scrollDelta: 200,
      ),
    );

    testWidgets(
      'Navigates to Stacked Horizontal Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.stackedHorizontalBarChart,
        scrollDelta: 200,
      ),
    );

    testWidgets(
      'Navigates to Horizontal Bar Chart with Bar Labels and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.horizontalBarLabelChart,
        scrollDelta: 200,
      ),
    );

    testWidgets(
      'Navigates to Horizontal Bar Chart with Custom Bar Labels and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.horizontalBarLabelCustomChart,
        scrollDelta: 300,
      ),
    );

    testWidgets(
      'Navigates to Vertical Bar Chart with Bar Labels and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.verticalBarLabelChart,
        scrollDelta: 300,
      ),
    );

    testWidgets(
      'Navigates to Spark Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.sparkBarChart,
        scrollDelta: 300,
      ),
    );

    testWidgets(
      'Navigates to Grouped Fill Color Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.groupedFillColorChart,
        scrollDelta: 300,
      ),
    );

    testWidgets(
      'Navigates to Stacked Fill Color Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.stackedFillColorChart,
        scrollDelta: 300,
      ),
    );
    testWidgets(
      'Navigates to Pattern Forward Hatch Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.patternForwardHatchChart,
        scrollDelta: 350,
      ),
    );

    testWidgets(
      'Navigates to Horizontal Pattern Forward Hatch Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.horizontalPatternForwardHatchChart,
        scrollDelta: 300,
      ),
    );

    testWidgets(
      'Navigates to Weighted Pattern Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.weightedPatternChart,
        scrollDelta: 300,
      ),
    );

    testWidgets(
      'Navigates to Bar Chart with custom bar radius and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        b.barChartWithCustomBarRadius,
        scrollDelta: 300,
      ),
    );
  });
}

extension ExampleWidgetTestExtensions on WidgetTester {
  /// Taps on the button and takes a golden screenshot of the chart.
  Future<void> navigateToChartAndGolden<T extends Widget>(
    String tileText, {
    Future<void> Function()? extra,
    double? scrollDelta,
  }) async {
    //Create an pump
    final galleryApp = m.GalleryApp();
    await pumpWidget(galleryApp);

    //Set the screen size of the widget
    viewOf(find.byWidget(galleryApp))
      ..physicalSize = const Size(1200, 700)
      ..devicePixelRatio = 1;

    expect(find.byType(h.Home), findsOneWidget);

    // Find the list tile by text
    final tileFinder = find.byWidgetPredicate(
      (w) => switch (w) {
        final ListTile l => switch (l.title) {
            final Text t when t.data == tileText => true,
            _ => false
          },
        _ => false
      },
    );

    // Scroll to the button if needed.
    if (scrollDelta != null) {
      await scrollUntilVisible(tileFinder, scrollDelta);
    }

    // Tap the tile
    await tap(tileFinder);
    await pumpAndSettle();
    await pump(const Duration(seconds: 1));

    //Check that the chart exists
    expect(find.byType(T), findsOneWidget);

    // Do extra assertions
    await extra?.call();

    await matchesGolden<T>(
      'example_${tileText.replaceAll(' ', '_').toLowerCase()}',
    );
  }
}
