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

import 'package:example/gallery_scaffold.dart';
import 'package:example/scatter_plot_chart/animation_zoom.dart';
import 'package:example/scatter_plot_chart/bucketing_axis.dart';
import 'package:example/scatter_plot_chart/comparison_points.dart';
import 'package:example/scatter_plot_chart/simple.dart';
import 'package:flutter/material.dart';

const simpleScatterPlotChartTitle = 'Simple Scatter Plot Chart';
const simpleScatterPlotChartSubtitle = 'With a single series';

const comparisonPointsScatterPlotChartTitle =
    'Comparison Points Scatter Plot Chart';
const comparisonPointsScatterPlotChartSubtitle =
    'Scatter plot chart with comparison points';

const panAndZoomScatterPlotChartTitle = 'Pan and Zoom Scatter Plot Chart';
const panAndZoomScatterPlotChartSubtitle =
    'Simple scatter plot chart pan and zoom behaviors enabled';

const bucketingAxisScatterPlotChartTitle = 'Bucketing Axis Scatter Plot Chart';
const bucketingAxisScatterPlotChartSubtitle =
    'Scatter plot with a measure axis that buckets values less '
    'than 10% into a single region below the draw area';

List<GalleryScaffold> buildGallery() => [
      const GalleryScaffold(
        listTileIcon: Icon(Icons.scatter_plot),
        title: simpleScatterPlotChartTitle,
        subtitle: simpleScatterPlotChartSubtitle,
        childBuilder: SimpleScatterPlotChart.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.scatter_plot),
        title: comparisonPointsScatterPlotChartTitle,
        subtitle: comparisonPointsScatterPlotChartSubtitle,
        childBuilder: ComparisonPointsScatterPlotChart.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.scatter_plot),
        title: panAndZoomScatterPlotChartTitle,
        subtitle: panAndZoomScatterPlotChartSubtitle,
        childBuilder: ScatterPlotAnimationZoomChart.withRandomData,
      ),
      const GalleryScaffold(
        listTileIcon: Icon(Icons.scatter_plot),
        title: bucketingAxisScatterPlotChartTitle,
        subtitle: bucketingAxisScatterPlotChartSubtitle,
        childBuilder: BucketingAxisScatterPlotChart.withRandomData,
      ),
    ];
