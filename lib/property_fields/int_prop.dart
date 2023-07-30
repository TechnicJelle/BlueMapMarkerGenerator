import "package:flutter/material.dart";

import "../input_fields/int_field.dart";
import "wrapper.dart";

class PropertyInt extends StatelessWidget {
  final String label;
  final int? number;
  final TextStyle? labelStyle;
  final void Function(int? result) onFinished;

  const PropertyInt({
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
      children: [
        FieldInt(
          hint: label,
          number: number,
          onFinished: onFinished,
        ),
      ],
    );
  }
}
