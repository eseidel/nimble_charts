import 'package:example/bar_chart/bar_gallery.dart';
import 'package:example/bar_chart/grouped_stacked.dart';
import 'package:example/bar_chart/grouped_target_line.dart';
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
];
