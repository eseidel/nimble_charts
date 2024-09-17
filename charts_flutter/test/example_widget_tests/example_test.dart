// ignore_for_file: avoid_relative_lib_imports

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nimble_charts/flutter.dart' as charts;
import 'package:nimble_charts_common/common.dart';

import '../../example/lib/home.dart' as h;
import '../../example/lib/main.dart' as ex;
import '../test_functions.dart';

void main() {
  group('ExampleApp Widget Tests', () {
    testWidgets('Navigates to BarChart and verifies rendering', (tester) async {
      await tester.pumpWidget(ex.GalleryApp());

      // Verify the Home widget is displayed
      expect(find.byType(h.Home), findsOneWidget);

      // Tap on the BarChart navigation button
      await tester.tap(find.text('Simple Bar Chart'));
      await tester.pumpAndSettle();

      // Verify the BarChart screen is displayed
      expect(find.byType(charts.BarChart), findsOneWidget);

      // Perform interactions if necessary, e.g., tapping on bars
      await tester.tap(find.byType(charts.BarChart));
      await tester.pumpAndSettle();

      // Verify tooltip appears
      //expect(find.textContaining('2014'), findsWidgets);

      // Compare against golden file
      await matchesGolden<charts.BarChart>('golden_bar_chart_navigation');
    });

    testWidgets('Navigates to LineChart and verifies rendering',
        (tester) async {
      await tester.pumpWidget(ex.GalleryApp());

      // Verify the Home widget is displayed
      expect(find.text('Home'), findsOneWidget);

      // Tap on the LineChart navigation button
      await tester.tap(find.byKey(const Key('lineChartButton')));
      await tester.pumpAndSettle();

      // Verify the LineChart screen is displayed
      expect(find.byType(charts.LineChart), findsOneWidget);

      // Perform interactions if necessary, e.g., zooming
      await tester.drag(find.byType(charts.LineChart), const Offset(-100, 0));
      await tester.pumpAndSettle();

      // Compare against golden file
      await matchesGolden<charts.LineChart>('golden_line_chart_navigation');
    });

    testWidgets('Navigates to TimeSeriesChart and verifies rendering',
        (tester) async {
      await tester.pumpWidget(ex.GalleryApp());

      // Verify the Home widget is displayed
      expect(find.text('Home'), findsOneWidget);

      // Tap on the TimeSeriesChart navigation button
      await tester.tap(find.byKey(const Key('timeSeriesChartButton')));
      await tester.pumpAndSettle();

      // Verify the TimeSeriesChart screen is displayed
      expect(find.byType(charts.TimeSeriesChart), findsOneWidget);

      // Perform interactions if necessary, e.g., selecting a range
      await tester.tap(find.byType(charts.TimeSeriesChart));
      await tester.pumpAndSettle();

      // Verify tooltip appears
      expect(find.textContaining('Sales'), findsWidgets);

      // Compare against golden file
      await matchesGolden<charts.TimeSeriesChart>(
        'golden_time_series_chart_navigation',
      );
    });

    testWidgets('Navigates to PieChart and verifies rendering', (tester) async {
      await tester.pumpWidget(ex.GalleryApp());

      // Verify the Home widget is displayed
      expect(find.text('Home'), findsOneWidget);

      // Tap on the PieChart navigation button
      await tester.tap(find.byKey(const Key('pieChartButton')));
      await tester.pumpAndSettle();

      // Verify the PieChart screen is displayed
      expect(find.byType(charts.PieChart), findsOneWidget);

      // Perform interactions if necessary, e.g., tapping on a slice
      await tester.tap(find.byType(charts.PieChart));
      await tester.pumpAndSettle();

      // Verify tooltip appears
      expect(find.textContaining('Sales'), findsWidgets);

      // Compare against golden file
      await matchesGolden<charts.PieChart>('golden_pie_chart_navigation');
    });

    testWidgets('Navigates to SankeyChart and verifies rendering',
        (tester) async {
      await tester.pumpWidget(ex.GalleryApp());

      // Verify the Home widget is displayed
      expect(find.text('Home'), findsOneWidget);

      // Tap on the SankeyChart navigation button
      await tester.tap(find.byKey(const Key('sankeyChartButton')));
      await tester.pumpAndSettle();

      // Verify the SankeyChart screen is displayed
      expect(find.byType(SankeyChart), findsOneWidget);

      // Perform interactions if necessary, e.g., dragging nodes
      await tester.drag(find.byType(SankeyChart), const Offset(50, 0));
      await tester.pumpAndSettle();

      // Compare against golden file
      //await matchesGolden<SankeyChart>('golden_sankey_chart_navigation');
    });

    testWidgets('Navigates to ScatterPlotChart and verifies rendering',
        (tester) async {
      await tester.pumpWidget(ex.GalleryApp());

      // Verify the Home widget is displayed
      expect(find.text('Home'), findsOneWidget);

      // Tap on the ScatterPlotChart navigation button
      await tester.tap(find.byKey(const Key('scatterPlotChartButton')));
      await tester.pumpAndSettle();

      // Verify the ScatterPlotChart screen is displayed
      expect(find.byType(charts.ScatterPlotChart), findsOneWidget);

      // Perform interactions if necessary, e.g., selecting points
      await tester.tap(find.byType(charts.ScatterPlotChart));
      await tester.pumpAndSettle();

      // Verify tooltip appears
      expect(find.textContaining('Sales'), findsWidgets);

      // Compare against golden file
      await matchesGolden<charts.ScatterPlotChart>(
        'golden_scatter_plot_chart_navigation',
      );
    });

    testWidgets('Navigates to SunburstChart and verifies rendering',
        (tester) async {
      await tester.pumpWidget(ex.GalleryApp());

      // Verify the Home widget is displayed
      expect(find.text('Home'), findsOneWidget);

      // Tap on the SunburstChart navigation button
      await tester.tap(find.byKey(const Key('sunburstChartButton')));
      await tester.pumpAndSettle();

      // Verify the SunburstChart screen is displayed
      expect(find.byType(SunburstChart), findsOneWidget);

      // Perform interactions if necessary, e.g., expanding segments
      await tester.tap(find.byType(SunburstChart));
      await tester.pumpAndSettle();

      // Compare against golden file
      // await matchesGolden<SunburstChart>(
      //   'golden_sunburst_chart_navigation',
      // );
    });

    testWidgets('Navigates to TreeMapChart and verifies rendering',
        (tester) async {
      await tester.pumpWidget(ex.GalleryApp());

      // Verify the Home widget is displayed
      expect(find.text('Home'), findsOneWidget);

      // Tap on the TreeMapChart navigation button
      await tester.tap(find.byKey(const Key('treeMapChartButton')));
      await tester.pumpAndSettle();

      // Verify the TreeMapChart screen is displayed
      expect(find.byType(TreeMapChart), findsOneWidget);

      // Perform interactions if necessary, e.g., tapping on a tile
      await tester.tap(find.byType(TreeMapChart));
      await tester.pumpAndSettle();

      // Compare against golden file
      // await matchesGolden<TreeMapChart>(
      //   'golden_tree_map_chart_navigation',
      // );
    });
  });
}
