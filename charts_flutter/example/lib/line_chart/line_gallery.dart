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
import 'animation_zoom.dart';
import 'area_and_line.dart';
import 'dash_pattern.dart';
import 'line_annotation.dart';
import 'points.dart';
import 'range_annotation.dart';
import 'range_annotation_margin.dart';
import 'segments.dart';
import 'simple.dart';
import 'simple_nulls.dart';
import 'stacked_area.dart';
import 'stacked_area_custom_color.dart';
import 'stacked_area_nulls.dart';

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

List<GalleryScaffold> buildGallery() {
  return [
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: simpleLineChart,
      subtitle: 'With a single series and default line point highlighter',
      childBuilder: () => m.useRandomData
          ? SimpleLineChart.withRandomData()
          : SimpleLineChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: stackedAreaLineChart,
      subtitle: 'Stacked area chart with three series',
      childBuilder: () => m.useRandomData
          ? StackedAreaLineChart.withRandomData()
          : StackedAreaLineChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: stackedAreaCustomColorLineChart,
      subtitle: 'Stacked area chart with custom area skirt color',
      childBuilder: () => m.useRandomData
          ? StackedAreaCustomColorLineChart.withRandomData()
          : StackedAreaCustomColorLineChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: areaAndLineChart,
      subtitle: 'Combo chart with one line series and one area series',
      childBuilder: () => m.useRandomData
          ? AreaAndLineChart.withRandomData()
          : AreaAndLineChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: pointsLineChart,
      subtitle: 'Line chart with points on a single series',
      childBuilder: () => m.useRandomData
          ? PointsLineChart.withRandomData()
          : PointsLineChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: simpleNullsLineChart,
      subtitle: 'With a single series and null measure values',
      childBuilder: () => m.useRandomData
          ? SimpleNullsLineChart.withRandomData()
          : SimpleNullsLineChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: stackedAreaNullsLineChart,
      subtitle: 'Stacked area chart with three series and null measure values',
      childBuilder: () => m.useRandomData
          ? StackedAreaNullsLineChart.withRandomData()
          : StackedAreaNullsLineChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: dashPatternLineChart,
      subtitle: 'Line chart with dash patterns',
      childBuilder: () => m.useRandomData
          ? DashPatternLineChart.withRandomData()
          : DashPatternLineChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: segmentsLineChart,
      subtitle: 'Line chart with changes of style for each line',
      childBuilder: () => m.useRandomData
          ? SegmentsLineChart.withRandomData()
          : SegmentsLineChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: lineLineAnnotationChart,
      subtitle: 'Line chart with line annotations',
      childBuilder: () => m.useRandomData
          ? LineLineAnnotationChart.withRandomData()
          : LineLineAnnotationChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: lineRangeAnnotationChart,
      subtitle: 'Line chart with range annotations',
      childBuilder: () => m.useRandomData
          ? LineRangeAnnotationChart.withRandomData()
          : LineRangeAnnotationChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: lineRangeAnnotationMarginChart,
      subtitle: 'Line chart with range annotations with labels in margins',
      childBuilder: () => m.useRandomData
          ? LineRangeAnnotationMarginChart.withRandomData()
          : LineRangeAnnotationMarginChart.withSampleData(),
    ),
    new GalleryScaffold(
      listTileIcon: new Icon(Icons.show_chart),
      title: lineAnimationZoomChart,
      subtitle: 'Simple line chart pan and zoom behaviors enabled',
      childBuilder: () => m.useRandomData
          ? LineAnimationZoomChart.withRandomData()
          : LineAnimationZoomChart.withSampleData(),
    ),
  ];
}
