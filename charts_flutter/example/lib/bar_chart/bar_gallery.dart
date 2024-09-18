// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import '../main.dart' as m;
import 'package:flutter/material.dart';
import '../gallery_scaffold.dart';
import 'custom_rounded_bars.dart';
import 'grouped.dart';
import 'grouped_fill_color.dart';
import 'grouped_single_target_line.dart';
import 'grouped_stacked.dart';
import 'grouped_stacked_weight_pattern.dart';
import 'grouped_target_line.dart';
import 'horizontal.dart';
import 'horizontal_bar_label.dart';
import 'horizontal_bar_label_custom.dart';
import 'horizontal_pattern_forward_hatch.dart';
import 'pattern_forward_hatch.dart';
import 'simple.dart';
import 'stacked.dart';
import 'stacked_fill_color.dart';
import 'stacked_horizontal.dart';
import 'stacked_target_line.dart';
import 'spark_bar.dart';
import 'vertical_bar_label.dart';

const simpleBarChartTileTitle = 'Simple Bar Chart';
const stackedBarChartTileTitle = 'Stacked Bar Chart';
const groupedBarChartTileTitle = 'Grouped Bar Chart';
const groupedStackedBarChartTileTitle = 'Grouped Stacked Bar Chart';
const groupedBarTargetLineChartTileTitle = 'Grouped Bar Target Line Chart';
const groupedBarSingleTargetLineChartTileTitle =
    'Grouped Bar Single Target Line Chart';
const stackedBarTargetLineChart = 'Stacked Bar Target Line Chart';
const horizontalBarChart = 'Horizontal Bar Chart';
const stackedHorizontalBarChart = 'Stacked Horizontal Bar Chart';
const horizontalBarLabelChart = 'Horizontal Bar Chart with Bar Labels';
const horizontalBarLabelCustomChart =
    'Horizontal Bar Chart with Custom Bar Labels';
const verticalBarLabelChart = 'Vertical Bar Chart with Bar Labels';
const sparkBarChart = 'Spark Bar Chart';
const groupedFillColorChart = 'Grouped Fill Color Bar Chart';
const stackedFillColorChart = 'Stacked Fill Color Bar Chart';
const patternForwardHatchChart = 'Pattern Forward Hatch Bar Chart';
const horizontalPatternForwardHatchChart =
    'Horizontal Pattern Forward Hatch Bar Chart';
const weightedPatternChart = 'Weighted Pattern Bar Chart';
const barChartWithCustomBarRadius = 'Bar Chart with custom bar radius';

List<GalleryScaffold> buildGallery() {
  return [
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: simpleBarChartTileTitle,
      subtitle: 'Simple bar chart with a single series',
      childBuilder: () => m.useRandomData
          ? SimpleBarChart.withRandomData()
          : SimpleBarChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: stackedBarChartTileTitle,
      subtitle: 'Stacked bar chart with multiple series',
      childBuilder: () => m.useRandomData
          ? StackedBarChart.withRandomData()
          : StackedBarChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: groupedBarChartTileTitle,
      subtitle: 'Grouped bar chart with multiple series',
      childBuilder: () => m.useRandomData
          ? GroupedBarChart.withRandomData()
          : GroupedBarChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: groupedStackedBarChartTileTitle,
      subtitle: 'Grouped and stacked bar chart with multiple series',
      childBuilder: () => m.useRandomData
          ? GroupedStackedBarChart.withRandomData()
          : GroupedStackedBarChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: groupedBarTargetLineChartTileTitle,
      subtitle: 'Grouped bar target line chart with multiple series',
      childBuilder: () => m.useRandomData
          ? GroupedBarTargetLineChart.withRandomData()
          : GroupedBarTargetLineChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: groupedBarSingleTargetLineChartTileTitle,
      subtitle:
          'Grouped bar target line chart with multiple series and a single target',
      childBuilder: () => m.useRandomData
          ? GroupedBarSingleTargetLineChart.withRandomData()
          : GroupedBarSingleTargetLineChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: stackedBarTargetLineChart,
      subtitle: 'Stacked bar target line chart with multiple series',
      childBuilder: () => m.useRandomData
          ? StackedBarTargetLineChart.withRandomData()
          : StackedBarTargetLineChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Transform.rotate(
          angle: 1.5708, child: new Icon(Icons.insert_chart)),
      title: horizontalBarChart,
      subtitle: 'Horizontal bar chart with a single series',
      childBuilder: () => m.useRandomData
          ? HorizontalBarChart.withRandomData()
          : HorizontalBarChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Transform.rotate(
          angle: 1.5708, child: new Icon(Icons.insert_chart)),
      title: stackedHorizontalBarChart,
      subtitle: 'Stacked horizontal bar chart with multiple series',
      childBuilder: () => m.useRandomData
          ? StackedHorizontalBarChart.withRandomData()
          : StackedHorizontalBarChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Transform.rotate(
          angle: 1.5708, child: new Icon(Icons.insert_chart)),
      title: horizontalBarLabelChart,
      subtitle: 'Horizontal bar chart with a single series and bar labels',
      childBuilder: () => m.useRandomData
          ? HorizontalBarLabelChart.withRandomData()
          : HorizontalBarLabelChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Transform.rotate(
          angle: 1.5708, child: new Icon(Icons.insert_chart)),
      title: horizontalBarLabelCustomChart,
      subtitle: 'Bar labels with customized styling',
      childBuilder: () => m.useRandomData
          ? HorizontalBarLabelCustomChart.withRandomData()
          : HorizontalBarLabelCustomChart.createWithSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Transform.rotate(
          angle: 1.5708, child: new Icon(Icons.insert_chart)),
      title: verticalBarLabelChart,
      subtitle: 'Vertical bar chart with a single series and bar labels',
      childBuilder: () => m.useRandomData
          ? VerticalBarLabelChart.withRandomData()
          : VerticalBarLabelChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: sparkBarChart,
      subtitle: 'Spark Bar Charts',
      childBuilder: () => m.useRandomData
          ? SparkBar.withRandomData()
          : SparkBar.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: groupedFillColorChart,
      subtitle: 'Grouped bar chart with fill colors',
      childBuilder: () => m.useRandomData
          ? GroupedFillColorBarChart.withRandomData()
          : GroupedFillColorBarChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: stackedFillColorChart,
      subtitle: 'Stacked bar chart with fill colors',
      childBuilder: () => m.useRandomData
          ? StackedFillColorBarChart.withRandomData()
          : StackedFillColorBarChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: patternForwardHatchChart,
      subtitle: 'Pattern Forward Hatch Bar Charts',
      childBuilder: () => m.useRandomData
          ? PatternForwardHatchBarChart.withRandomData()
          : PatternForwardHatchBarChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Transform.rotate(
          angle: 1.5708, child: new Icon(Icons.insert_chart)),
      title: horizontalPatternForwardHatchChart,
      subtitle: 'Horizontal Pattern Forward Hatch Bar Charts',
      childBuilder: () => m.useRandomData
          ? HorizontalPatternForwardHatchBarChart.withRandomData()
          : HorizontalPatternForwardHatchBarChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: weightedPatternChart,
      subtitle: 'Grouped and stacked bar chart with a weight pattern',
      childBuilder: () => m.useRandomData
          ? GroupedStackedWeightPatternBarChart.withRandomData()
          : GroupedStackedWeightPatternBarChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.insert_chart),
      title: barChartWithCustomBarRadius,
      subtitle: 'Custom rounded bar corners',
      childBuilder: () => m.useRandomData
          ? CustomRoundedBars.withRandomData()
          : CustomRoundedBars.withSampleData(),
    ),
  ];
}
