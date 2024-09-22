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

// ignore_for_file: lines_longer_than_80_chars

/// RTL Line chart example
library;

// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:nimble_charts/flutter.dart' as charts;

class RTLLineChart extends StatelessWidget {
  const RTLLineChart(this.seriesList, {super.key, this.animate = true});

  /// Creates a [charts.LineChart] with sample data and no transition.
  factory RTLLineChart.withSampleData() => RTLLineChart(
        _createSampleData(),
      );

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory RTLLineChart.withRandomData() => RTLLineChart(_createRandomData());
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  /// Create random data.
  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = Random();

    final data = [
      LinearSales(0, random.nextInt(100)),
      LinearSales(1, random.nextInt(100)),
      LinearSales(2, random.nextInt(100)),
      LinearSales(3, random.nextInt(100)),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: data,
      ),
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) =>
      // Charts will determine if RTL is enabled by checking the directionality by
      // requesting Directionality.of(context). This returns the text direction
      // from the closest instance of that encloses the context passed to build
      // the chart. A [TextDirection.rtl] will be treated as a RTL chart. This
      // means that the directionality widget does not have to directly wrap each
      // chart. It is show here as an example only.
      //
      // By default, when a chart detects RTL:
      // Measure axis positions are flipped. Primary measure axis is on the right
      // and the secondary measure axis is on the left (when used).
      // Domain axis' first domain starts on the right and grows left.
      Directionality(
        textDirection: ui.TextDirection.rtl,
        child: charts.LineChart(
          seriesList,
          animate: animate,
        ),
      );

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(0, 5),
      LinearSales(1, 25),
      LinearSales(2, 100),
      LinearSales(3, 75),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: data,
      ),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  LinearSales(this.year, this.sales);
  final int year;
  final int sales;
}
