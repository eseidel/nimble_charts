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

const simpleLineChartTitle = 'Simple Line Chart';
const simpleLineChartSubtitle =
    'With a single series and default line point highlighter';

const stackedAreaLineChartTitle = 'Stacked Area Chart';
const stackedAreaLineChartSubtitle = 'Stacked area chart with three series';

const stackedAreaCustomColorLineChartTitle = 'Stacked Area Custom Color Chart';
const stackedAreaCustomColorLineChartSubtitle =
    'Stacked area chart with custom area skirt color';

const areaAndLineChartTitle = 'Area and Line Combo Chart';
const areaAndLineChartSubtitle =
    'Combo chart with one line series and one area series';

const pointsLineChartTitle = 'Points Line Chart';
const pointsLineChartSubtitle = 'Line chart with points on a single series';

const simpleNullsLineChartTitle = 'Null Data Line Chart';
const simpleNullsLineChartSubtitle =
    'With a single series and null measure values';

const stackedAreaNullsLineChartTitle = 'Stacked Area with Nulls Chart';
const stackedAreaNullsLineChartSubtitle =
    'Stacked area chart with three series and null measure values';

const dashPatternLineChartTitle = 'Dash Pattern Line Chart';
const dashPatternLineChartSubtitle = 'Line chart with dash patterns';

const segmentsLineChartTitle = 'Segments Line Chart';
const segmentsLineChartSubtitle =
    'Line chart with changes of style for each line';

const lineLineAnnotationChartTitle = 'Line Annotation Line Chart';
const lineLineAnnotationChartSubtitle = 'Line chart with line annotations';

const lineRangeAnnotationChartTitle = 'Range Annotation Line Chart';
const lineRangeAnnotationChartSubtitle = 'Line chart with range annotations';

const lineRangeAnnotationMarginChartTitle =
    'Range Annotation Margin Labels Line Chart';
const lineRangeAnnotationMarginChartSubtitle =
    'Line chart with range annotations with labels in margins';

const lineAnimationZoomChartTitle = 'Pan and Zoom Line Chart';
const lineAnimationZoomChartSubtitle =
    'Simple line chart pan and zoom behaviors enabled';

List<GalleryScaffold> buildGallery() => [
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: simpleLineChartTitle,
        subtitle: simpleLineChartSubtitle,
        childBuilder: () => useRandomData
            ? SimpleLineChart.withRandomData()
            : SimpleLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: stackedAreaLineChartTitle,
        subtitle: stackedAreaLineChartSubtitle,
        childBuilder: () => useRandomData
            ? StackedAreaLineChart.withRandomData()
            : StackedAreaLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: stackedAreaCustomColorLineChartTitle,
        subtitle: stackedAreaCustomColorLineChartSubtitle,
        childBuilder: () => useRandomData
            ? StackedAreaCustomColorLineChart.withRandomData()
            : StackedAreaCustomColorLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: areaAndLineChartTitle,
        subtitle: areaAndLineChartSubtitle,
        childBuilder: () => useRandomData
            ? AreaAndLineChart.withRandomData()
            : AreaAndLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: pointsLineChartTitle,
        subtitle: pointsLineChartSubtitle,
        childBuilder: () => useRandomData
            ? PointsLineChart.withRandomData()
            : PointsLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: simpleNullsLineChartTitle,
        subtitle: simpleNullsLineChartSubtitle,
        childBuilder: () => useRandomData
            ? SimpleNullsLineChart.withRandomData()
            : SimpleNullsLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: stackedAreaNullsLineChartTitle,
        subtitle: stackedAreaNullsLineChartSubtitle,
        childBuilder: () => useRandomData
            ? StackedAreaNullsLineChart.withRandomData()
            : StackedAreaNullsLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: dashPatternLineChartTitle,
        subtitle: dashPatternLineChartSubtitle,
        childBuilder: () => useRandomData
            ? DashPatternLineChart.withRandomData()
            : DashPatternLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: segmentsLineChartTitle,
        subtitle: segmentsLineChartSubtitle,
        childBuilder: () => useRandomData
            ? SegmentsLineChart.withRandomData()
            : SegmentsLineChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: lineLineAnnotationChartTitle,
        subtitle: lineLineAnnotationChartSubtitle,
        childBuilder: () => useRandomData
            ? LineLineAnnotationChart.withRandomData()
            : LineLineAnnotationChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: lineRangeAnnotationChartTitle,
        subtitle: lineRangeAnnotationChartSubtitle,
        childBuilder: () => useRandomData
            ? LineRangeAnnotationChart.withRandomData()
            : LineRangeAnnotationChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: lineRangeAnnotationMarginChartTitle,
        subtitle: lineRangeAnnotationMarginChartSubtitle,
        childBuilder: () => useRandomData
            ? LineRangeAnnotationMarginChart.withRandomData()
            : LineRangeAnnotationMarginChart.withSampleData(),
      ),
      GalleryScaffold(
        listTileIcon: const Icon(Icons.show_chart),
        title: lineAnimationZoomChartTitle,
        subtitle: lineAnimationZoomChartSubtitle,
        childBuilder: () => useRandomData
            ? LineAnimationZoomChart.withRandomData()
            : LineAnimationZoomChart.withSampleData(),
      ),
    ];
