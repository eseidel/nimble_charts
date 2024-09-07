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

/// Partial pie chart example, where the data does not cover a full revolution
/// in the chart.
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:nimble_charts/flutter.dart' as charts;
import 'package:flutter/material.dart';

/// Creates a partial pie chart where the data does not cover a full revolution.
class PartialPieChart extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  const PartialPieChart(this.seriesList, {this.animate = false});

  /// Creates a [PartialPieChart] with sample data and no transition.
  factory PartialPieChart.withSampleData() =>
      PartialPieChart(_createSampleData(), animate: false);

  /// Creates a [PartialPieChart] with random data.
  factory PartialPieChart.withRandomData() =>
      PartialPieChart(_createRandomData());

  @override
  Widget build(BuildContext context) =>
      charts.PieChart<num>(
        seriesList,
        animate: animate,
        defaultRenderer: charts.ArcRendererConfig(arcLength: 3 / 2 * pi),
      );

  /// Creates one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() =>
      [
        charts.Series<LinearSales, int>(
          id: 'Sales',
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: [
            LinearSales(0, 100),
            LinearSales(1, 75),
            LinearSales(2, 25),
            LinearSales(3, 5),
          ],
        )
      ];

  /// Creates random data.
  static List<charts.Series<LinearSales, int>> _createRandomData() {
    final random = Random();
    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: List.generate(4, (index) => LinearSales(index, random.nextInt(100))),
      )
    ];
  }
}

/// Represents linear sales data.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
