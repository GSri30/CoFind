import 'package:flutter/material.dart';

class ResourceFilterChip extends StatelessWidget {
  final Map<String, bool> resourceFilter;
  ResourceFilterChip(this.resourceFilter);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: resourceFilter.entries.map((c) {
        return SingleFilterChip(c.key, resourceFilter);
      }).toList(),
    );
  }
}

class SingleFilterChip extends StatefulWidget {
  final String resource;
  final Map<String, bool> resourceFilter;
  SingleFilterChip(this.resource, this.resourceFilter);

  @override
  _SingleFilterChipState createState() => _SingleFilterChipState();
}

class _SingleFilterChipState extends State<SingleFilterChip> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
        selected: widget.resourceFilter[widget.resource],
        label: Text(widget.resource),
        selectedColor: Colors.lightGreen,
        onSelected: (bool selected) {
          setState(() {
            widget.resourceFilter[widget.resource] =
                !widget.resourceFilter[widget.resource];
          });
        });
  }
}
