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

import 'package:nimble_charts_common/src/chart/cartesian/axis/axis.dart'
    show Axis;
import 'package:nimble_charts_common/src/chart/cartesian/axis/tick_formatter.dart'
    show TickFormatter;
import 'package:nimble_charts_common/src/chart/cartesian/axis/tick_provider.dart'
    show TickProvider;
import 'package:nimble_charts_common/src/chart/cartesian/axis/time/auto_adjusting_date_time_tick_provider.dart'
    show AutoAdjustingDateTimeTickProvider;
import 'package:nimble_charts_common/src/chart/cartesian/axis/time/date_time_extents.dart'
    show DateTimeExtents;
import 'package:nimble_charts_common/src/chart/cartesian/axis/time/date_time_scale.dart'
    show DateTimeScale;
import 'package:nimble_charts_common/src/chart/cartesian/axis/time/date_time_tick_formatter.dart'
    show DateTimeTickFormatter;
import 'package:nimble_charts_common/src/common/date_time_factory.dart'
    show DateTimeFactory;

class DateTimeAxis extends Axis<DateTime> {
  DateTimeAxis(
    DateTimeFactory dateTimeFactory, {
    TickProvider<DateTime>? tickProvider,
    TickFormatter<DateTime>? tickFormatter,
  }) : super(
          tickProvider: tickProvider ??
              AutoAdjustingDateTimeTickProvider.createDefault(dateTimeFactory),
          tickFormatter:
              tickFormatter ?? DateTimeTickFormatter(dateTimeFactory),
          scale: DateTimeScale(dateTimeFactory),
        );

  void setScaleViewport(DateTimeExtents viewport) {
    autoViewport = false;
    (mutableScale! as DateTimeScale).viewportDomain = viewport;
  }
}
