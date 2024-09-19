import 'package:example/bar_chart/bar_gallery.dart';
import 'package:example/home.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;

import '../test_functions.dart';

/// Widget tests for the example app.
void main() {
  group('ExampleApp Widget Tests', () {
    useRandomData = false;

    testWidgets(
      'Main Menu',
      (tester) async {
        const galleryApp = GalleryApp();

        await tester.pumpWidget(galleryApp);

        tester.viewOf(find.byWidget(galleryApp))
          ..physicalSize = const Size(2000, 7000)
          ..devicePixelRatio = 1;

        await tester.pumpAndSettle();

        await matchesGolden<GalleryApp>(
          'example_menu',
        );
      },
    );

    testWidgets(
      'Navigates to Simple Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        simpleBarChartTileTitle,
        extra: () async {
          await tester.tap(find.byType(charts.BarChart));
          await tester.pumpAndSettle();
        },
      ),
    );

    testWidgets(
      'Navigates to Stacked Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        stackedBarChartTileTitle,
      ),
    );

    testWidgets(
      'Navigates to Grouped Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        groupedBarChartTileTitle,
      ),
    );

    testWidgets(
      'Navigates to Grouped Stacked Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        groupedStackedBarChartTileTitle,
      ),
    );

    testWidgets(
      'Navigates to Grouped Bar Target Line Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        groupedBarTargetLineChartTileTitle,
      ),
    );

    testWidgets(
      'Navigates to Grouped Bar Single Target Line Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        groupedBarSingleTargetLineChartTileTitle,
      ),
    );

    testWidgets(
      'Navigates to Stacked Bar Target Line Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        stackedBarTargetLineChart,
        scrollDelta: 200,
      ),
    );

    testWidgets(
      'Navigates to Horizontal Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        horizontalBarChart,
        scrollDelta: 200,
      ),
    );

    testWidgets(
      'Navigates to Stacked Horizontal Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        stackedHorizontalBarChart,
        scrollDelta: 200,
      ),
    );

    testWidgets(
      'Navigates to Horizontal Bar Chart with Bar Labels and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        horizontalBarLabelChart,
        scrollDelta: 200,
      ),
    );

    testWidgets(
      'Navigates to Horizontal Bar Chart with Custom Bar Labels and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        horizontalBarLabelCustomChart,
        scrollDelta: 300,
      ),
    );

    testWidgets(
      'Navigates to Vertical Bar Chart with Bar Labels and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        verticalBarLabelChart,
        scrollDelta: 300,
      ),
    );

    testWidgets(
      'Navigates to Spark Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        sparkBarChart,
        scrollDelta: 300,
      ),
    );

    testWidgets(
      'Navigates to Grouped Fill Color Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        groupedFillColorChart,
        scrollDelta: 300,
      ),
    );

    testWidgets(
      'Navigates to Stacked Fill Color Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        stackedFillColorChart,
        scrollDelta: 300,
      ),
    );

    //TODO: Fix this test. For some reason, we can't find the bar chart
    //in the widget tree. 🤷🏼‍♂️
    testWidgets(
      'Navigates to Pattern Forward Hatch Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        patternForwardHatchChart,
        scrollDelta: 300,
      ),
      skip: true,
    );

    testWidgets(
      'Navigates to Horizontal Pattern Forward Hatch Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        horizontalPatternForwardHatchChart,
        scrollDelta: 300,
      ),
    );

    testWidgets(
      'Navigates to Weighted Pattern Bar Chart and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        weightedPatternChart,
        scrollDelta: 300,
      ),
    );

    testWidgets(
      'Navigates to Bar Chart with custom bar radius and Renders',
      (tester) async => tester.navigateToChartAndGolden<charts.BarChart>(
        barChartWithCustomBarRadius,
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
    //Create and pump
    const galleryApp = GalleryApp();
    await pumpWidget(galleryApp);

    //Set the screen size of the widget
    viewOf(find.byWidget(galleryApp))
      ..physicalSize = const Size(1200, 700)
      ..devicePixelRatio = 1;

    expect(find.byType(Home), findsOneWidget);

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
