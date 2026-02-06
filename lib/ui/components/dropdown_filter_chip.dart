import 'package:flutter/material.dart';

class DropdownFilterChip<T> extends StatefulWidget {
  final Widget label;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;

  const DropdownFilterChip({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
  });

  @override
  State<DropdownFilterChip<T>> createState() => _DropdownFilterChipState<T>();
}

class _DropdownFilterChipState<T> extends State<DropdownFilterChip<T>> {
  final MenuController _controller = MenuController();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: _controller,
      builder: (context, controller, child) {
        return FilterChip(
          label: widget.label,
          selected: true,
          onSelected: (_) {
            if (_controller.isOpen) {
              _controller.close();
            } else {
              _controller.open();
            }
          },
        );
      },
      menuChildren: [
        for (final item in widget.items)
          MenuItemButton(
            child: item.child,
            onPressed: () {
              widget.onChanged(item.value);
              _controller.close();
            },
          ),
      ],
    );
  }
}
