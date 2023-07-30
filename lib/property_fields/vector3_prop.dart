import "package:flutter/material.dart";

import "../input_fields/double_field.dart";
import "../math/vector_types.dart";

class PropertyVector3 extends StatelessWidget {
  final String label;
  final Vector3 vector;
  final TextStyle? labelStyle;

  const PropertyVector3({
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
        FieldDouble(
          hint: "Y",
          number: vector.y,
          onFinished: (result) => vector.y = result,
        ),
        FieldDouble(
          hint: "Z",
          number: vector.z,
          onFinished: (result) => vector.z = result,
        ),
      ],
    );
  }
}
