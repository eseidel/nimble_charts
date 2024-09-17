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
import 'package:flutter/material.dart';

List<GalleryScaffold> buildGallery() => [
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Simple Line Chart',
      subtitle: 'With a single series and default line point highlighter',
      childBuilder: SimpleLineChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Stacked Area Chart',
      subtitle: 'Stacked area chart with three series',
      childBuilder: StackedAreaLineChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Stacked Area Custom Color Chart',
      subtitle: 'Stacked area chart with custom area skirt color',
      childBuilder: StackedAreaCustomColorLineChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Area and Line Combo Chart',
      subtitle: 'Combo chart with one line series and one area series',
      childBuilder: AreaAndLineChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Points Line Chart',
      subtitle: 'Line chart with points on a single series',
      childBuilder: PointsLineChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Null Data Line Chart',
      subtitle: 'With a single series and null measure values',
      childBuilder: SimpleNullsLineChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Stacked Area with Nulls Chart',
      subtitle: 'Stacked area chart with three series and null measure values',
      childBuilder: StackedAreaNullsLineChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Dash Pattern Line Chart',
      subtitle: 'Line chart with dash patterns',
      childBuilder: DashPatternLineChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Segments Line Chart',
      subtitle: 'Line chart with changes of style for each line',
      childBuilder: SegmentsLineChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Line Annotation Line Chart',
      subtitle: 'Line chart with line annotations',
      childBuilder: LineLineAnnotationChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Range Annotation Line Chart',
      subtitle: 'Line chart with range annotations',
      childBuilder: LineRangeAnnotationChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Range Annotation Margin Labels Line Chart',
      subtitle: 'Line chart with range annotations with labels in margins',
      childBuilder: LineRangeAnnotationMarginChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Pan and Zoom Line Chart',
      subtitle: 'Simple line chart pan and zoom behaviors enabled',
      childBuilder: LineAnimationZoomChart.withRandomData,
    ),
  ];
