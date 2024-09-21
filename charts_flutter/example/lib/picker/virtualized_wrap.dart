import 'package:flutter/material.dart';

class VirtualizedWrap extends StatefulWidget {
  const VirtualizedWrap({
    required this.children,
    required this.itemSize,
    super.key,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
  });
  final List<Widget> children;
  final Size itemSize;
  final double spacing;
  final double runSpacing;

  @override
  State<VirtualizedWrap> createState() => _VirtualizedWrapState();
}

class _VirtualizedWrapState extends State<VirtualizedWrap> {
  final ScrollController _scrollController = ScrollController();
  late List<_ItemPosition> _itemPositions;
  Size? _lastSize;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _itemPositions = [];
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.of(context).size;
    if (_lastSize != size) {
      _lastSize = size;
      _calculateItemPositions();
    }
  }

  void _calculateItemPositions() {
    if (!mounted) return;

    final size = MediaQuery.of(context).size;
    _itemPositions = [];
    var x = 0.0;
    var y = 0.0;

    for (var i = 0; i < widget.children.length; i++) {
      if (x + widget.itemSize.width > size.width) {
        x = 0.0;
        y += widget.itemSize.height + widget.runSpacing;
      }

      _itemPositions.add(_ItemPosition(i, Offset(x, y)));
      x += widget.itemSize.width + widget.spacing;
    }
    setState(() {});
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final size = MediaQuery.of(context).size;
          if (_lastSize != size) {
            _lastSize = size;
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _calculateItemPositions());
          }

          final visibleRect = Rect.fromLTWH(
            0,
            _scrollOffset,
            constraints.maxWidth,
            constraints.maxHeight,
          );

          final visibleItems = _itemPositions.where((item) {
            final itemRect = Rect.fromLTWH(
              item.offset.dx,
              item.offset.dy,
              widget.itemSize.width,
              widget.itemSize.height,
            );
            return visibleRect.overlaps(itemRect);
          }).toList();

          return SingleChildScrollView(
            controller: _scrollController,
            child: SizedBox(
              height: _itemPositions.isNotEmpty
                  ? _itemPositions.last.offset.dy + widget.itemSize.height + widget.runSpacing
                  : 0,
              child: Stack(
                children: visibleItems
                    .map(
                      (item) => Positioned(
                        left: item.offset.dx,
                        top: item.offset.dy,
                        child: SizedBox(
                          width: widget.itemSize.width,
                          height: widget.itemSize.height,
                          child: widget.children[item.index],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _ItemPosition {
  _ItemPosition(this.index, this.offset);
  final int index;
  final Offset offset;
}
