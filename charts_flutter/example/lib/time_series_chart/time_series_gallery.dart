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

const timeSeriesChart = 'Time Series Chart';
const endPointsAxisTimeSeriesChart = 'End Points Axis Time Series Chart';
const lineAnnotationOnTimeSeriesChart = 'Line Annotation on Time Series Chart';
const rangeAnnotationOnTimeSeriesChart =
    'Range Annotation on Time Series Chart';
const rangeAnnotationMarginLabelsOnTimeSeriesChart =
    'Range Annotation Margin Labels on Time Series Chart';
const symbolAnnotationOnTimeSeriesChart = 'Symbol Annotation Time Series Chart';
const timeSeriesChartWithBars = 'Time Series Chart with Bars';
const timeSeriesChartWithConfidenceInterval =
    'Time Series Chart with Confidence Interval';

List<GalleryScaffold> buildGallery() => [
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: timeSeriesChart,
        subtitle: 'Simple single time series chart',
        childBuilder: () => useRandomData
            ? SimpleTimeSeriesChart.withRandomData()
            : SimpleTimeSeriesChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: endPointsAxisTimeSeriesChart,
        subtitle: 'Time series chart with an end points axis',
        childBuilder: () => useRandomData
            ? EndPointsAxisTimeSeriesChart.withRandomData()
            : EndPointsAxisTimeSeriesChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: lineAnnotationOnTimeSeriesChart,
        subtitle: 'Time series chart with future line annotation',
        childBuilder: () => useRandomData
            ? TimeSeriesLineAnnotationChart.withRandomData()
            : TimeSeriesLineAnnotationChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: rangeAnnotationOnTimeSeriesChart,
        subtitle: 'Time series chart with future range annotation',
        childBuilder: () => useRandomData
            ? TimeSeriesRangeAnnotationChart.withRandomData()
            : TimeSeriesRangeAnnotationChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: rangeAnnotationMarginLabelsOnTimeSeriesChart,
        subtitle:
            'Time series chart with range annotations with labels in margins',
        childBuilder: () => useRandomData
            ? TimeSeriesRangeAnnotationMarginChart.withRandomData()
            : TimeSeriesRangeAnnotationMarginChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: symbolAnnotationOnTimeSeriesChart,
        subtitle: 'Time series chart with annotation data below the draw area',
        childBuilder: () => useRandomData
            ? TimeSeriesSymbolAnnotationChart.withRandomData()
            : TimeSeriesSymbolAnnotationChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: timeSeriesChartWithBars,
        subtitle: 'Time series chart using the bar renderer',
        childBuilder: () => useRandomData
            ? TimeSeriesBar.withRandomData()
            : TimeSeriesBar.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: timeSeriesChartWithConfidenceInterval,
        subtitle: 'Draws area around the confidence interval',
        childBuilder: () => useRandomData
            ? TimeSeriesConfidenceInterval.withRandomData()
            : TimeSeriesConfidenceInterval.withSampleData(),
      ),
    ];
