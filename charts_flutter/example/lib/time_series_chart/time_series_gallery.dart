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

import 'package:example/gallery_scaffold.dart';
import 'package:example/main.dart';
import 'package:example/time_series_chart/confidence_interval.dart';
import 'package:example/time_series_chart/end_points_axis.dart';
import 'package:example/time_series_chart/line_annotation.dart';
import 'package:example/time_series_chart/range_annotation.dart';
import 'package:example/time_series_chart/range_annotation_margin.dart';
import 'package:example/time_series_chart/simple.dart';
import 'package:example/time_series_chart/symbol_annotation.dart';
import 'package:example/time_series_chart/with_bar_renderer.dart';
import 'package:flutter/material.dart';

// Chart titles
const simpleTimeSeriesChartTitle = 'Simple Time Series Chart';
const endPointsAxisTimeSeriesChartTitle = 'End Points Axis Time Series Chart';
const lineAnnotationTimeSeriesChartTitle =
    'Line Annotation on Time Series Chart';
const rangeAnnotationTimeSeriesChartTitle =
    'Range Annotation on Time Series Chart';
const rangeAnnotationMarginLabelsTimeSeriesChartTitle =
    'Range Annotation Margin Labels on Time Series Chart';
const symbolAnnotationTimeSeriesChartTitle =
    'Symbol Annotation Time Series Chart';
const timeSeriesChartWithBarsTitle = 'Time Series Chart with Bars';
const confidenceIntervalTimeSeriesChartTitle =
    'Time Series Chart with Confidence Interval';

// Chart subtitles
const simpleTimeSeriesChartSubtitle =
    'Time series with a single series and default line point highlighter';
const endPointsAxisTimeSeriesChartSubtitle =
    'Time series with first and last points highlighted';
const lineAnnotationTimeSeriesChartSubtitle =
    'Time series chart with future line annotation';
const rangeAnnotationTimeSeriesChartSubtitle =
    'Time series chart with future range annotation';
const rangeAnnotationMarginLabelsTimeSeriesChartSubtitle =
    'Time series chart with range annotations with labels in margins';
const symbolAnnotationTimeSeriesChartSubtitle =
    'Time series with annotations and custom symbols';
const timeSeriesChartWithBarsSubtitle =
    'Time series chart using the bar renderer';
const confidenceIntervalTimeSeriesChartSubtitle =
    'Time series with confidence interval measures';

List<GalleryScaffold> buildGallery() => [
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: simpleTimeSeriesChartTitle,
        subtitle: simpleTimeSeriesChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? SimpleTimeSeriesChart.withRandomData()
            : SimpleTimeSeriesChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: endPointsAxisTimeSeriesChartTitle,
        subtitle: endPointsAxisTimeSeriesChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? EndPointsAxisTimeSeriesChart.withRandomData()
            : EndPointsAxisTimeSeriesChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: lineAnnotationTimeSeriesChartTitle,
        subtitle: lineAnnotationTimeSeriesChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? TimeSeriesLineAnnotationChart.withRandomData()
            : TimeSeriesLineAnnotationChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: rangeAnnotationTimeSeriesChartTitle,
        subtitle: rangeAnnotationTimeSeriesChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? TimeSeriesRangeAnnotationChart.withRandomData()
            : TimeSeriesRangeAnnotationChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: rangeAnnotationMarginLabelsTimeSeriesChartTitle,
        subtitle: rangeAnnotationMarginLabelsTimeSeriesChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? TimeSeriesRangeAnnotationMarginChart.withRandomData()
            : TimeSeriesRangeAnnotationMarginChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: symbolAnnotationTimeSeriesChartTitle,
        subtitle: symbolAnnotationTimeSeriesChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? TimeSeriesSymbolAnnotationChart.withRandomData()
            : TimeSeriesSymbolAnnotationChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: timeSeriesChartWithBarsTitle,
        subtitle: timeSeriesChartWithBarsSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? TimeSeriesBar.withRandomData()
            : TimeSeriesBar.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: confidenceIntervalTimeSeriesChartTitle,
        subtitle: confidenceIntervalTimeSeriesChartSubtitle,
        childBuilder: () => appState.value.useRandomData
            ? TimeSeriesConfidenceInterval.withRandomData()
            : TimeSeriesConfidenceInterval.withSampleData(),
      ),
    ];
