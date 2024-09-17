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

/// Vertical bar chart with bar label renderer example.
library;

// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';

import 'package:flutter/material.dart';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:nimble_charts/flutter.dart' as charts;

class VerticalBarLabelChart extends StatelessWidget {
  const VerticalBarLabelChart(
    this.seriesList, {
    super.key,
    this.animate = false,
  });

  /// Creates a [charts.BarChart] with sample data and no transition.
  factory VerticalBarLabelChart.withSampleData() => VerticalBarLabelChart(
        _createSampleData(),
      );

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory VerticalBarLabelChart.withRandomData() =>
      VerticalBarLabelChart(_createRandomData());
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

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
        labelAccessorFn: (sales, _) => sales.sales,
      ),
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  // [BarLabelDecorator] will automatically position the label
  // inside the bar if the label will fit. If the label will not fit,
  // it will draw outside of the bar.
  // Labels can always display inside or outside using [LabelPosition].
  //
  // Text style for inside / outside can be controlled independently by setting
  // [insideLabelStyleSpec] and [outsideLabelStyleSpec].
  @override
  Widget build(BuildContext context) => charts.BarChart(
        seriesList,
        animate: animate,
        // Set a bar label decorator.
        // Example configuring different styles for inside/outside:
        //       barRendererDecorator: new charts.BarLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        barRendererDecorator: charts.BarLabelDecorator<String>(),
        domainAxis: const charts.OrdinalAxisSpec(),
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
        labelAccessorFn: (sales, _) => '\$${sales.sales}',
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
