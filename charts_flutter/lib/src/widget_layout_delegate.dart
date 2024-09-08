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
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:nimble_charts/src/behaviors/chart_behavior.dart'
    show BuildableBehavior;
import 'package:nimble_charts_common/common.dart' as common
    show BehaviorPosition, InsideJustification, OutsideJustification;

/// Layout delegate that layout chart widget with [BuildableBehavior] widgets.
class WidgetLayoutDelegate extends MultiChildLayoutDelegate {
  WidgetLayoutDelegate(this.chartID, this.idAndBehavior, this.isRTL);

  /// ID of the common chart widget.
  final String chartID;

  /// Directionality of the widget.
  final bool isRTL;

  /// ID and [BuildableBehavior] of the widgets for calculating offset.
  final Map<String, BuildableBehavior> idAndBehavior;

  @override
  void performLayout(Size size) {
    // TODO: Change this to a layout manager that supports more
    // than one buildable behavior that changes chart size. Remove assert when
    // this is possible.
    assert(idAndBehavior.keys.isEmpty || idAndBehavior.keys.length == 1);

    // Size available for the chart widget.
    var availableWidth = size.width;
    var availableHeight = size.height;
    var chartOffset = Offset.zero;

    // Measure the first buildable behavior.
    final behaviorID =
        idAndBehavior.keys.isNotEmpty ? idAndBehavior.keys.first : null;
    var behaviorSize = Size.zero;
    if (behaviorID != null) {
      if (hasChild(behaviorID)) {
        final leftPosition =
            isRTL ? common.BehaviorPosition.end : common.BehaviorPosition.start;
        final rightPosition =
            isRTL ? common.BehaviorPosition.start : common.BehaviorPosition.end;
        final behaviorPosition = idAndBehavior[behaviorID]!.position;

        behaviorSize = layoutChild(behaviorID, BoxConstraints.loose(size));
        if (behaviorPosition == common.BehaviorPosition.top) {
          chartOffset = Offset(0, behaviorSize.height);
          availableHeight -= behaviorSize.height;
        } else if (behaviorPosition == common.BehaviorPosition.bottom) {
          availableHeight -= behaviorSize.height;
        } else if (behaviorPosition == leftPosition) {
          chartOffset = Offset(behaviorSize.width, 0);
          availableWidth -= behaviorSize.width;
        } else if (behaviorPosition == rightPosition) {
          availableWidth -= behaviorSize.width;
        }
      }
    }

    // Layout chart.
    final chartSize = Size(availableWidth, availableHeight);
    if (hasChild(chartID)) {
      layoutChild(chartID, BoxConstraints.tight(chartSize));
      positionChild(chartID, chartOffset);
    }

    // Position buildable behavior.
    if (behaviorID != null) {
      // TODO: Unable to relayout with new smaller width.
      // In the delegate, all children are required to have layout called
      // exactly once.
      final behaviorOffset = _getBehaviorOffset(
        idAndBehavior[behaviorID]!,
        behaviorSize: behaviorSize,
        chartSize: chartSize,
        isRTL: isRTL,
      );

      positionChild(behaviorID, behaviorOffset);
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) =>
      // TODO: Deep equality check because the instance will not be
      // the same on each build, even if the buildable behavior has not changed.
      idAndBehavior != (oldDelegate as WidgetLayoutDelegate).idAndBehavior;

  // Calculate buildable behavior's offset.
  Offset _getBehaviorOffset(
    BuildableBehavior behavior, {
    required Size behaviorSize,
    required Size chartSize,
    required bool isRTL,
  }) {
    late Offset behaviorOffset;

    final behaviorPosition = behavior.position;
    final outsideJustification = behavior.outsideJustification;
    final insideJustification = behavior.insideJustification;

    if (behaviorPosition == common.BehaviorPosition.top ||
        behaviorPosition == common.BehaviorPosition.bottom) {
      final heightOffset = behaviorPosition == common.BehaviorPosition.bottom
          ? chartSize.height
          : 0.0;

      final horizontalJustification =
          getOutsideJustification(outsideJustification, isRTL);

      switch (horizontalJustification) {
        case HorizontalJustification.leftDrawArea:
          behaviorOffset = Offset(
            behavior.drawAreaBounds!.left.toDouble(),
            heightOffset,
          );
        case HorizontalJustification.left:
          behaviorOffset = Offset(0, heightOffset);
        case HorizontalJustification.rightDrawArea:
          behaviorOffset = Offset(
            behavior.drawAreaBounds!.right - behaviorSize.width,
            heightOffset,
          );
        case HorizontalJustification.right:
          behaviorOffset =
              Offset(chartSize.width - behaviorSize.width, heightOffset);
      }
    } else if (behaviorPosition == common.BehaviorPosition.start ||
        behaviorPosition == common.BehaviorPosition.end) {
      final widthOffset =
          (isRTL && behaviorPosition == common.BehaviorPosition.start) ||
                  (!isRTL && behaviorPosition == common.BehaviorPosition.end)
              ? chartSize.width
              : 0.0;

      switch (outsideJustification) {
        case common.OutsideJustification.startDrawArea:
        case common.OutsideJustification.middleDrawArea:
          behaviorOffset =
              Offset(widthOffset, behavior.drawAreaBounds!.top.toDouble());
        case common.OutsideJustification.start:
        case common.OutsideJustification.middle:
          behaviorOffset = Offset(widthOffset, 0);
        case common.OutsideJustification.endDrawArea:
          behaviorOffset = Offset(
            widthOffset,
            behavior.drawAreaBounds!.bottom - behaviorSize.height,
          );
        case common.OutsideJustification.end:
          behaviorOffset =
              Offset(widthOffset, chartSize.height - behaviorSize.height);
      }
    } else if (behaviorPosition == common.BehaviorPosition.inside) {
      final rightOffset = Offset(chartSize.width - behaviorSize.width, 0);

      switch (insideJustification) {
        case common.InsideJustification.topStart:
          behaviorOffset = isRTL ? rightOffset : Offset.zero;
        case common.InsideJustification.topEnd:
          behaviorOffset = isRTL ? Offset.zero : rightOffset;
      }
    }

    return behaviorOffset;
  }

  HorizontalJustification getOutsideJustification(
    common.OutsideJustification justification,
    bool isRTL,
  ) {
    HorizontalJustification mappedJustification;

    switch (justification) {
      case common.OutsideJustification.startDrawArea:
      case common.OutsideJustification.middleDrawArea:
        mappedJustification = isRTL
            ? HorizontalJustification.rightDrawArea
            : HorizontalJustification.leftDrawArea;
      case common.OutsideJustification.start:
      case common.OutsideJustification.middle:
        mappedJustification = isRTL
            ? HorizontalJustification.right
            : HorizontalJustification.left;
      case common.OutsideJustification.endDrawArea:
        mappedJustification = isRTL
            ? HorizontalJustification.leftDrawArea
            : HorizontalJustification.rightDrawArea;
      case common.OutsideJustification.end:
        mappedJustification = isRTL
            ? HorizontalJustification.left
            : HorizontalJustification.right;
    }

    return mappedJustification;
  }
}

enum HorizontalJustification {
  leftDrawArea,
  left,
  rightDrawArea,
  right,
}
