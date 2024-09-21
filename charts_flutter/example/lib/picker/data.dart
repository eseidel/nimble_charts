import 'package:example/bar_chart/bar_gallery.dart';
import 'package:example/bar_chart/custom_rounded_bars.dart';
import 'package:example/bar_chart/grouped.dart';
import 'package:example/bar_chart/grouped_fill_color.dart';
import 'package:example/bar_chart/grouped_single_target_line.dart';
import 'package:example/bar_chart/grouped_stacked.dart';
import 'package:example/bar_chart/grouped_stacked_weight_pattern.dart';
import 'package:example/bar_chart/grouped_target_line.dart';
import 'package:example/bar_chart/horizontal.dart';
import 'package:example/bar_chart/horizontal_bar_label.dart';
import 'package:example/bar_chart/horizontal_bar_label_custom.dart';
import 'package:example/bar_chart/horizontal_pattern_forward_hatch.dart';
import 'package:example/bar_chart/pattern_forward_hatch.dart';
import 'package:example/bar_chart/simple.dart';
import 'package:example/bar_chart/spark_bar.dart';
import 'package:example/bar_chart/stacked.dart';
import 'package:example/bar_chart/stacked_fill_color.dart';
import 'package:example/bar_chart/stacked_horizontal.dart';
import 'package:example/bar_chart/stacked_target_line.dart';
import 'package:example/bar_chart/vertical_bar_label.dart';
import 'package:example/line_chart/animation_zoom.dart';
import 'package:example/line_chart/area_and_line.dart';
import 'package:example/line_chart/dash_pattern.dart';
import 'package:example/line_chart/line_annotation.dart';
import 'package:example/line_chart/line_gallery.dart';
import 'package:example/line_chart/points.dart';
import 'package:example/line_chart/range_annotation.dart';
import 'package:example/line_chart/range_annotation_margin.dart';
import 'package:example/line_chart/segments.dart';
import 'package:example/line_chart/simple.dart';
import 'package:example/line_chart/simple_nulls.dart';
import 'package:example/line_chart/stacked_area.dart';
import 'package:example/line_chart/stacked_area_custom_color.dart';
import 'package:example/line_chart/stacked_area_nulls.dart';
import 'package:example/picker/model.dart';
import 'package:example/picker/tag_item_selector.dart';
import 'package:flutter/material.dart';

const tagDefinitions = <String, TagDefinition>{
  'bar': (
    name: 'bar',
    display: 'Bar',
    icon: Icons.bar_chart,
    blurb: 'Displays categorical data using rectangular bars.',
  ),
  'line': (
    name: 'line',
    display: 'Line',
    icon: Icons.show_chart,
    blurb: 'Shows trends over time with continuous data points.',
  ),
  'scatter': (
    name: 'scatter',
    display: 'Scatter',
    icon: Icons.scatter_plot,
    blurb: 'Displays relationships between two variables.',
  ),
  'time': (
    name: 'time',
    display: 'Time Series',
    icon: Icons.access_time,
    blurb: 'Visualizes data points over time.',
  ),
  'combo': (
    name: 'combo',
    display: 'Combo',
    icon: Icons.multiline_chart,
    blurb: 'Combines multiple chart types in a single visualization.',
  ),
};

