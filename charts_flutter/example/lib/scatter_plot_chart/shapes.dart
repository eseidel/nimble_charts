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

/// Example of a scatter plot chart using custom symbols for the points.
///
/// The series has been configured to draw each point as a square by default.
///
/// Some data will be drawn as a circle, indicated by defining a custom "circle"
/// value referenced by [pointSymbolRendererFnKey].
///
/// Some other data have will be drawn as a hollow circle. In addition to the
/// custom renderer key, these data also have stroke and fillColor values
/// defined. Configuring a separate fillColor will cause the center of the shape
/// to be filled in, with white in these examples. The border of the shape will
/// be color with the color of the data.
library;

// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';

import 'package:flutter/material.dart';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:nimble_charts/flutter.dart' as charts;
import 'package:nimble_charts/flutter.dart';

class ShapesScatterPlotChart extends StatelessWidget {

  const ShapesScatterPlotChart(this.seriesList, {super.key, this.animate = false});

  /// Creates a [charts.ScatterPlotChart] with sample data and no transition.
  factory ShapesScatterPlotChart.withSampleData() => ShapesScatterPlotChart(
      _createSampleData(),
    );

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory ShapesScatterPlotChart.withRandomData() => ShapesScatterPlotChart(_createRandomData());
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  /// Create random data.
  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = Random();

    double makeRadius(int value) => (random.nextInt(value) + 2).toDouble();

    final data = [
      LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          'circle', null, null,),
      LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null,),
      LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null,),
      // Render a hollow circle, filled in with white.
      LinearSales(random.nextInt(100), random.nextInt(100),
          makeRadius(4) + 4, 'circle', charts.MaterialPalette.white, 2,),
      LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null,),
      LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null,),
      LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          'circle', null, null,),
      LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null,),
      LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null,),
      // Render a hollow circle, filled in with white.
      LinearSales(random.nextInt(100), random.nextInt(100),
          makeRadius(4) + 4, 'circle', charts.MaterialPalette.white, 2,),
      LinearSales(random.nextInt(100), random.nextInt(100), makeRadius(6),
          null, null, null,),
      // Render a hollow square, filled in with white.
      LinearSales(random.nextInt(100), random.nextInt(100),
          makeRadius(4) + 4, null, charts.MaterialPalette.white, 2,),
    ];

    const maxMeasure = 100;

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
        measureFn: (sales, _) => sales.sales,
        radiusPxFn: (sales, _) => sales.radius,
        fillColorFn: (row, _) => row.fillColor,
        strokeWidthPxFn: (row, _) => row.strokeWidth,
        data: data,
      )
        // Accessor function that associates each datum with a symbol renderer.
        ..setAttribute(
            charts.pointSymbolRendererFnKey, (index) => data[index].shape,)
        // Default symbol renderer ID for data that have no defined shape.
        ..setAttribute(charts.pointSymbolRendererIdKey, 'rect'),
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) => charts.ScatterPlotChart(seriesList,
        animate: animate,
        // Configure the point renderer to have a map of custom symbol
        // renderers.
        defaultRenderer:
            charts.PointRendererConfig<num>(customSymbolRenderers: {
          'circle': charts.CircleSymbolRenderer(),
          'rect': charts.RectSymbolRenderer(),
        },),);

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(0, 5, 3, 'circle', null, null),
      LinearSales(10, 25, 5, null, null, null),
      LinearSales(12, 75, 4, null, null, null),
      // Render a hollow circle, filled in with white.
      LinearSales(
          13, 225, 5, 'circle', charts.MaterialPalette.white, 2,),
      LinearSales(16, 50, 4, null, null, null),
      LinearSales(24, 75, 3, null, null, null),
      LinearSales(25, 100, 3, 'circle', null, null),
      LinearSales(34, 150, 5, null, null, null),
      LinearSales(37, 10, 4.5, null, null, null),
      // Render a hollow circle, filled in with white.
      LinearSales(
          45, 300, 8, 'circle', charts.MaterialPalette.white, 2,),
      LinearSales(52, 15, 4, null, null, null),
      // Render a hollow square, filled in with white.
      LinearSales(56, 200, 7, null, charts.MaterialPalette.white, 2),
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
        measureFn: (sales, _) => sales.sales,
        radiusPxFn: (sales, _) => sales.radius,
        fillColorFn: (row, _) => row.fillColor,
        strokeWidthPxFn: (row, _) => row.strokeWidth,
        data: data,
      )
        // Accessor function that associates each datum with a symbol renderer.
        ..setAttribute(
            charts.pointSymbolRendererFnKey, (index) => data[index].shape,)
        // Default symbol renderer ID for data that have no defined shape.
        ..setAttribute(charts.pointSymbolRendererIdKey, 'rect'),
    ];
  }
}

/// Sample linear data type.
class LinearSales {

  LinearSales(this.year, this.sales, this.radius, this.shape, this.fillColor,
      this.strokeWidth,);
  final int year;
  final int sales;
  final double radius;
  final String? shape;
  final charts.Color? fillColor;
  final double? strokeWidth;
}
