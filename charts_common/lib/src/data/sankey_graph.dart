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

import 'package:meta/meta.dart';
import 'package:nimble_charts_common/common.dart';
import 'package:nimble_charts_common/src/data/graph.dart' as graph;
import 'package:nimble_charts_common/src/data/graph.dart';
import 'package:nimble_charts_common/src/data/graph_utils.dart';

/// Directed acyclic graph with Sankey diagram related data.
class SankeyGraph<N, L, D> extends Graph<N, L, D> {
  factory SankeyGraph({
    required String id,
    required List<N> nodes,
    required List<L> links,
    required TypedAccessorFn<N, D> nodeDomainFn,
    required TypedAccessorFn<L, D> linkDomainFn,
    required TypedAccessorFn<L, N> sourceFn,
    required TypedAccessorFn<L, N> targetFn,
    required TypedAccessorFn<N, num?> nodeMeasureFn,
    required TypedAccessorFn<L, num?> linkMeasureFn,
    TypedAccessorFn<N, Color>? nodeColorFn,
    TypedAccessorFn<N, Color>? nodeFillColorFn,
    TypedAccessorFn<N, FillPatternType>? nodeFillPatternFn,
    TypedAccessorFn<N, num>? nodeStrokeWidthPxFn,
    TypedAccessorFn<L, Color>? linkFillColorFn,
    TypedAccessorFn<L, num>? secondaryLinkMeasureFn,
  }) =>
      SankeyGraph._(
        id: id,
        nodes: _convertSankeyNodes<N, L, D>(
          nodes,
          links,
          sourceFn,
          targetFn,
          nodeDomainFn,
        ),
        links: _convertSankeyLinks<N, L>(
          links,
          sourceFn,
          targetFn,
          secondaryLinkMeasureFn,
        ),
        nodeDomainFn: actOnNodeData<N, L, D>(nodeDomainFn)!,
        linkDomainFn: actOnLinkData<N, L, D>(linkDomainFn)!,
        nodeMeasureFn: actOnNodeData<N, L, num?>(nodeMeasureFn)!,
        linkMeasureFn: actOnLinkData<N, L, num?>(linkMeasureFn)!,
        nodeColorFn: actOnNodeData<N, L, Color>(nodeColorFn),
        nodeFillColorFn: actOnNodeData<N, L, Color>(nodeFillColorFn),
        nodeFillPatternFn:
            actOnNodeData<N, L, FillPatternType>(nodeFillPatternFn),
        nodeStrokeWidthPxFn: actOnNodeData<N, L, num>(nodeStrokeWidthPxFn),
        linkFillColorFn: actOnLinkData<N, L, Color>(linkFillColorFn),
      );

  SankeyGraph._({
    required this.nodes,
    required this.links,
    required super.id,
    required super.nodeDomainFn,
    required super.linkDomainFn,
    required super.nodeMeasureFn,
    required super.linkMeasureFn,
    super.nodeColorFn,
    super.nodeFillColorFn,
    super.nodeFillPatternFn,
    super.nodeStrokeWidthPxFn,
    super.linkFillColorFn,
  }) : super.base(
          nodes: nodes,
          links: links,
        );
  @override
  final List<SankeyNode<N, L>> nodes;

  @override
  final List<SankeyLink<N, L>> links;
}

/// Return a list of links from the Sankey link data type
List<SankeyLink<N, L>> _convertSankeyLinks<N, L>(
  List<L> links,
  TypedAccessorFn<L, N> sourceFn,
  TypedAccessorFn<L, N> targetFn, [
  TypedAccessorFn<L, num>? secondaryLinkMeasureFn,
]) {
  final graphLinks = <SankeyLink<N, L>>[];
  for (final link in links) {
    final sourceNode = sourceFn(link, indexNotRelevant);
    final targetNode = targetFn(link, indexNotRelevant);
    final secondaryLinkMeasure = accessorIfExists<L, num>(
      secondaryLinkMeasureFn,
      link,
      indexNotRelevant,
    );
    graphLinks.add(
      SankeyLink(
        SankeyNode(sourceNode),
        SankeyNode(targetNode),
        link,
        secondaryLinkMeasure: secondaryLinkMeasure,
      ),
    );
  }
  return graphLinks;
}

/// Return a list of nodes from the Sankey node data type
List<SankeyNode<N, L>> _convertSankeyNodes<N, L, D>(
  List<N> nodes,
  List<L> links,
  TypedAccessorFn<L, N> sourceFn,
  TypedAccessorFn<L, N> targetFn,
  TypedAccessorFn<N, D> nodeDomainFn,
) {
  final graphNodes = <SankeyNode<N, L>>[];
  final graphLinks = _convertSankeyLinks(links, sourceFn, targetFn);
  final nodeClassDomainFn = actOnNodeData<N, L, D>(nodeDomainFn)!;
  final nodeMap = <D, SankeyNode<N, L>>{};

  for (final node in nodes) {
    nodeMap.putIfAbsent(
      nodeDomainFn(node, indexNotRelevant),
      () => SankeyNode(node),
    );
  }

  for (final link in graphLinks) {
    nodeMap
      ..update(
        nodeClassDomainFn(link.target, indexNotRelevant),
        (node) => _addLinkToSankeyNode(node, link, isIncomingLink: true),
        ifAbsent: () => _addLinkToAbsentSankeyNode(link, isIncomingLink: true),
      )
      ..update(
        nodeClassDomainFn(link.source, indexNotRelevant),
        (node) => _addLinkToSankeyNode(node, link, isIncomingLink: false),
        ifAbsent: () => _addLinkToAbsentSankeyNode(link, isIncomingLink: false),
      );
  }

  nodeMap.forEach((domainId, node) => graphNodes.add(node));
  return graphNodes;
}

