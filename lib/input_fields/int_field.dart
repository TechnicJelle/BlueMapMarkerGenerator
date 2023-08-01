import "package:flutter/material.dart";
import "package:flutter/services.dart";

class FieldInt extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextStyle? hintStyle;
  final int? number;
  final bool nullable;
  final void Function(int? result) onFinished;

  final TextAlign? textAlign;
  final bool autofocus;

  final TextEditingController _controller;

  FieldInt({
    this.label,
    this.hint,
    this.hintStyle,
    this.number,
    this.nullable = false,
    required this.onFinished,
    this.textAlign,
    this.autofocus = false,
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
              int? i = int.tryParse(_controller.text);
              if (i == null && !nullable) {
                i = 0;
              }
              if (i != null) {
                _controller.text = i.toString();
              }
              onFinished(i);
            }
          },
          child: TextFormField(
            controller: _controller,
            autofocus: autofocus,
            textAlign: textAlign ?? TextAlign.start,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: false,
              signed: true,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[0-9\-]")),
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
              if (s == null || int.tryParse(s) == null) {
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
