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

/// Example of a time series chart with an end points domain axis.
///
/// An end points axis generates two ticks, one at each end of the axis range.
library;

// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';

import 'package:flutter/material.dart';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:nimble_charts/flutter.dart' as charts;

class EndPointsAxisTimeSeriesChart extends StatelessWidget {
  const EndPointsAxisTimeSeriesChart(
    this.seriesList, {
    super.key,
    this.animate = false,
  });

  /// Creates a [charts.TimeSeriesChart] with sample data and no transition.
  factory EndPointsAxisTimeSeriesChart.withSampleData() =>
      EndPointsAxisTimeSeriesChart(
        _createSampleData(),
      );

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory EndPointsAxisTimeSeriesChart.withRandomData() =>
      EndPointsAxisTimeSeriesChart(_createRandomData());
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool animate;

  /// Create random data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createRandomData() {
    final random = Random();

    final data = [
      TimeSeriesSales(DateTime(2017, 9, 19), random.nextInt(100)),
      TimeSeriesSales(DateTime(2017, 9, 26), random.nextInt(100)),
      TimeSeriesSales(DateTime(2017, 10, 3), random.nextInt(100)),
      TimeSeriesSales(DateTime(2017, 10, 10), random.nextInt(100)),
    ];

    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (sales, _) => sales.time,
        measureFn: (sales, _) => sales.sales,
        data: data,
      ),
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) => charts.TimeSeriesChart(
        seriesList,
        animate: animate,
        // Configures an axis spec that is configured to render one tick at each
        // end of the axis range, anchored "inside" the axis. The start tick label
        // will be left-aligned with its tick mark, and the end tick label will be
        // right-aligned with its tick mark.
        domainAxis: const charts.EndPointsTimeAxisSpec(),
      );

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      TimeSeriesSales(DateTime(2017, 9, 19), 5),
      TimeSeriesSales(DateTime(2017, 9, 26), 25),
      TimeSeriesSales(DateTime(2017, 10, 3), 100),
      TimeSeriesSales(DateTime(2017, 10, 10), 75),
    ];

    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (sales, _) => sales.time,
        measureFn: (sales, _) => sales.sales,
        data: data,
      ),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  TimeSeriesSales(this.time, this.sales);
  final DateTime time;
  final int sales;
}
