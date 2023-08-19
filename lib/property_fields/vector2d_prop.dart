import "package:flutter/material.dart";

import "../custom_types/vector_types.dart";
import "../input_fields/double_field.dart";
import "wrapper.dart";

class PropertyVector2d extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final String tooltip;
  final Vector2d vector;

  const PropertyVector2d({
    required this.label,
    this.labelStyle,
    required this.tooltip,
    required this.vector,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PropertyWrapper(
      label: label,
      labelStyle: labelStyle,
      tooltip: tooltip,
      children: [
        FieldDouble(
          label: "X",
          number: vector.x,
          onFinished: (double? result) => vector.x = result ?? 0,
        ),
        FieldDouble(
          label: "Z",
          number: vector.z,
          onFinished: (double? result) => vector.z = result ?? 0,
        ),
      ],
    );
  }
}
