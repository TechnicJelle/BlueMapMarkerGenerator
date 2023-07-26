import "package:flutter/material.dart";
import "package:flutter/services.dart";

class NumberField extends StatelessWidget {
  final String label;
  final double number;
  final Function(double result) onFinished;

  final TextEditingController _controller;

  NumberField({
    required this.label,
    required this.number,
    required this.onFinished,
    super.key,
  }) : _controller = TextEditingController(text: number.toString());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ConstrainedBox(
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
                double d = double.tryParse(_controller.text) ?? 0;
                _controller.text = d.toString();
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
                FilteringTextInputFormatter.allow(RegExp(r"[0-9\-.]")),
              ],
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                errorStyle: const TextStyle(height: 0),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? s) {
                if (s == null ||
                    s.trim().isEmpty ||
                    double.tryParse(s) == null) {
                  return "";
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}
