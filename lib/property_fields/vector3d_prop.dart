import "package:flutter/material.dart";

import "../custom_types/vector_types.dart";
import "../input_fields/double_field.dart";
import "wrapper.dart";

class PropertyVector3d extends StatelessWidget {
  final String label;
  final Vector3d vector;
  final TextStyle? labelStyle;

  const PropertyVector3d({
    required this.label,
    required this.vector,
    this.labelStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PropertyWrapper(
      label: label,
      labelStyle: labelStyle,
      children: [
        FieldDouble(
          label: "X",
          number: vector.x,
          onFinished: (double? result) => vector.x = result ?? 0,
        ),
        FieldDouble(
          label: "Y",
          number: vector.y,
          onFinished: (double? result) => vector.y = result ?? 0,
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
