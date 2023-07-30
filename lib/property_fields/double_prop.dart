import "package:flutter/material.dart";

import "../input_fields/double_field.dart";
import "../math/vector_types.dart";

class PropertyDouble extends StatelessWidget {
  final String label;
  final Vector3 vector;
  final TextStyle? labelStyle;

  const PropertyDouble({
    required this.label,
    required this.vector,
    this.labelStyle,
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
        Text("$label:", style: labelStyle),
        FieldDouble(
          hint: "X",
          number: vector.x,
          onFinished: (result) => vector.x = result,
        ),
      ],
    );
  }
}
