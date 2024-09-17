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

import 'package:example/behaviors/chart_title.dart';
import 'package:example/behaviors/initial_hint_animation.dart';
import 'package:example/behaviors/initial_selection.dart';
import 'package:example/behaviors/percent_of_domain.dart';
import 'package:example/behaviors/percent_of_domain_by_category.dart';
import 'package:example/behaviors/percent_of_series.dart';
import 'package:example/behaviors/selection_bar_highlight.dart';
import 'package:example/behaviors/selection_callback_example.dart';
import 'package:example/behaviors/selection_line_highlight.dart';
import 'package:example/behaviors/selection_line_highlight_custom_shape.dart';
import 'package:example/behaviors/selection_user_managed.dart';
import 'package:example/behaviors/slider.dart';
import 'package:example/behaviors/sliding_viewport_on_selection.dart';
import 'package:example/gallery_scaffold.dart';
import 'package:flutter/material.dart';

List<GalleryScaffold> buildGallery() => [
      const GalleryScaffold(
        listTileIcon: Icon(Icons.flag),
        title: 'Selection Bar Highlight',
        subtitle: 'Simple bar chart with tap activation',
        childBuilder: SelectionBarHighlight.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.flag),
        title: 'Selection Line Highlight',
        subtitle: 'Line chart with tap and drag activation',
        childBuilder: SelectionLineHighlight.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.flag),
        title: 'Selection Line Highlight Custom Shape',
        subtitle: 'Line chart with tap and drag activation and a custom shape',
        childBuilder: SelectionLineHighlightCustomShape.withRandomData,
      ),
      //TODO
      // new GalleryScaffold(
      //   listTileIcon: new Icon(Icons.flag),
      //   title: 'Selection Scatter Plot Highlight',
      //   subtitle: 'Scatter plot chart with tap and drag activation',
      //   childBuilder: () => 
      //new SelectionScatterPlotHighlight.withRandomData(),
      // ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.flag),
        title: 'Selection Callback Example',
        subtitle: 'Timeseries that updates external components on selection',
        childBuilder: SelectionCallbackExample.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.flag),
        title: 'User managed selection',
        subtitle:
            'Example where selection can be set and cleared programmatically',
        childBuilder: SelectionUserManaged.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.insert_chart),
        title: 'Bar Chart with initial selection',
        subtitle: 'Single series with initial selection',
        childBuilder: InitialSelection.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.flag),
        title: 'Line Chart with Chart Titles',
        subtitle: 'Line chart with four chart titles',
        childBuilder: ChartTitleLine.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.flag),
        title: 'Line Chart with Slider',
        subtitle: 'Line chart with a slider behavior',
        childBuilder: SliderLine.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.insert_chart),
        title: 'Percent of Domain',
        subtitle: 'Stacked bar chart with measures calculated as percent of '
            'domain',
        childBuilder: PercentOfDomainBarChart.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.insert_chart),
        title: 'Percent of Domain by Category',
        subtitle: 'Grouped stacked bar chart with measures calculated as '
            'percent of domain and series category',
        childBuilder: PercentOfDomainByCategoryBarChart.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.insert_chart),
        title: 'Percent of Series',
        subtitle: 'Grouped bar chart with measures calculated as percent of '
            'series',
        childBuilder: PercentOfSeriesBarChart.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.insert_chart),
        title: 'Sliding viewport on domain selection',
        subtitle: 'Center viewport on selected domain',
        childBuilder: SlidingViewportOnSelection.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.insert_chart),
        title: 'Initial hint animation ',
        subtitle: 'Animate into final viewport',
        childBuilder: InitialHintAnimation.withRandomData,
      ),
    ];
