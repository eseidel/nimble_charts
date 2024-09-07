// Copyright 2021 the Charts project authors. Please see the AUTHORS file
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

import 'package:nimble_charts_common/src/chart/common/series_renderer_config.dart';
import 'package:nimble_charts_common/src/chart/layout/layout_view.dart';
import 'package:nimble_charts_common/src/chart/link/link_renderer.dart';
import 'package:nimble_charts_common/src/chart/sankey/sankey_renderer.dart';
import 'package:nimble_charts_common/src/common/symbol_renderer.dart';

/// Configuration for a [SankeyRenderer].
class LinkRendererConfig<D> extends LayoutViewConfig
    implements SeriesRendererConfig<D> {
  LinkRendererConfig({
    this.customRendererId,
    this.layoutPaintOrder = LayoutViewPaintOrder.bar,
    SymbolRenderer? symbolRenderer,
  }) : symbolRenderer = symbolRenderer ?? RectSymbolRenderer();
  @override
  final String? customRendererId;

  @override
  final SymbolRenderer symbolRenderer;

  @override
  final rendererAttributes = RendererAttributes();

  /// The order to paint this renderer on the canvas.
  final int layoutPaintOrder;

  @override
  LinkRenderer<D> build() =>
      LinkRenderer<D>(config: this, rendererId: customRendererId);
}
