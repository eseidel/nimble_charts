import 'package:example/picker/animated_item_grid.dart';
import 'package:example/picker/tagged_item.dart';
import 'package:flutter/material.dart';

class TagItemSelector<T extends TaggedItem> extends StatefulWidget {
  const TagItemSelector({
    required this.selectedTags,
    required this.items,
    required this.builder,
    required this.allTags,
    super.key,
  });

  final List<String> allTags;
  final ValueNotifier<List<String>> selectedTags;
  final List<T> Function(List<String> selectedTags) items;
  final Widget Function(BuildContext context, T item) builder;

  @override
  State<StatefulWidget> createState() => _TagItemSelectorState<T>();
}

class _TagItemSelectorState<T extends TaggedItem>
    extends State<TagItemSelector<T>> {
  void _toggleTag(String tag) {
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
              spacing: 8,
              runSpacing: 8,
              children: widget.allTags
                  .map(
                    (tag) => FilterChip(
                      label: Text(tag),
                      selected: widget.selectedTags.value.contains(tag),
                      onSelected: (_) => _toggleTag(tag),
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
