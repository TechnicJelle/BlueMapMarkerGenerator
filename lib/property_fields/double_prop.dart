import "package:flutter/material.dart";

import "../input_fields/double_field.dart";
import "wrapper.dart";

class PropertyDouble extends StatelessWidget {
  final String label;
  final double number;
  final TextStyle? labelStyle;
  final void Function(double result) onFinished;

  const PropertyDouble({
    required this.label,
    required this.number,
    this.labelStyle,
    required this.onFinished,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PropertyWrapper(
      label: label,
      labelStyle: labelStyle,
      children: [
        FieldDouble(
          hint: label,
          number: number,
          onFinished: onFinished,
        ),
      ],
    );
  }
}
