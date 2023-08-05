import "package:flutter/material.dart";

import "../input_fields/int_field.dart";
import "wrapper.dart";

class PropertyInt extends StatelessWidget {
  final String label;
  final String tooltip;
  final String hint;
  final int? number;
  final bool nullable;
  final TextStyle? hintStyle;
  final void Function(int? result) onFinished;

  const PropertyInt({
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
        FieldInt(
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