/// Returns a list of nodes sorted topologically for a directed acyclic graph.
@visibleForTesting
List<Node<N, L>> topologicalNodeSort<N, L, D>(
  List<Node<N, L>> givenNodes,
  TypedAccessorFn<Node<N, L>, D> nodeDomainFn,
  TypedAccessorFn<graph.Link<N, L>, D> linkDomainFn,
) {
  final nodeMap = <D, Node<N, L>>{};
  final givenNodeMap = <D, Node<N, L>>{};
  final sortedNodes = <Node<N, L>>[];
  final sourceNodes = <Node<N, L>>[];
  final nodes = _cloneNodeList(givenNodes);

  for (var i = 0; i < nodes.length; i++) {
    nodeMap.putIfAbsent(
      nodeDomainFn(nodes[i], indexNotRelevant),
      () => nodes[i],
    );
    givenNodeMap.putIfAbsent(
      nodeDomainFn(givenNodes[i], indexNotRelevant),
      () => givenNodes[i],
    );
    if (nodes[i].incomingLinks.isEmpty) {
      sourceNodes.add(nodes[i]);
    }
  }

  while (sourceNodes.isNotEmpty) {
    final source = sourceNodes.removeLast();
    sortedNodes.add(
      givenNodeMap[nodeDomainFn(source, indexNotRelevant)]!,
    );
    while (source.outgoingLinks.isNotEmpty) {
      final toRemove = source.outgoingLinks.removeLast();
      nodeMap[nodeDomainFn(toRemove.target, indexNotRelevant)]
          ?.incomingLinks
          .removeWhere(
            (link) =>
                linkDomainFn(link, indexNotRelevant) ==
                linkDomainFn(toRemove, indexNotRelevant),
          );
      if (nodeMap[nodeDomainFn(toRemove.target, indexNotRelevant)]!
          .incomingLinks
          .isEmpty) {
        sourceNodes.add(
          nodeMap[nodeDomainFn(toRemove.target, indexNotRelevant)]!,
        );
      }
    }
  }

  if (nodeMap.values.any(
    (node) => node.incomingLinks.isNotEmpty || node.outgoingLinks.isNotEmpty,
  )) {
    throw UnsupportedError(graphCycleErrorMsg);
  }

  return sortedNodes;
}

List<Node<N, L>> _cloneNodeList<N, L>(List<Node<N, L>> nodeList) =>
    nodeList.map(Node.clone).toList();

SankeyNode<N, L> _addLinkToSankeyNode<N, L>(
  SankeyNode<N, L> node,
  SankeyLink<N, L> link, {
  required bool isIncomingLink,
}) =>
    addLinkToNode(node, link, isIncomingLink: isIncomingLink)
        as SankeyNode<N, L>;

SankeyNode<N, L> _addLinkToAbsentSankeyNode<N, L>(
  SankeyLink<N, L> link, {
  required bool isIncomingLink,
}) =>
    addLinkToAbsentNode(link, isIncomingLink: isIncomingLink)
        as SankeyNode<N, L>;

/// A Sankey specific [Node] in the graph.
///
/// We store the Sankey specific column, and the depth and height given that a
/// [SankeyGraph] is directed and acyclic. These cannot be stored on a [Series].
class SankeyNode<N, L> extends Node<N, L> {
  SankeyNode(
    super.data, {
    List<SankeyLink<N, L>>? incomingLinks,
    List<SankeyLink<N, L>>? outgoingLinks,
    this.depth,
    this.height,
    this.column,
  }) : super(incomingLinks: incomingLinks, outgoingLinks: outgoingLinks);

  /// Number of links from node to nearest root.
  ///
  /// Calculated from graph structure.
  int? depth;

  /// Number of links on the longest path to a leaf node.
  ///
  /// Calculated from graph structure.
  int? height;

  /// The column this node occupies in the Sankey graph.
  ///
  /// Sankey column may or may not be equal to depth. It can be assigned to
  /// height or defined to align nodes left or right, depending on if they are
  /// roots or leaves.
  int? column;
}

/// A Sankey specific [graph.Link] in the graph.
///
/// We store the optional Sankey exclusive secondary link measure on the
/// [SankeyLink] for variable links since it cannot be stored on a [Series].
class SankeyLink<N, L> extends graph.Link<N, L> {
  SankeyLink(
    SankeyNode<N, L> super.source,
    SankeyNode<N, L> super.target,
    super.data, {
    this.secondaryLinkMeasure,
  });

  /// Measure of a link at the target node if the link has variable value.
  ///
  /// Standard series measure will be the source value.
  num? secondaryLinkMeasure;
}
