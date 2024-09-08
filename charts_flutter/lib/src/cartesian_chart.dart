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

import 'dart:collection' show LinkedHashMap;

import 'package:meta/meta.dart' show immutable, protected;
import 'package:nimble_charts/src/base_chart.dart' show BaseChart;
import 'package:nimble_charts/src/base_chart_state.dart' show BaseChartState;
import 'package:nimble_charts_common/common.dart' as common
    show AxisSpec, BaseChart, CartesianChart, NumericAxis, NumericAxisSpec;

@immutable
abstract class CartesianChart<D> extends BaseChart<D> {
  const CartesianChart(
    super.seriesList, {
    super.key,
    super.animate,
    super.animationDuration,
    this.domainAxis,
    this.primaryMeasureAxis,
    this.secondaryMeasureAxis,
    this.disjointMeasureAxes,
    super.defaultRenderer,
    super.customSeriesRenderers,
    super.behaviors,
    super.selectionModels,
    super.rtlSpec,
    super.defaultInteractions,
    super.layoutConfig,
    super.userManagedState,
    this.flipVerticalAxis,
  });
  final common.AxisSpec? domainAxis;
  final common.NumericAxisSpec? primaryMeasureAxis;
  final common.NumericAxisSpec? secondaryMeasureAxis;
  final LinkedHashMap<String, common.NumericAxisSpec>? disjointMeasureAxes;
  final bool? flipVerticalAxis;

  @override
  void updateCommonChart(
    common.BaseChart<D> chart,
    BaseChart<D>? oldWidget,
    BaseChartState<D> chartState,
  ) {
    super.updateCommonChart(chart, oldWidget, chartState);

    final prev = oldWidget as CartesianChart?;
    final cartesianChart = chart as common.CartesianChart;

    if (flipVerticalAxis != null) {
      cartesianChart.flipVerticalAxisOutput = flipVerticalAxis!;
    }

    if (domainAxis != null && domainAxis != prev?.domainAxis) {
      cartesianChart.domainAxisSpec = domainAxis!;
      chartState.markChartDirty();
    }

    if (primaryMeasureAxis != prev?.primaryMeasureAxis) {
      cartesianChart.primaryMeasureAxisSpec = primaryMeasureAxis;
      chartState.markChartDirty();
    }

    if (secondaryMeasureAxis != prev?.secondaryMeasureAxis) {
      cartesianChart.secondaryMeasureAxisSpec = secondaryMeasureAxis;
      chartState.markChartDirty();
    }

    if (disjointMeasureAxes != prev?.disjointMeasureAxes) {
      cartesianChart.disjointMeasureAxisSpecs = disjointMeasureAxes;
      chartState.markChartDirty();
    }
  }

  @protected
  LinkedHashMap<String, common.NumericAxis>? createDisjointMeasureAxes() {
    if (disjointMeasureAxes != null) {
      // ignore: prefer_collection_literals
      final disjointAxes = LinkedHashMap<String, common.NumericAxis>();

      disjointMeasureAxes!.forEach((axisId, axisSpec) {
        disjointAxes[axisId] = axisSpec.createAxis();
      });

      return disjointAxes;
    } else {
      return null;
    }
  }
}
