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
import 'package:example/line_chart/animation_zoom.dart';
import 'package:example/line_chart/area_and_line.dart';
import 'package:example/line_chart/dash_pattern.dart';
import 'package:example/line_chart/line_annotation.dart';
import 'package:example/line_chart/points.dart';
import 'package:example/line_chart/range_annotation.dart';
import 'package:example/line_chart/range_annotation_margin.dart';
import 'package:example/line_chart/segments.dart';
import 'package:example/line_chart/simple.dart';
import 'package:example/line_chart/simple_nulls.dart';
import 'package:example/line_chart/stacked_area.dart';
import 'package:example/line_chart/stacked_area_custom_color.dart';
import 'package:example/line_chart/stacked_area_nulls.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';

const simpleLineChart = 'Simple Line Chart';
const stackedAreaLineChart = 'Stacked Area Chart';
const stackedAreaCustomColorLineChart = 'Stacked Area Custom Color Chart';
const areaAndLineChart = 'Area and Line Combo Chart';
const pointsLineChart = 'Points Line Chart';
const simpleNullsLineChart = 'Null Data Line Chart';
const stackedAreaNullsLineChart = 'Stacked Area with Nulls Chart';
const dashPatternLineChart = 'Dash Pattern Line Chart';
const segmentsLineChart = 'Segments Line Chart';
const lineLineAnnotationChart = 'Line Annotation Line Chart';
const lineRangeAnnotationChart = 'Range Annotation Line Chart';
const lineRangeAnnotationMarginChart =
    'Range Annotation Margin Labels Line Chart';
const lineAnimationZoomChart = 'Pan and Zoom Line Chart';

List<GalleryScaffold> buildGallery() => [
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: simpleLineChart,
        subtitle: 'With a single series and default line point highlighter',
        childBuilder: () => useRandomData
            ? SimpleLineChart.withRandomData()
            : SimpleLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: stackedAreaLineChart,
        subtitle: 'Stacked area chart with three series',
        childBuilder: () => useRandomData
            ? StackedAreaLineChart.withRandomData()
            : StackedAreaLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: stackedAreaCustomColorLineChart,
        subtitle: 'Stacked area chart with custom area skirt color',
        childBuilder: () => useRandomData
            ? StackedAreaCustomColorLineChart.withRandomData()
            : StackedAreaCustomColorLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: areaAndLineChart,
        subtitle: 'Combo chart with one line series and one area series',
        childBuilder: () => useRandomData
            ? AreaAndLineChart.withRandomData()
            : AreaAndLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: pointsLineChart,
        subtitle: 'Line chart with points on a single series',
        childBuilder: () => useRandomData
            ? PointsLineChart.withRandomData()
            : PointsLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: simpleNullsLineChart,
        subtitle: 'With a single series and null measure values',
        childBuilder: () => useRandomData
            ? SimpleNullsLineChart.withRandomData()
            : SimpleNullsLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: stackedAreaNullsLineChart,
        subtitle:
            'Stacked area chart with three series and null measure values',
        childBuilder: () => useRandomData
            ? StackedAreaNullsLineChart.withRandomData()
            : StackedAreaNullsLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: dashPatternLineChart,
        subtitle: 'Line chart with dash patterns',
        childBuilder: () => useRandomData
            ? DashPatternLineChart.withRandomData()
            : DashPatternLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: segmentsLineChart,
        subtitle: 'Line chart with changes of style for each line',
        childBuilder: () => useRandomData
            ? SegmentsLineChart.withRandomData()
            : SegmentsLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: lineLineAnnotationChart,
        subtitle: 'Line chart with line annotations',
        childBuilder: () => useRandomData
            ? LineLineAnnotationChart.withRandomData()
            : LineLineAnnotationChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: lineRangeAnnotationChart,
        subtitle: 'Line chart with range annotations',
        childBuilder: () => useRandomData
            ? LineRangeAnnotationChart.withRandomData()
            : LineRangeAnnotationChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: lineRangeAnnotationMarginChart,
        subtitle: 'Line chart with range annotations with labels in margins',
        childBuilder: () => useRandomData
            ? LineRangeAnnotationMarginChart.withRandomData()
            : LineRangeAnnotationMarginChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: lineAnimationZoomChart,
        subtitle: 'Simple line chart pan and zoom behaviors enabled',
        childBuilder: () => useRandomData
            ? LineAnimationZoomChart.withRandomData()
            : LineAnimationZoomChart.withSampleData(),
      ),
    ];
