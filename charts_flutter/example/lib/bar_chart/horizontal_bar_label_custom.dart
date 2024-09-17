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

/// Horizontal bar chart with custom style for each datum in the bar label.
library;

// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';

import 'package:flutter/material.dart';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:nimble_charts/flutter.dart' as charts;

class HorizontalBarLabelCustomChart extends StatelessWidget {
  const HorizontalBarLabelCustomChart(
    this.seriesList, {
    super.key,
    this.animate = false,
  });

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory HorizontalBarLabelCustomChart.withRandomData() =>
      HorizontalBarLabelCustomChart(_createRandomData());
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  /// Creates a [charts.BarChart] with sample data and no transition.
  // ignore: sort_constructors_first
  factory HorizontalBarLabelCustomChart.createWithSampleData() =>
      HorizontalBarLabelCustomChart(
        _createSampleData(),
      );

  /// Create random data.
  static List<charts.Series<OrdinalSales, String>> _createRandomData() {
    final random = Random();

    final data = [
      OrdinalSales('2014', random.nextInt(100)),
      OrdinalSales('2015', random.nextInt(100)),
      OrdinalSales('2016', random.nextInt(100)),
      OrdinalSales('2017', random.nextInt(100)),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the bar label.
        labelAccessorFn: (sales, _) => '${sales.year}: \$${sales.sales}',
        insideLabelStyleAccessorFn: (sales, _) {
          final color = (sales.year == '2014')
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.yellow.shadeDefault.darker;
          return charts.TextStyleSpec(color: color);
        },
        outsideLabelStyleAccessorFn: (sales, _) {
          final color = (sales.year == '2014')
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.yellow.shadeDefault.darker;
          return charts.TextStyleSpec(color: color);
        },
      ),
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  // The [BarLabelDecorator] has settings to set the text style for all labels
  // for inside the bar and outside the bar. To be able to control each datum's
  // style, set the style accessor functions on the series.
  @override
  Widget build(BuildContext context) => charts.BarChart(
        seriesList,
        animate: animate,
        vertical: false,
        barRendererDecorator: charts.BarLabelDecorator<String>(),
        // Hide domain axis.
        domainAxis:
            const charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
      );

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('2014', 5),
      OrdinalSales('2015', 25),
      OrdinalSales('2016', 100),
      OrdinalSales('2017', 75),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the bar label.
        labelAccessorFn: (sales, _) => '${sales.year}: \$${sales.sales}',
        insideLabelStyleAccessorFn: (sales, _) {
          final color = (sales.year == '2014')
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.yellow.shadeDefault.darker;
          return charts.TextStyleSpec(color: color);
        },
        outsideLabelStyleAccessorFn: (sales, _) {
          final color = (sales.year == '2014')
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.yellow.shadeDefault.darker;
          return charts.TextStyleSpec(color: color);
        },
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  OrdinalSales(this.year, this.sales);
  final String year;
  final int sales;
}
