import "package:flutter/material.dart";

import "../input_fields/int_field.dart";
import "wrapper.dart";

class PropertyInt extends StatelessWidget {
  final String label;
  final String hint;
  final int? number;
  final TextStyle? labelStyle;
  final void Function(int? result) onFinished;

  const PropertyInt({
    required this.label,
    required this.hint,
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
        FieldInt(
          hint: hint,
          number: number,
          onFinished: onFinished,
        ),
      ],
    );
  }
}
