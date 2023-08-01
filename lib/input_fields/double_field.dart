import "package:flutter/material.dart";
import "package:flutter/services.dart";

class FieldDouble extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextStyle? hintStyle;
  final double? number;
  final bool nullable;
  final void Function(double? result) onFinished;

  final TextEditingController _controller;

  FieldDouble({
    this.label,
    this.hint,
    this.hintStyle,
    this.number,
    this.nullable = false,
    required this.onFinished,
    super.key,
  })  : assert(nullable || number != null),
        _controller = TextEditingController(text: number?.toString());

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 50, maxHeight: 32),
      child: IntrinsicWidth(
        child: Focus(
          canRequestFocus: false,
          onFocusChange: (bool gained) {
            if (gained) {
              _controller.selection = TextSelection(
                baseOffset: 0,
                extentOffset: _controller.text.length,
              );
            } else {
              double? d = double.tryParse(_controller.text);
              if (d == null && !nullable) {
                d = 0;
              }
              if (d != null) {
                _controller.text = d.toString();
              }
              onFinished(d);
            }
          },
          child: TextFormField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[0-9\-.eE]")),
            ],
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              hintStyle: hintStyle,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              errorStyle: const TextStyle(height: 0),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? s) {
              if (nullable && (s == null || s.trim().isEmpty)) {
                return null;
              }
              if (s == null || double.tryParse(s) == null) {
                return "";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
