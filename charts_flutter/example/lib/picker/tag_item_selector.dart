import 'package:example/picker/animated_item_grid.dart';
import 'package:example/picker/tagged_item.dart';
import 'package:flutter/material.dart';

/// A tag definition.
typedef TagDefinition = ({
  String name,
  String display,
  IconData icon,
  String blurb,
});

class TagItemSelector<T extends TaggedItem> extends StatefulWidget {
  const TagItemSelector({
    required this.selectedTags,
    required this.items,
    required this.builder,
    required this.allTags,
    super.key,
  });

  final List<TagDefinition> allTags;
  final ValueNotifier<List<TagDefinition>> selectedTags;
  final List<T> Function(List<TagDefinition> selectedTags) items;
  final Widget Function(BuildContext context, T item) builder;

  @override
  State<StatefulWidget> createState() => _TagItemSelectorState<T>();
}

class _TagItemSelectorState<T extends TaggedItem>
    extends State<TagItemSelector<T>> {
  void _toggleTag(TagDefinition tag) => setState(() {
        if (widget.selectedTags.value.contains(tag)) {
          widget.selectedTags.value.remove(tag);
        } else {
          widget.selectedTags.value.add(tag);
        }
      });

  Widget _buildTagChips(bool isPhoneScreen) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.allTags
              .map(
                (tag) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Tooltip(
                    message: tag.blurb,
                    child: FilterChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(tag.icon),
                          const SizedBox(width: 8),
                          Text(tag.display),
                        ],
                      ),
                      selected: widget.selectedTags.value.contains(tag),
                      onSelected: (_) => _toggleTag(tag),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );

  Widget _buildItemGrid(bool isPhoneScreen) => widget.selectedTags.value.isEmpty
      ? const SizedBox.shrink()
      : AnimatedItemGrid<T>(
          items: widget.items(widget.selectedTags.value),
          selectedTags: widget.selectedTags,
          builder: (context, item) => SizedBox(
            width: isPhoneScreen ? double.infinity : null,
            child: widget.builder(context, item),
          ),
        );

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final isPhoneScreen = constraints.maxWidth < 600;

          return isPhoneScreen
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: _buildTagChips(isPhoneScreen),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildItemGrid(isPhoneScreen),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: _buildTagChips(isPhoneScreen),
                    ),
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: _buildItemGrid(isPhoneScreen),
                        ),
                      ),
                    ),
                  ],
                );
        },
      );
}
