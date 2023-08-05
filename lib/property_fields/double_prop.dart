import "package:flutter/material.dart";

import "../input_fields/double_field.dart";
import "wrapper.dart";

class PropertyDouble extends StatelessWidget {
  final String label;
  final String tooltip;
  final String hint;
  final double? number;
  final bool nullable;
  final TextStyle? hintStyle;
  final void Function(double? result) onFinished;

  const PropertyDouble({
    required this.label,
    required this.tooltip,
    required this.hint,
    required this.number,
    this.nullable = false,
    this.hintStyle,
    required this.onFinished,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PropertyWrapper(
      label: label,
      tooltip: tooltip,
      children: [
        FieldDouble(
          hint: hint,
          hintStyle: hintStyle,
          number: number,
          nullable: nullable,
          onFinished: onFinished,
        ),
      ],
    );
  }
}
