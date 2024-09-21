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

import 'dart:math';

import 'package:mockito/mockito.dart';
import 'package:nimble_charts_common/src/chart/cartesian/axis/axis.dart';
import 'package:nimble_charts_common/src/chart/cartesian/axis/collision_report.dart';
import 'package:nimble_charts_common/src/chart/cartesian/axis/scale.dart';
import 'package:nimble_charts_common/src/chart/cartesian/axis/spec/tick_spec.dart';
import 'package:nimble_charts_common/src/chart/cartesian/axis/static_tick_provider.dart';
import 'package:nimble_charts_common/src/common/graphics_factory.dart';
import 'package:nimble_charts_common/src/common/text_element.dart';
import 'package:test/test.dart';

import '../../../mox.mocks.dart';

class MockGraphicsFactory extends Mock implements GraphicsFactory {
  @override
  TextElement createTextElement(String _) => MockTextElement();
}

StaticTickProvider<num> _createProvider(List<num> values) =>
    StaticTickProvider<num>(values.map(TickSpec.new).toList());

void main() {
  test('changing first tick only', () {
    final axis = NumericAxis(
      tickProvider: _createProvider([1, 10]),
    );

    final drawStrategy = MockTickDrawStrategy();
    when(drawStrategy.collides(any, any)).thenReturn(
      CollisionReport<num>(
        ticks: [],
        ticksCollide: false,
        alternateTicksUsed: false,
      ),
    );

    final tester = AxisTester(axis);
    axis
      ..tickDrawStrategy = drawStrategy
      ..graphicsFactory = MockGraphicsFactory();
    tester.scale!.range = const ScaleOutputExtent(0, 300);

    axis
      ..updateTicks()
      ..tickProvider = _createProvider([5, 10])
      ..updateTicks();

    // The old value should still be there as it gets animated out, but the
    // values should be sorted by their position.
    expect(tester.axisValues, equals([1, 5, 10]));
  });

  test('updates max label width on layout change', () {
    final axis = NumericAxis(
      tickProvider: _createProvider([1, 10]),
    );

    final drawStrategy = MockTickDrawStrategy();
    when(drawStrategy.collides(any, any)).thenReturn(
      CollisionReport<num>(
        ticks: [],
        ticksCollide: false,
        alternateTicksUsed: false,
      ),
    );

    axis
      ..tickDrawStrategy = drawStrategy
      ..graphicsFactory = MockGraphicsFactory();
    const axisOrientation = AxisOrientation.left;
    axis.axisOrientation = axisOrientation;

    const maxWidth = 100;
    const maxHeight = 500;
    const componentBounds = Rectangle<int>(0, 0, maxWidth, maxHeight);
    const drawBounds = Rectangle<int>(0, 0, maxWidth, maxHeight);
    axis.layout(componentBounds, drawBounds);

    verify(
      drawStrategy.updateTickWidth(
        any,
        maxWidth,
        maxHeight,
        axisOrientation,
      ),
    ).called(1);
  });
}
