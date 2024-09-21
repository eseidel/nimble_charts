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

import 'package:mockito/mockito.dart';
import 'package:nimble_charts_common/src/chart/cartesian/axis/auto_adjusting_static_tick_provider.dart';
import 'package:nimble_charts_common/src/chart/cartesian/axis/collision_report.dart'
    show CollisionReport;
import 'package:nimble_charts_common/src/chart/cartesian/axis/draw_strategy/base_tick_draw_strategy.dart';
import 'package:nimble_charts_common/src/chart/cartesian/axis/linear/linear_scale.dart';
import 'package:nimble_charts_common/src/chart/cartesian/axis/scale.dart';
import 'package:nimble_charts_common/src/chart/cartesian/axis/spec/tick_spec.dart';
import 'package:nimble_charts_common/src/chart/cartesian/axis/tick_formatter.dart';
import 'package:nimble_charts_common/src/chart/common/chart_context.dart';
import 'package:test/test.dart';

import '../../../mox.mocks.dart';

class FakeNumericTickFormatter implements TickFormatter<num> {
  int calledTimes = 0;

  @override
  List<String> format(
    List<num> tickValues,
    Map<num, String> cache, {
    num? stepSize,
  }) {
    calledTimes += 1;

    return tickValues.map((value) => value.toString()).toList();
  }
}

void main() {
  late ChartContext context;
  late MockGraphicsFactory graphicsFactory;
  late TickFormatter<num> formatter;
  late BaseTickDrawStrategy<num> drawStrategy;
  late LinearScale scale;

  setUp(() {
    context = MockChartContext();
    graphicsFactory = MockGraphicsFactory();
    formatter = MockNumericTickFormatter();
    drawStrategy = MockDrawStrategy<num>();
    scale = LinearScale()..range = const ScaleOutputExtent(0, 300);

    when(graphicsFactory.createTextElement(any)).thenReturn(MockTextElement());
  });

  group('with tick increment', () {
    test('returns the first increment if there is no collision', () {
      final tickProvider = AutoAdjustingStaticTickProvider<num>([
        const TickSpec<num>(1, label: '1'),
        const TickSpec<num>(2, label: '2'),
        const TickSpec<num>(3, label: '3'),
      ], [
        1,
        2,
      ]);
      when(drawStrategy.collides(any, any)).thenReturn(CollisionReport.empty());

      final ticks = tickProvider.getTicks(
        context: context,
        graphicsFactory: graphicsFactory,
        scale: scale,
        formatter: formatter,
        formatterValueCache: <num, String>{},
        tickDrawStrategy: drawStrategy,
        orientation: null,
      );

      expect(ticks.map((tick) => tick.value).toList(), [1, 2, 3]);
    });

    test('returns the first non colliding increment', () {
      final tickProvider = AutoAdjustingStaticTickProvider<num>([
        const TickSpec<num>(1, label: '1'),
        const TickSpec<num>(2, label: '2'),
        const TickSpec<num>(3, label: '3'),
      ], [
        1,
        2,
      ]);
      when(drawStrategy.collides(any, any)).thenAnswer(
        (invocation) =>
            (invocation.positionalArguments.first as List).length == 3
                ? CollisionReport(ticksCollide: true, ticks: [])
                : CollisionReport.empty(),
      );

      final ticks = tickProvider.getTicks(
        context: context,
        graphicsFactory: graphicsFactory,
        scale: scale,
        formatter: formatter,
        formatterValueCache: <num, String>{},
        tickDrawStrategy: drawStrategy,
        orientation: null,
      );

      expect(ticks.map((tick) => tick.value).toList(), [1, 3]);
    });
  });
}
