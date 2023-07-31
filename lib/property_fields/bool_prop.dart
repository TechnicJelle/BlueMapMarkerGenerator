import "package:flutter/material.dart";

import "wrapper.dart";

class PropertyBool extends StatelessWidget {
  final String label;
  final bool? state;
  final void Function(bool? result) onChanged;

  const PropertyBool({
    required this.label,
    required this.state,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PropertyWrapper(
      label: label,
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
