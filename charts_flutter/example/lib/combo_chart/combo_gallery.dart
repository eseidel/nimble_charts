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

import 'package:example/combo_chart/date_time_line_point.dart';
import 'package:example/combo_chart/numeric_line_bar.dart';
import 'package:example/combo_chart/numeric_line_point.dart';
import 'package:example/combo_chart/ordinal_bar_line.dart';
import 'package:example/combo_chart/scatter_plot_line.dart';
import 'package:example/gallery_scaffold.dart';
import 'package:flutter/material.dart';

List<GalleryScaffold> buildGallery() => [
    const GalleryScaffold(
      listTileIcon: Icon(Icons.insert_chart),
      title: 'Ordinal Combo Chart',
      subtitle: 'Ordinal combo chart with bars and lines',
      childBuilder: OrdinalComboBarLineChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Numeric Line Bar Combo Chart',
      subtitle: 'Numeric combo chart with lines and bars',
      childBuilder: NumericComboLineBarChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Numeric Line Points Combo Chart',
      subtitle: 'Numeric combo chart with lines and points',
      childBuilder: NumericComboLinePointChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.show_chart),
      title: 'Time Series Combo Chart',
      subtitle: 'Time series combo chart with lines and points',
      childBuilder: DateTimeComboLinePointChart.withRandomData,
    ),
    const GalleryScaffold(
      listTileIcon: Icon(Icons.scatter_plot),
      title: 'Scatter Plot Combo Chart',
      subtitle: 'Scatter plot combo chart with a line',
      childBuilder: ScatterPlotComboLineChart.withRandomData,
    ),
  ];
