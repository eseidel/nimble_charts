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
  'sales': (
    name: 'sales',
    display: 'Sales',
    icon: Icons.attach_money,
    blurb: 'Represents sales performance and metrics.',
  ),
  'performance': (
    name: 'performance',
    display: 'Performance',
    icon: Icons.speed,
    blurb: 'Tracks key performance indicators and benchmarks.',
  ),
};

List<ChartSampleDefinition> chartSampleDefinitions = [
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.cake,
    build: (context, item) => GroupedStackedBarChart.withRandomData(),
    title: groupedStackedBarChartTileTitle,
    subtitle: groupedStackedBarChartTileSubtitle,
  ),
  ChartSampleDefinition(
    tags: [tagDefinitions['bar']!],
    icon: Icons.beach_access,
    build: (context, item) => GroupedBarTargetLineChart.withRandomData(),
    title: groupedBarTargetLineChartTileTitle,
    subtitle: groupedBarTargetLineChartTileSubtitle,
  ),
];
