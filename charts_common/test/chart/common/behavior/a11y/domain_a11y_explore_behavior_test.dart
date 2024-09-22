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

import 'dart:math' show Rectangle;

import 'package:mockito/mockito.dart';
import 'package:nimble_charts_common/src/chart/cartesian/axis/axis.dart';
import 'package:nimble_charts_common/src/chart/cartesian/cartesian_chart.dart';
import 'package:nimble_charts_common/src/chart/common/behavior/a11y/domain_a11y_explore_behavior.dart';
import 'package:nimble_charts_common/src/chart/common/processed_series.dart';
import 'package:nimble_charts_common/src/data/series.dart';
import 'package:test/test.dart';

import '../../../../mox.mocks.dart';

class FakeCartesianChart extends CartesianChart<String> {
  @override
  late Rectangle<int> drawAreaBounds;

  void callFireOnPostprocess(List<MutableSeries<String>> seriesList) {
    fireOnPostprocess(seriesList);
  }

  @override
  void initDomainAxis() {}
}

void main() {
  late FakeCartesianChart chart;
  late DomainA11yExploreBehavior<String> behavior;
  late MockAxis domainAxis;

  late MutableSeries<String> series1;
  final s1D1 = MyRow('s1d1', 11, 'a11yd1');
  final s1D2 = MyRow('s1d2', 12, 'a11yd2');
  final s1D3 = MyRow('s1d3', 13, 'a11yd3');

  setUp(() {
    chart = FakeCartesianChart()
      ..drawAreaBounds = const Rectangle(50, 20, 150, 80);

    behavior = DomainA11yExploreBehavior<String>(
      vocalizationCallback: domainVocalization,
    )..attachTo(chart);

    domainAxis = MockAxis();
    series1 = MutableSeries(
      Series<MyRow, String>(
        id: 's1',
        data: [s1D1, s1D2, s1D3],
        domainFn: (row, _) => row.campaign,
        measureFn: (row, _) => row.count,
      ),
    )..setAttr(domainAxisKey, domainAxis);
  });

  test('creates nodes for vertically drawn charts', () {
    // A LTR chart
    final context = MockChartContext();
    when(context.chartContainerIsRtl).thenReturn(false);
    when(context.isRtl).thenReturn(false);
    chart
      ..context = context
      // Drawn vertically
      ..vertical = true;
    // Set step size of 50, which should be the width of the bounding box
    when(domainAxis.stepSize).thenReturn(50);
    when(domainAxis.getLocation('s1d1')).thenReturn(75);
    when(domainAxis.getLocation('s1d2')).thenReturn(125);
    when(domainAxis.getLocation('s1d3')).thenReturn(175);
    // Call fire on post process for the behavior to get the series list.
    chart.callFireOnPostprocess([series1]);

    final nodes = behavior.createA11yNodes();

    expect(nodes, hasLength(3));
    expect(nodes[0].label, equals('s1d1'));
    expect(nodes[0].boundingBox, equals(const Rectangle(50, 20, 50, 80)));
    expect(nodes[1].label, equals('s1d2'));
    expect(nodes[1].boundingBox, equals(const Rectangle(100, 20, 50, 80)));
    expect(nodes[2].label, equals('s1d3'));
    expect(nodes[2].boundingBox, equals(const Rectangle(150, 20, 50, 80)));
  });

  test('creates nodes for vertically drawn RTL charts', () {
    // A RTL chart
    final context = MockChartContext();
    when(context.chartContainerIsRtl).thenReturn(true);
    when(context.isRtl).thenReturn(true);
    chart
      ..context = context
      // Drawn vertically
      ..vertical = true;
    // Set step size of 50, which should be the width of the bounding box
    when(domainAxis.stepSize).thenReturn(50);
    when(domainAxis.getLocation('s1d1')).thenReturn(175);
    when(domainAxis.getLocation('s1d2')).thenReturn(125);
    when(domainAxis.getLocation('s1d3')).thenReturn(75);
    // Call fire on post process for the behavior to get the series list.
    chart.callFireOnPostprocess([series1]);

    final nodes = behavior.createA11yNodes();

    expect(nodes, hasLength(3));
    expect(nodes[0].label, equals('s1d1'));
    expect(nodes[0].boundingBox, equals(const Rectangle(150, 20, 50, 80)));
    expect(nodes[1].label, equals('s1d2'));
    expect(nodes[1].boundingBox, equals(const Rectangle(100, 20, 50, 80)));
    expect(nodes[2].label, equals('s1d3'));
    expect(nodes[2].boundingBox, equals(const Rectangle(50, 20, 50, 80)));
  });

  test('creates nodes for horizontally drawn charts', () {
    // A LTR chart
    final context = MockChartContext();
    when(context.chartContainerIsRtl).thenReturn(false);
    when(context.isRtl).thenReturn(false);
    chart
      ..context = context
      // Drawn horizontally
      ..vertical = false;
    // Set step size of 20, which should be the height of the bounding box
    when(domainAxis.stepSize).thenReturn(20);
    when(domainAxis.getLocation('s1d1')).thenReturn(30);
    when(domainAxis.getLocation('s1d2')).thenReturn(50);
    when(domainAxis.getLocation('s1d3')).thenReturn(70);
    // Call fire on post process for the behavior to get the series list.
    chart.callFireOnPostprocess([series1]);

    final nodes = behavior.createA11yNodes();

    expect(nodes, hasLength(3));
    expect(nodes[0].label, equals('s1d1'));
    expect(nodes[0].boundingBox, equals(const Rectangle(50, 20, 150, 20)));
    expect(nodes[1].label, equals('s1d2'));
    expect(nodes[1].boundingBox, equals(const Rectangle(50, 40, 150, 20)));
    expect(nodes[2].label, equals('s1d3'));
    expect(nodes[2].boundingBox, equals(const Rectangle(50, 60, 150, 20)));
  });

  test('creates nodes for horizontally drawn RTL charts', () {
    // A LTR chart
    final context = MockChartContext();
    when(context.chartContainerIsRtl).thenReturn(true);
    when(context.isRtl).thenReturn(true);
    chart
      ..context = context
      // Drawn horizontally
      ..vertical = false;
    // Set step size of 20, which should be the height of the bounding box
    when(domainAxis.stepSize).thenReturn(20);
    when(domainAxis.getLocation('s1d1')).thenReturn(30);
    when(domainAxis.getLocation('s1d2')).thenReturn(50);
    when(domainAxis.getLocation('s1d3')).thenReturn(70);
    // Call fire on post process for the behavior to get the series list.
    chart.callFireOnPostprocess([series1]);

    final nodes = behavior.createA11yNodes();

    expect(nodes, hasLength(3));
    expect(nodes[0].label, equals('s1d1'));
    expect(nodes[0].boundingBox, equals(const Rectangle(50, 20, 150, 20)));
    expect(nodes[1].label, equals('s1d2'));
    expect(nodes[1].boundingBox, equals(const Rectangle(50, 40, 150, 20)));
    expect(nodes[2].label, equals('s1d3'));
    expect(nodes[2].boundingBox, equals(const Rectangle(50, 60, 150, 20)));
  });

  test('nodes ordered correctly with a series missing a domain', () {
    // A LTR chart
    final context = MockChartContext();
    when(context.chartContainerIsRtl).thenReturn(false);
    when(context.isRtl).thenReturn(false);
    chart
      ..context = context
      // Drawn vertically
      ..vertical = true;
    // Set step size of 50, which should be the width of the bounding box
    when(domainAxis.stepSize).thenReturn(50);
    when(domainAxis.getLocation('s1d1')).thenReturn(75);
    when(domainAxis.getLocation('s1d2')).thenReturn(125);
    when(domainAxis.getLocation('s1d3')).thenReturn(175);
    // Create a series with a missing domain
    final seriesWithMissingDomain = MutableSeries(
      Series<MyRow, String>(
        id: 'm1',
        data: [s1D1, s1D3],
        domainFn: (row, _) => row.campaign,
        measureFn: (row, _) => row.count,
      ),
    )..setAttr(domainAxisKey, domainAxis);

    // Call fire on post process for the behavior to get the series list.
    chart.callFireOnPostprocess([seriesWithMissingDomain, series1]);

    final nodes = behavior.createA11yNodes();

    expect(nodes, hasLength(3));
    expect(nodes[0].label, equals('s1d1'));
    expect(nodes[0].boundingBox, equals(const Rectangle(50, 20, 50, 80)));
    expect(nodes[1].label, equals('s1d2'));
    expect(nodes[1].boundingBox, equals(const Rectangle(100, 20, 50, 80)));
    expect(nodes[2].label, equals('s1d3'));
    expect(nodes[2].boundingBox, equals(const Rectangle(150, 20, 50, 80)));
  });

  test('creates nodes with minimum width', () {
    // A behavior with minimum width of 50
    final behaviorWithMinWidth =
        DomainA11yExploreBehavior<String>(minimumWidth: 50);
    // ignore: cascade_invocations
    behaviorWithMinWidth.attachTo(chart);

    // A LTR chart
    final context = MockChartContext();
    when(context.chartContainerIsRtl).thenReturn(false);
    when(context.isRtl).thenReturn(false);
    chart
      ..context = context
      // Drawn vertically
      ..vertical = true;
    // Return a step size of 20, which is less than the minimum width.
    // Expect the results to use the minimum width of 50 instead.
    when(domainAxis.stepSize).thenReturn(20);
    when(domainAxis.getLocation('s1d1')).thenReturn(75);
    when(domainAxis.getLocation('s1d2')).thenReturn(125);
    when(domainAxis.getLocation('s1d3')).thenReturn(175);
    // Call fire on post process for the behavior to get the series list.
    chart.callFireOnPostprocess([series1]);

    final nodes = behaviorWithMinWidth.createA11yNodes();

    expect(nodes, hasLength(3));
    expect(nodes[0].label, equals('s1d1'));
    expect(nodes[0].boundingBox, equals(const Rectangle(50, 20, 50, 80)));
    expect(nodes[1].label, equals('s1d2'));
    expect(nodes[1].boundingBox, equals(const Rectangle(100, 20, 50, 80)));
    expect(nodes[2].label, equals('s1d3'));
    expect(nodes[2].boundingBox, equals(const Rectangle(150, 20, 50, 80)));
  });
}

class MyRow {
  MyRow(this.campaign, this.count, this.a11yDescription);
  final String campaign;
  final int count;
  final String a11yDescription;
}
