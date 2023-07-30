import "package:flutter/material.dart";
import "package:flutter/services.dart";

class FieldInt extends StatelessWidget {
  final String hint;
  final int? number;
  final void Function(int? result) onFinished;

  final TextEditingController _controller;

  FieldInt({
    required this.hint,
    required this.number,
    required this.onFinished,
    super.key,
  }) : _controller = TextEditingController(text: number?.toString());

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 32),
      child: Focus(
        onFocusChange: (bool gained) {
          if (gained) {
            _controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: _controller.text.length,
            );
          } else {
            int? d = int.tryParse(_controller.text);
            if (d != null) {
              _controller.text = d.toString();
            }
            onFinished(d);
          }
        },
        canRequestFocus: false,
        child: TextFormField(
          controller: _controller,
          textAlign: TextAlign.right,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: false,
            signed: true,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[0-9\-]")),
          ],
          decoration: const InputDecoration(
            hintText: "0",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
            errorStyle: TextStyle(height: 0),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? s) {
            if (s == null || s.isEmpty) {
              return null;
            }
            if (int.tryParse(s) == null) {
              return "";
            }
            return null;
          },
        ),
      ),
    );
  }
}
