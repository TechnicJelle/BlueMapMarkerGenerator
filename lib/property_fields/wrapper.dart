import "package:flutter/material.dart";

class PropertyWrapper extends StatelessWidget {
  final String label;
  final String tooltip;
  final TextStyle? labelStyle;
  final List<Widget> children;

  const PropertyWrapper({
    required this.label,
    required this.tooltip,
    this.labelStyle,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Tooltip(
          message: tooltip,
          child: Text("$label:", style: labelStyle),
        ),
        ...children,
      ],
    );
  }
}
