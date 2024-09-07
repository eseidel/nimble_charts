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


import 'package:flutter/material.dart';
import 'package:nimble_charts/flutter.dart';
import 'package:nimble_charts/src/base_chart_state.dart';
import 'package:nimble_charts_common/common.dart' as common
   

@immutable
class BarChart extends CartesianChart<String> {
  BarChart(
    super.seriesList, {
    super.key,
    super.animate,
    super.animationDuration,
    super.domainAxis,
    super.primaryMeasureAxis,
    super.secondaryMeasureAxis,
    super.disjointMeasureAxes,
    common.BarGroupingType? barGroupingType,
    common.BarRendererConfig<String>? defaultRenderer,
    super.customSeriesRenderers,
    super.behaviors,
    super.selectionModels,
    super.rtlSpec,
    this.vertical = true,
    super.defaultInteractions,
    super.layoutConfig,
    super.userManagedState,
    this.barRendererDecorator,
    super.flipVerticalAxis,
  }) : super(
          defaultRenderer: defaultRenderer ??
              common.BarRendererConfig<String>(
                groupingType: barGroupingType,
                barRendererDecorator: barRendererDecorator,
              ),
        );

  @override
  final bool vertical;
  final common.BarRendererDecorator<String>? barRendererDecorator;

  common.BarChart createCommonChart(BaseChartState chartState) =>
    // Optionally create primary and secondary measure axes if the chart was
    // configured with them. If no axes were configured, then the chart will
    // use its default types (usually a numeric axis).
     common.BarChart(
      vertical: vertical,
      layoutConfig: layoutConfig?.commonLayoutConfig,
      primaryMeasureAxis: primaryMeasureAxis?.createAxis(),
      secondaryMeasureAxis: secondaryMeasureAxis?.createAxis(),
      disjointMeasureAxes: createDisjointMeasureAxes(),
    );
  


  void addDefaultInteractions(List<ChartBehavior> behaviors) {
    behaviors.add(DomainHighlighter<String>());
  }
}
