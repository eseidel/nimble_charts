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

/// Gauge chart example, where the data does not cover a full revolution in the
/// chart.
library;

// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';

import 'package:flutter/material.dart';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:nimble_charts/flutter.dart' as charts;

class GaugeChart extends StatelessWidget {
  const GaugeChart(this.seriesList, {super.key, this.animate = true});

  /// Creates a [charts.PieChart] with sample data and no transition.
  factory GaugeChart.withSampleData() => GaugeChart(
        _createSampleData(),
      );

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory GaugeChart.withRandomData() => GaugeChart(_createRandomData());
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  /// Create random data.
  static List<charts.Series<GaugeSegment, String>> _createRandomData() {
    final random = Random();

    final data = [
      GaugeSegment('Low', random.nextInt(100)),
      GaugeSegment('Acceptable', random.nextInt(100)),
      GaugeSegment('High', random.nextInt(100)),
      GaugeSegment('Highly Unusual', random.nextInt(100)),
    ];

    return [
      charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (segment, _) => segment.segment,
        measureFn: (segment, _) => segment.size,
        data: data,
      ),
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) => charts.PieChart(
        seriesList,
        animate: animate,
        // Configure the width of the pie slices to 30px. The remaining space in
        // the chart will be left as a hole in the center. Adjust the start
        // angle and the arc length of the pie so it resembles a gauge.
        defaultRenderer: charts.ArcRendererConfig<dynamic>(
          arcWidth: 30,
          startAngle: 4 / 5 * pi,
          arcLength: 7 / 5 * pi,
        ),
      );

  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      GaugeSegment('Low', 75),
      GaugeSegment('Acceptable', 100),
      GaugeSegment('High', 50),
      GaugeSegment('Highly Unusual', 5),
    ];

    return [
      charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (segment, _) => segment.segment,
        measureFn: (segment, _) => segment.size,
        data: data,
      ),
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  GaugeSegment(this.segment, this.size);
  final String segment;
  final int size;
}