List<ChartSampleDefinition> chartSampleDefinitions = [
  // Bar Charts
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => SimpleBarChart.withRandomData(),
    title: simpleBarChartTileTitle,
    subtitle: simpleBarChartTileSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => StackedBarChart.withRandomData(),
    title: stackedBarChartTileTitle,
    subtitle: stackedBarChartTileSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => GroupedBarChart.withRandomData(),
    title: groupedBarChartTileTitle,
    subtitle: groupedBarChartTileSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => GroupedStackedBarChart.withRandomData(),
    title: groupedStackedBarChartTileTitle,
    subtitle: groupedStackedBarChartTileSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => GroupedBarTargetLineChart.withRandomData(),
    title: groupedBarTargetLineChartTileTitle,
    subtitle: groupedBarTargetLineChartTileSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => GroupedBarSingleTargetLineChart.withRandomData(),
    title: groupedBarSingleTargetLineChartTileTitle,
    subtitle: groupedBarSingleTargetLineChartTileSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => StackedBarTargetLineChart.withRandomData(),
    title: stackedBarTargetLineChartTitle,
    subtitle: stackedBarTargetLineChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => HorizontalBarChart.withRandomData(),
    title: horizontalBarChartTitle,
    subtitle: horizontalBarChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => StackedHorizontalBarChart.withRandomData(),
    title: stackedHorizontalBarChartTitle,
    subtitle: stackedHorizontalBarChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => HorizontalBarLabelChart.withRandomData(),
    title: horizontalBarLabelChartTitle,
    subtitle: horizontalBarLabelChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => HorizontalBarLabelCustomChart.withRandomData(),
    title: horizontalBarLabelCustomChartTitle,
    subtitle: horizontalBarLabelCustomChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => VerticalBarLabelChart.withRandomData(),
    title: verticalBarLabelChartTitle,
    subtitle: verticalBarLabelChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => SparkBar.withRandomData(),
    title: sparkBarChartTitle,
    subtitle: sparkBarChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => GroupedFillColorBarChart.withRandomData(),
    title: groupedFillColorChartTitle,
    subtitle: groupedFillColorChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => StackedFillColorBarChart.withRandomData(),
    title: stackedFillColorChartTitle,
    subtitle: stackedFillColorChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => PatternForwardHatchBarChart.withRandomData(),
    title: patternForwardHatchChartTitle,
    subtitle: patternForwardHatchChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) =>
        HorizontalPatternForwardHatchBarChart.withRandomData(),
    title: horizontalPatternForwardHatchChartTitle,
    subtitle: horizontalPatternForwardHatchChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) =>
        GroupedStackedWeightPatternBarChart.withRandomData(),
    title: weightedPatternChartTitle,
    subtitle: weightedPatternChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.bar_chart,
    build: (context, item) => CustomRoundedBars.withRandomData(),
    title: barChartWithCustomBarRadiusTitle,
    subtitle: barChartWithCustomBarRadiusSubtitle,
  ),

  // Line Charts
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => SimpleLineChart.withRandomData(),
    title: simpleLineChartTitle,
    subtitle: simpleLineChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => StackedAreaLineChart.withRandomData(),
    title: stackedAreaLineChartTitle,
    subtitle: stackedAreaLineChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => StackedAreaCustomColorLineChart.withRandomData(),
    title: stackedAreaCustomColorLineChartTitle,
    subtitle: stackedAreaCustomColorLineChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => AreaAndLineChart.withRandomData(),
    title: areaAndLineChartTitle,
    subtitle: areaAndLineChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => PointsLineChart.withRandomData(),
    title: pointsLineChartTitle,
    subtitle: pointsLineChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => SimpleNullsLineChart.withRandomData(),
    title: simpleNullsLineChartTitle,
    subtitle: simpleNullsLineChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => StackedAreaNullsLineChart.withRandomData(),
    title: stackedAreaNullsLineChartTitle,
    subtitle: stackedAreaNullsLineChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => DashPatternLineChart.withRandomData(),
    title: dashPatternLineChartTitle,
    subtitle: dashPatternLineChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => SegmentsLineChart.withRandomData(),
    title: segmentsLineChartTitle,
    subtitle: segmentsLineChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => LineLineAnnotationChart.withRandomData(),
    title: lineLineAnnotationChartTitle,
    subtitle: lineLineAnnotationChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => LineRangeAnnotationChart.withRandomData(),
    title: lineRangeAnnotationChartTitle,
    subtitle: lineRangeAnnotationChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => LineRangeAnnotationMarginChart.withRandomData(),
    title: lineRangeAnnotationMarginChartTitle,
    subtitle: lineRangeAnnotationMarginChartSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['line']!],
    icon: Icons.show_chart,
    build: (context, item) => LineAnimationZoomChart.withRandomData(),
    title: lineAnimationZoomChartTitle,
    subtitle: lineAnimationZoomChartSubtitle,
  ),
];
