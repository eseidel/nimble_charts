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

import 'dart:math' show Point;
import 'package:nimble_charts_common/src/common/gesture_listener.dart';
import 'package:nimble_charts_common/src/common/proxy_gesture_listener.dart';
import 'package:test/test.dart';

void main() {
  ProxyGestureListener proxy;
  Point<double> point;
  setUp(() {
    proxy = ProxyGestureListener();
    point = const Point<double>(10, 12);
  });

  group('Tap gesture', () {
    test('notified for simple case', () {
      // Setup
      final tapListener = MockListener(consumeEvent: true);
      proxy.add(GestureListener(onTap: tapListener.callback));

      // Act
      proxy.onTapTest(point);
      proxy.onTap(point);

      // Verify
      tapListener.verify(arg1: point);
    });

    test('notifies listener for second event', () {
      // Setup
      final tapListener1 = MockListener();
      proxy.add(
        GestureListener(
          onTap: tapListener1.callback,
        ),
      );

      // Act
      proxy.onTapTest(point);
      proxy.onTap(point);

      // Verify
      tapListener1.verify(arg1: point);

      // Setup Another
      final tapListener2 = MockListener();
      proxy.add(
        GestureListener(
          onTap: tapListener2.callback,
        ),
      );

      // Act
      proxy.onTapTest(point);
      proxy.onTap(point);

      // Verify
      tapListener1.verify(callCount: 2, arg1: point);
      tapListener2.verify(arg1: point);
    });

    test('notifies claiming listener registered first', () {
      // Setup
      final claimingTapDownListener = MockListener(consumeEvent: true);
      final claimingTapListener = MockListener(consumeEvent: true);

      proxy.add(
        GestureListener(
          onTapTest: claimingTapDownListener.callback,
          onTap: claimingTapListener.callback,
        ),
      );

      final nonclaimingTapDownListener = MockListener();
      final nonclaimingTapListener = MockListener();

      proxy.add(
        GestureListener(
          onTapTest: nonclaimingTapDownListener.callback,
          onTap: nonclaimingTapListener.callback,
        ),
      );

      // Act
      proxy.onTapTest(point);
      proxy.onTap(point);

      // Verify
      claimingTapDownListener.verify(arg1: point);
      claimingTapListener.verify(arg1: point);
      nonclaimingTapDownListener.verify(arg1: point);
      nonclaimingTapListener.verify(callCount: 0);
    });

    test('notifies claiming listener registered second', () {
      // Setup
      final nonclaimingTapDownListener = MockListener();
      final nonclaimingTapListener = MockListener();

      proxy.add(
        GestureListener(
          onTapTest: nonclaimingTapDownListener.callback,
          onTap: nonclaimingTapListener.callback,
        ),
      );

      final claimingTapDownListener = MockListener(consumeEvent: true);
      final claimingTapListener = MockListener(consumeEvent: true);

      proxy.add(
        GestureListener(
          onTapTest: claimingTapDownListener.callback,
          onTap: claimingTapListener.callback,
        ),
      );

      // Act
      proxy.onTapTest(point);
      proxy.onTap(point);

      // Verify
      nonclaimingTapDownListener.verify(arg1: point);
      nonclaimingTapListener.verify(callCount: 0);
      claimingTapDownListener.verify(arg1: point);
      claimingTapListener.verify(arg1: point);
    });
  });

  group('LongPress gesture', () {
    test('notifies with tap', () {
      // Setup
      final tapDown = MockListener(consumeEvent: true);
      final tap = MockListener(consumeEvent: true);
      final tapCancel = MockListener(consumeEvent: true);

      proxy.add(
        GestureListener(
          onTapTest: tapDown.callback,
          onTap: tap.callback,
          onTapCancel: tapCancel.callback,
        ),
      );

      final pressTapDown = MockListener(consumeEvent: true);
      final longPress = MockListener(consumeEvent: true);
      final pressCancel = MockListener(consumeEvent: true);

      proxy.add(
        GestureListener(
          onTapTest: pressTapDown.callback,
          onLongPress: longPress.callback,
          onTapCancel: pressCancel.callback,
        ),
      );

      // Act
      proxy.onTapTest(point);
      proxy.onLongPress(point);
      proxy.onTap(point);

      // Verify
      tapDown.verify(arg1: point);
      tap.verify(callCount: 0);
      tapCancel.verify();

      pressTapDown.verify(arg1: point);
      longPress.verify(arg1: point);
      pressCancel.verify(callCount: 0);
    });
  });

  group('Drag gesture', () {
    test('wins over tap', () {
      // Setup
      final tapDown = MockListener(consumeEvent: true);
      final tap = MockListener(consumeEvent: true);
      final tapCancel = MockListener(consumeEvent: true);

      proxy.add(
        GestureListener(
          onTapTest: tapDown.callback,
          onTap: tap.callback,
          onTapCancel: tapCancel.callback,
        ),
      );

      final dragTapDown = MockListener(consumeEvent: true);
      final dragStart = MockListener(consumeEvent: true);
      final dragUpdate = MockListener(consumeEvent: true);
      final dragEnd = MockListener(consumeEvent: true);
      final dragCancel = MockListener(consumeEvent: true);

      proxy.add(
        GestureListener(
          onTapTest: dragTapDown.callback,
          onDragStart: dragStart.callback,
          onDragUpdate: dragUpdate.callback,
          onDragEnd: dragEnd.callback,
          onTapCancel: dragCancel.callback,
        ),
      );

      // Act
      proxy.onTapTest(point);
      proxy.onDragStart(point);
      proxy.onDragUpdate(point, 1);
      proxy.onDragUpdate(point, 1);
      proxy.onDragEnd(point, 2, 3);
      proxy.onTap(point);

      // Verify
      tapDown.verify(arg1: point);
      tap.verify(callCount: 0);
      tapCancel.verify();

      dragTapDown.verify(arg1: point);
      dragStart.verify(arg1: point);
      dragUpdate.verify(callCount: 2, arg1: point, arg2: 1.0);
      dragEnd.verify(arg1: point, arg2: 2.0, arg3: 3.0);
      dragCancel.verify(callCount: 0);
    });
  });
}

class MockListener {
  MockListener({this.consumeEvent = false});
  Object _arg1;
  Object _arg2;
  Object _arg3;
  int _callCount = 0;

  final bool consumeEvent;

  bool callback([Object arg1, Object arg2, Object arg3]) {
    _arg1 = arg1;
    _arg2 = arg2;
    _arg3 = arg3;

    _callCount++;

    return consumeEvent;
  }

  void verify({int callCount = 1, Object arg1, Object arg2, Object arg3}) {
    if (callCount != any) {
      expect(_callCount, equals(callCount));
    }
    expect(_arg1, equals(arg1));
    expect(_arg2, equals(arg2));
    expect(_arg3, equals(arg3));
  }
}

const any = -1;
