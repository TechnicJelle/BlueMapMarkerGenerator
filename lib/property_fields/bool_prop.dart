import "package:flutter/material.dart";

import "wrapper.dart";

class PropertyBool extends StatelessWidget {
  final String label;
  final String tooltip;
  final bool? state;
  final void Function(bool? result) onChanged;

  const PropertyBool({
    required this.label,
    required this.tooltip,
    required this.state,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PropertyWrapper(
      label: label,
      tooltip: tooltip,
      children: [
        Checkbox(
          fillColor:
              state == null ? MaterialStateProperty.all(Colors.grey) : null,
          value: state,
          tristate: true,
          onChanged: onChanged,
        )
      ],
    );
  }
}
