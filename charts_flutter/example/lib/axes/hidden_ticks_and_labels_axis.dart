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

/// No Axis Example
library;

// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:flutter/material.dart';
import 'package:nimble_charts/flutter.dart' as charts;

/// Example of hiding both axis.
class HiddenTicksAndLabelsAxis extends StatelessWidget {
  const HiddenTicksAndLabelsAxis(this.seriesList,
      {super.key, this.animate = false});

  factory HiddenTicksAndLabelsAxis.withSampleData() => HiddenTicksAndLabelsAxis(
        _createSampleData(),
      );

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory HiddenTicksAndLabelsAxis.withRandomData() =>
      HiddenTicksAndLabelsAxis(_createRandomData());
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  /// Create random data.
  static List<charts.Series<OrdinalSales, String>> _createRandomData() {
    final random = Random();

    final globalSalesData = [
      OrdinalSales('2014', random.nextInt(100) * 100),
      OrdinalSales('2015', random.nextInt(100) * 100),
      OrdinalSales('2016', random.nextInt(100) * 100),
      OrdinalSales('2017', random.nextInt(100) * 100),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Global Revenue',
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: globalSalesData,
      ),
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) => charts.BarChart(
        seriesList,
        animate: animate,

        /// Assign a custom style for the measure axis.
        ///
        /// The NoneRenderSpec can still draw an axis line with
        /// showAxisLine=true.
        primaryMeasureAxis:
            const charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),

        /// This is an OrdinalAxisSpec to match up with BarChart's default
        /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
        /// other charts).
        domainAxis: const charts.OrdinalAxisSpec(
          // Make sure that we draw the domain axis line.
          showAxisLine: true,
          // But don't draw anything else.
          renderSpec: charts.NoneRenderSpec(),
        ),
      );

  /// Create series list with single series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final globalSalesData = [
      OrdinalSales('2014', 5000),
      OrdinalSales('2015', 25000),
      OrdinalSales('2016', 100000),
      OrdinalSales('2017', 750000),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Global Revenue',
        domainFn: (sales, _) => sales.year,
        measureFn: (sales, _) => sales.sales,
        data: globalSalesData,
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
