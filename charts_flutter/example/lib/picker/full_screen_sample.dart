import 'package:example/picker/model.dart';
import 'package:flutter/material.dart';

class FullScreenSample extends StatelessWidget {
  const FullScreenSample({required this.item, super.key});
  final ChartSampleDefinition item;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(item.title),
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.subtitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: item.tags
                          .map(
                            (tag) => Chip(
                              label: Text(tag.display),
                              avatar: Icon(tag.icon, size: 18),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: item.build(context, item),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
