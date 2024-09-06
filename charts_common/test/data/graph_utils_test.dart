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

import 'package:charts_common/common.dart';
import 'package:test/test.dart';
import 'package:charts_common/src/data/graph_utils.dart';
import 'package:charts_common/src/data/graph.dart' as graph_structure
    show Link, Node, indexNotRelevant;

class MyNode {
  MyNode(this.domainId, this.measure);
  final String domainId;
  final num measure;
}

class MyLink {
  MyLink(this.domainId, this.sourceNode, this.targetNode, this.measure);
  final String domainId;
  final num measure;
  final MyNode sourceNode;
  final MyNode targetNode;
}

List<MyNode> myMockNodes = [
  MyNode('Node 1', 4),
  MyNode('Node 2', 5),
  MyNode('Node 3', 6),
];

List<MyLink> myMockLinks = [
  MyLink('Link A', myMockNodes[0], myMockNodes[1], 1),
  MyLink('Link B', myMockNodes[1], myMockNodes[2], 2),
];

void main() {
  group('actOnNodes', () {
    test('returns null for null functions', () {
      final nullMeasure = actOnNodeData<MyNode, MyLink, num>(null);

      expect(nullMeasure, null);
    });

    test('returns data for non-null functions', () {
      dynamic getDomain(node, _) => node.domainId;
      dynamic getMeasure(node, _) => node.measure;
      final domainFn = actOnNodeData<MyNode, MyLink, String>(getDomain)!;
      final measureFn = actOnNodeData<MyNode, MyLink, num>(getMeasure)!;

      expect(
        domainFn(
          graph_structure.Node(myMockNodes[0]),
          graph_structure.indexNotRelevant,
        ),
        getDomain(myMockNodes[0], graph_structure.indexNotRelevant),
      );
      expect(
        measureFn(
          graph_structure.Node(myMockNodes[0]),
          graph_structure.indexNotRelevant,
        ),
        getMeasure(myMockNodes[0], graph_structure.indexNotRelevant),
      );
    });
  });

  group('actOnLinks', () {
    test('returns null for null functions', () {
      final nullMeasure = actOnLinkData<MyNode, MyLink, num>(null);

      expect(nullMeasure, null);
    });

    test('returns data for non-null functions', () {
      dynamic getDomain(link, _) => link.domainId;
      dynamic getMeasure(link, _) => link.measure;
      final domainFn = actOnLinkData<MyNode, MyLink, String>(getDomain)!;
      final measureFn = actOnLinkData<MyNode, MyLink, num>(getMeasure)!;
      final firstLink = graph_structure.Link<MyNode, MyLink>(
        graph_structure.Node(myMockNodes[0]),
        graph_structure.Node(myMockNodes[1]),
        myMockLinks[0],
      );
      final secondLink = graph_structure.Link<MyNode, MyLink>(
        graph_structure.Node(myMockNodes[1]),
        graph_structure.Node(myMockNodes[2]),
        myMockLinks[1],
      );

      expect(
        domainFn(firstLink, graph_structure.indexNotRelevant),
        getDomain(myMockLinks[0], graph_structure.indexNotRelevant),
      );
      expect(
        measureFn(firstLink, graph_structure.indexNotRelevant),
        getMeasure(myMockLinks[0], graph_structure.indexNotRelevant),
      );
    });
  });

  group('addLinkToNode', () {
    test('adds link to corresponding list on node', () {
      final firstLink = graph_structure.Link(
        graph_structure.Node(myMockNodes[0]),
        graph_structure.Node(myMockNodes[1]),
        myMockLinks[0],
      );
      final secondLink = graph_structure.Link(
        graph_structure.Node(myMockNodes[1]),
        graph_structure.Node(myMockNodes[2]),
        myMockLinks[1],
      );
      var node = graph_structure.Node(myMockNodes[2]);
      node = addLinkToNode(node, firstLink, isIncomingLink: true);
      node = addLinkToNode(node, secondLink, isIncomingLink: false);

      expect(node.incomingLinks.length, 1);
      expect(node.outgoingLinks.length, 1);
      expect(node.incomingLinks[0], firstLink);
      expect(node.outgoingLinks[0], secondLink);
    });

    test('adds link to corresponding list on absent node', () {
      final firstLink = graph_structure.Link(
        graph_structure.Node(myMockNodes[0]),
        graph_structure.Node(myMockNodes[1]),
        myMockLinks[0],
      );
      final secondLink = graph_structure.Link(
        graph_structure.Node(myMockNodes[1]),
        graph_structure.Node(myMockNodes[2]),
        myMockLinks[1],
      );
      final nodeWithIncoming =
          addLinkToAbsentNode(secondLink, isIncomingLink: true);
      final nodeWithOutgoing =
          addLinkToAbsentNode(firstLink, isIncomingLink: false);

      expect(nodeWithIncoming.incomingLinks.length, 1);
      expect(nodeWithIncoming.outgoingLinks.length, 0);
      expect(nodeWithOutgoing.outgoingLinks.length, 1);
      expect(nodeWithOutgoing.incomingLinks.length, 0);
      expect(nodeWithIncoming.incomingLinks[0], secondLink);
      expect(nodeWithOutgoing.outgoingLinks[0], firstLink);
    });
  });

  group('accessorIfExists', () {
    test('calls function when not null', () {
      dynamic getDomain(node, _) => node.domainId;
      dynamic getMeasure(node, _) => node.measure;

      expect(
        accessorIfExists(
          getDomain,
          myMockNodes[0],
          graph_structure.indexNotRelevant,
        ),
        'Node 1',
      );
      expect(
        accessorIfExists(
          getMeasure,
          myMockNodes[0],
          graph_structure.indexNotRelevant,
        ),
        4,
      );
      expect(
        accessorIfExists(
          null,
          myMockNodes[1],
          graph_structure.indexNotRelevant,
        ),
        null,
      );
    });
  });
}
