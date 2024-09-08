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

import 'package:nimble_charts/flutter.dart';
import 'package:nimble_charts/src/base_chart_state.dart';
import 'package:nimble_charts/src/cartesian_chart.dart' as cart;
import 'package:nimble_charts_common/common.dart' as common;

/// A numeric combo chart supports rendering each series of data with different
/// series renderers.
///
/// Note that if you have DateTime data, you should use [common.TimeSeriesChart]
/// . We do not expose a separate DateTimeComboChart because it would just be
/// a copy of that chart.
class NumericComboChart extends cart.CartesianChart<num> {
  const NumericComboChart(
    super.seriesList, {
    super.key,
    super.animate,
    super.animationDuration,
    super.domainAxis,
    super.primaryMeasureAxis,
    super.secondaryMeasureAxis,
    super.defaultRenderer,
    super.customSeriesRenderers,
    super.behaviors,
    super.selectionModels,
    super.rtlSpec,
    super.layoutConfig,
    super.defaultInteractions,
  });

  @override
  common.BaseChart<num> createCommonChart(BaseChartState<num> chartState) =>
      // Optionally create primary and secondary measure axes if the chart was
      // configured with them. If no axes were configured, then the chart will
      // use its default types (usually a numeric axis).
      NumericCartesianChart(
        layoutConfig: layoutConfig?.commonLayoutConfig,
        primaryMeasureAxis: primaryMeasureAxis?.createAxis(),
        secondaryMeasureAxis: secondaryMeasureAxis?.createAxis(),
      );
}

/// An ordinal combo chart supports rendering each series of data with different
/// series renderers.
class OrdinalComboChart extends cart.CartesianChart<String> {
  // ignore: use_super_parameters
  const OrdinalComboChart(
    List<common.Series<dynamic, String>> seriesList, {
    super.key,
    bool? animate,
    Duration? animationDuration,
    common.AxisSpec? domainAxis,
    common.NumericAxisSpec? primaryMeasureAxis,
    common.NumericAxisSpec? secondaryMeasureAxis,
    common.SeriesRendererConfig<String>? defaultRenderer,
    List<common.SeriesRendererConfig<String>>? customSeriesRenderers,
    List<ChartBehavior<String>>? behaviors,
    List<SelectionModelConfig<String>>? selectionModels,
    common.RTLSpec? rtlSpec,
    LayoutConfig? layoutConfig,
    bool defaultInteractions = true,
  }) : super(
          seriesList,
          animate: animate,
          animationDuration: animationDuration,
          domainAxis: domainAxis,
          primaryMeasureAxis: primaryMeasureAxis,
          secondaryMeasureAxis: secondaryMeasureAxis,
          defaultRenderer: defaultRenderer,
          customSeriesRenderers: customSeriesRenderers,
          behaviors: behaviors,
          selectionModels: selectionModels,
          rtlSpec: rtlSpec,
          layoutConfig: layoutConfig,
          defaultInteractions: defaultInteractions,
        );

  @override
  common.BaseChart<String> createCommonChart(
    BaseChartState<String> chartState,
  ) =>
      // Optionally create primary and secondary measure axes if the chart was
      // configured with them. If no axes were configured, then the chart will
      // use its default types (usually a numeric axis).
      common.OrdinalCartesianChart(
        layoutConfig: layoutConfig?.commonLayoutConfig,
        primaryMeasureAxis: primaryMeasureAxis?.createAxis(),
        secondaryMeasureAxis: secondaryMeasureAxis?.createAxis(),
      );
}
