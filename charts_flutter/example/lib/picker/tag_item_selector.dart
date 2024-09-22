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
  void _toggleTag(TagDefinition tag) {
    setState(() {
      if (widget.selectedTags.value.contains(tag)) {
        widget.selectedTags.value.remove(tag);
      } else {
        widget.selectedTags.value.add(tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: widget.allTags
                  .map(
                    (tag) => Tooltip(
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
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: widget.selectedTags.value.isEmpty
                    ? const SizedBox.shrink()
                    : AnimatedItemGrid<T>(
                        items: widget.items(widget.selectedTags.value),
                        selectedTags: widget.selectedTags,
                        builder: widget.builder,
                      ),
              ),
            ),
          ),
        ],
      );
}
