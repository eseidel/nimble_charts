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
import 'package:example/gallery_scaffold.dart';

import 'package:example/main.dart';
import 'package:flutter/material.dart';

const simpleBarChartTileTitle = 'Simple Bar Chart';
const simpleBarChartTileSubtitle = 'Simple bar chart with a single series';

const stackedBarChartTileTitle = 'Stacked Bar Chart';
const stackedBarChartTileSubtitle = 'Stacked bar chart with multiple series';

const groupedBarChartTileTitle = 'Grouped Bar Chart';
const groupedBarChartTileSubtitle = 'Grouped bar chart with multiple series';

const groupedStackedBarChartTileTitle = 'Grouped Stacked Bar Chart';
const groupedStackedBarChartTileSubtitle =
    'Grouped and stacked bar chart with multiple series';

const groupedBarTargetLineChartTileTitle = 'Grouped Bar Target Line Chart';
const groupedBarTargetLineChartTileSubtitle =
    'Grouped bar target line chart with multiple series';

const groupedBarSingleTargetLineChartTileTitle =
    'Grouped Bar Single Target Line Chart';
const groupedBarSingleTargetLineChartTileSubtitle =
    'Grouped bar target line chart with multiple series and a single target';

const stackedBarTargetLineChartTitle = 'Stacked Bar Target Line Chart';
const stackedBarTargetLineChartSubtitle =
    'Stacked bar target line chart with multiple series';

const horizontalBarChartTitle = 'Horizontal Bar Chart';
const horizontalBarChartSubtitle = 'Horizontal bar chart with a single series';

const stackedHorizontalBarChartTitle = 'Stacked Horizontal Bar Chart';
const stackedHorizontalBarChartSubtitle =
    'Stacked horizontal bar chart with multiple series';

const horizontalBarLabelChartTitle = 'Horizontal Bar Chart with Bar Labels';
const horizontalBarLabelChartSubtitle =
    'Horizontal bar chart with a single series and bar labels';

const horizontalBarLabelCustomChartTitle =
    'Horizontal Bar Chart with Custom Bar Labels';
const horizontalBarLabelCustomChartSubtitle =
    'Bar labels with customized styling';

const verticalBarLabelChartTitle = 'Vertical Bar Chart with Bar Labels';
const verticalBarLabelChartSubtitle =
    'Vertical bar chart with a single series and bar labels';

const sparkBarChartTitle = 'Spark Bar Chart';
const sparkBarChartSubtitle = 'Spark Bar Chart';

const groupedFillColorChartTitle = 'Grouped Fill Color Bar Chart';
const groupedFillColorChartSubtitle = 'Grouped bar chart with fill colors';

const stackedFillColorChartTitle = 'Stacked Fill Color Bar Chart';
const stackedFillColorChartSubtitle = 'Stacked bar chart with fill colors';

const patternForwardHatchChartTitle = 'Pattern Forward Hatch Bar Chart';
const patternForwardHatchChartSubtitle = 'Pattern Forward Hatch Bar Chart';

const horizontalPatternForwardHatchChartTitle =
    'Horizontal Pattern Forward Hatch Bar Chart';
const horizontalPatternForwardHatchChartSubtitle =
    'Horizontal Pattern Forward Hatch Bar Chart';

const weightedPatternChartTitle = 'Weight Pattern Bar Chart';
const weightedPatternChartSubtitle =
    'Grouped and stacked bar chart with a weight pattern';

const barChartWithCustomBarRadiusTitle = 'Bar Chart with custom bar radius';
const barChartWithCustomBarRadiusSubtitle = 'Custom rounded bar corners';

List<GalleryScaffold> buildGallery() => [
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: simpleBarChartTileTitle,
        subtitle: simpleBarChartTileSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? SimpleBarChart.withRandomData()
            : SimpleBarChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: stackedBarChartTileTitle,
        subtitle: stackedBarChartTileSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? StackedBarChart.withRandomData()
            : StackedBarChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: groupedBarChartTileTitle,
        subtitle: groupedBarChartTileSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? GroupedBarChart.withRandomData()
            : GroupedBarChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: groupedStackedBarChartTileTitle,
        subtitle: groupedStackedBarChartTileSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? GroupedStackedBarChart.withRandomData()
            : GroupedStackedBarChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: groupedBarTargetLineChartTileTitle,
        subtitle: groupedBarTargetLineChartTileSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? GroupedBarTargetLineChart.withRandomData()
            : GroupedBarTargetLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: groupedBarSingleTargetLineChartTileTitle,
        subtitle: groupedBarSingleTargetLineChartTileSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? GroupedBarSingleTargetLineChart.withRandomData()
            : GroupedBarSingleTargetLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: stackedBarTargetLineChartTitle,
        subtitle: stackedBarTargetLineChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? StackedBarTargetLineChart.withRandomData()
            : StackedBarTargetLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: Transform.rotate(
          angle: 1.5708,
          child: const Icon(Icons.insert_chart),
        ),
        title: horizontalBarChartTitle,
        subtitle: horizontalBarChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? HorizontalBarChart.withRandomData()
            : HorizontalBarChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: Transform.rotate(
          angle: 1.5708,
          child: const Icon(Icons.insert_chart),
        ),
        title: stackedHorizontalBarChartTitle,
        subtitle: stackedHorizontalBarChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? StackedHorizontalBarChart.withRandomData()
            : StackedHorizontalBarChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: Transform.rotate(
          angle: 1.5708,
          child: const Icon(Icons.insert_chart),
        ),
        title: horizontalBarLabelChartTitle,
        subtitle: horizontalBarLabelChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? HorizontalBarLabelChart.withRandomData()
            : HorizontalBarLabelChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: Transform.rotate(
          angle: 1.5708,
          child: const Icon(Icons.insert_chart),
        ),
        title: horizontalBarLabelCustomChartTitle,
        subtitle: horizontalBarLabelCustomChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? HorizontalBarLabelCustomChart.withRandomData()
            : HorizontalBarLabelCustomChart.createWithSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: Transform.rotate(
          angle: 1.5708,
          child: const Icon(Icons.insert_chart),
        ),
        title: verticalBarLabelChartTitle,
        subtitle: verticalBarLabelChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? VerticalBarLabelChart.withRandomData()
            : VerticalBarLabelChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: sparkBarChartTitle,
        subtitle: sparkBarChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? SparkBar.withRandomData()
            : SparkBar.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: groupedFillColorChartTitle,
        subtitle: groupedFillColorChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? GroupedFillColorBarChart.withRandomData()
            : GroupedFillColorBarChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: stackedFillColorChartTitle,
        subtitle: stackedFillColorChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? StackedFillColorBarChart.withRandomData()
            : StackedFillColorBarChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: patternForwardHatchChartTitle,
        subtitle: patternForwardHatchChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? PatternForwardHatchBarChart.withRandomData()
            : PatternForwardHatchBarChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: Transform.rotate(
          angle: 1.5708,
          child: const Icon(Icons.insert_chart),
        ),
        title: horizontalPatternForwardHatchChartTitle,
        subtitle: horizontalPatternForwardHatchChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? HorizontalPatternForwardHatchBarChart.withRandomData()
            : HorizontalPatternForwardHatchBarChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: weightedPatternChartTitle,
        subtitle: weightedPatternChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? GroupedStackedWeightPatternBarChart.withRandomData()
            : GroupedStackedWeightPatternBarChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.insert_chart),
        title: barChartWithCustomBarRadiusTitle,
        subtitle: barChartWithCustomBarRadiusSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? CustomRoundedBars.withRandomData()
            : CustomRoundedBars.withSampleData(),
      ),
    ];
