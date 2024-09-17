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

/// Line chart example
library;

// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';

import 'package:flutter/material.dart';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:nimble_charts/flutter.dart' as charts;

class ComparisonPointsScatterPlotChart extends StatelessWidget {
  const ComparisonPointsScatterPlotChart(
    this.seriesList, {
    super.key,
    this.animate = false,
  });

  /// Creates a [charts.ScatterPlotChart] with sample data and no transition.
  factory ComparisonPointsScatterPlotChart.withSampleData() =>
      ComparisonPointsScatterPlotChart(
        _createSampleData(),
      );

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory ComparisonPointsScatterPlotChart.withRandomData() =>
      ComparisonPointsScatterPlotChart(_createRandomData());
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  /// Create random data.
  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = Random();

    const maxMeasure = 100;

    final data = [
      _makeRandomDatum(maxMeasure, random),
      _makeRandomDatum(maxMeasure, random),
      _makeRandomDatum(maxMeasure, random),
      _makeRandomDatum(maxMeasure, random),
      _makeRandomDatum(maxMeasure, random),
      _makeRandomDatum(maxMeasure, random),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (sales, _) {
          // Color bucket the measure column value into 3 distinct colors.
          final bucket = sales.sales / maxMeasure;

          if (bucket < 1 / 3) {
            return charts.MaterialPalette.blue.shadeDefault;
          } else if (bucket < 2 / 3) {
            return charts.MaterialPalette.red.shadeDefault;
          } else {
            return charts.MaterialPalette.green.shadeDefault;
          }
        },
        domainFn: (sales, _) => sales.year,
        domainLowerBoundFn: (sales, _) => sales.yearLower,
        domainUpperBoundFn: (sales, _) => sales.yearUpper,
        measureFn: (sales, _) => sales.sales,
        measureLowerBoundFn: (sales, _) => sales.salesLower,
        measureUpperBoundFn: (sales, _) => sales.salesUpper,
        radiusPxFn: (sales, _) => sales.radius,
        data: data,
      ),
    ];
  }

  static LinearSales _makeRandomDatum(int max, Random random) {
    double makeRadius(int value) => (random.nextInt(value) + 6).toDouble();

    final year = random.nextInt(max);
    final yearLower = (year * 0.8).round();
    final yearUpper = year;
    final sales = random.nextInt(max);
    final salesLower = (sales * 0.8).round();
    final salesUpper = sales;

    return LinearSales(
      year,
      yearLower,
      yearUpper,
      sales,
      salesLower,
      salesUpper,
      makeRadius(4),
    );
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) => charts.ScatterPlotChart(
        seriesList,
        animate: animate,
        defaultRenderer: charts.PointRendererConfig(
          pointRendererDecorators: [
            charts.ComparisonPointsDecorator(
              symbolRenderer: charts.CylinderSymbolRenderer(),
            ),
          ],
        ),
      );

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(10, 7, 10, 25, 20, 25, 5),
      LinearSales(13, 11, 13, 225, 205, 225, 5),
      LinearSales(34, 34, 24, 150, 150, 130, 5),
      LinearSales(37, 37, 57, 10, 10, 12, 6.5),
      LinearSales(45, 35, 45, 260, 300, 260, 8),
      LinearSales(56, 46, 56, 200, 170, 200, 7),
    ];

    const maxMeasure = 300;

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        // Providing a color function is optional.
        colorFn: (sales, _) {
          // Bucket the measure column value into 3 distinct colors.
          final bucket = sales.sales / maxMeasure;

          if (bucket < 1 / 3) {
            return charts.MaterialPalette.blue.shadeDefault;
          } else if (bucket < 2 / 3) {
            return charts.MaterialPalette.red.shadeDefault;
          } else {
            return charts.MaterialPalette.green.shadeDefault;
          }
        },
        domainFn: (sales, _) => sales.year,
        domainLowerBoundFn: (sales, _) => sales.yearLower,
        domainUpperBoundFn: (sales, _) => sales.yearUpper,
        measureFn: (sales, _) => sales.sales,
        measureLowerBoundFn: (sales, _) => sales.salesLower,
        measureUpperBoundFn: (sales, _) => sales.salesUpper,
        // Providing a radius function is optional.
        radiusPxFn: (sales, _) => sales.radius,
        data: data,
      ),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  LinearSales(
    this.year,
    this.yearLower,
    this.yearUpper,
    this.sales,
    this.salesLower,
    this.salesUpper,
    this.radius,
  );
  final int year;
  final int yearLower;
  final int yearUpper;
  final int sales;
  final int salesLower;
  final int salesUpper;
  final double radius;
}
