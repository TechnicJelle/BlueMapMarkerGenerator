import "package:flutter/material.dart";

import "../input_fields/double_field.dart";
import "wrapper.dart";

class PropertyDouble extends StatelessWidget {
  final String label;
  final String hint;
  final double? number;
  final bool nullable;
  final TextStyle? labelStyle;
  final void Function(double? result) onFinished;

  const PropertyDouble({
    required this.label,
    required this.hint,
    required this.number,
    this.nullable = false,
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
          hint: hint,
          number: number,
          nullable: nullable,
          onFinished: onFinished,
        ),
      ],
    );
  }
}
