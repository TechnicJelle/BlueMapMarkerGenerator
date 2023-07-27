import "package:flutter/material.dart";

import "../math/vector.dart";
import "number.dart";

class Vector3Field extends StatelessWidget {
  final String label;
  final Vector3 vector;
  final TextStyle? labelStyle;

  const Vector3Field({
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
        NumberField(
          label: "X",
          number: vector.x,
          onFinished: (result) => vector.x = result,
        ),
        NumberField(
          label: "Y",
          number: vector.y,
          onFinished: (result) => vector.y = result,
        ),
        NumberField(
          label: "Z",
          number: vector.z,
          onFinished: (result) => vector.z = result,
        ),
      ],
    );
  }
}
