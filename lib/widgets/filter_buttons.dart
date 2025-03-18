import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  final VoidCallback filterPressed;
  final String label;
  final Widget? icon;
  final Color? color;

  const FilterButtons(
      {super.key,
      required this.filterPressed,
      required this.label,
      this.icon,
      this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: filterPressed,
        icon: icon,
        label: Text(label));
  }
}
