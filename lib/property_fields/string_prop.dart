import "package:flutter/material.dart";

import "wrapper.dart";

class PropertyString extends StatelessWidget {
  final String label;
  final String hint;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final void Function(String? result) onFinished;

  final TextEditingController _controller;

  PropertyString({
    required this.label,
    required this.hint,
    String? text,
    this.labelStyle,
    this.hintStyle,
    required this.onFinished,
    super.key,
  }) : _controller = TextEditingController(text: text);

  @override
  Widget build(BuildContext context) {
    return PropertyWrapper(
      label: label,
      labelStyle: labelStyle,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 50, maxHeight: 32),
          child: Focus(
            canRequestFocus: false,
            onFocusChange: (bool gained) {
              if (gained) {
                _controller.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: _controller.text.length,
                );
              } else {
                _controller.text = _controller.text.trim();
                if (_controller.text.isEmpty) {
                  onFinished(null);
                } else {
                  onFinished(_controller.text);
                }
              }
            },
            child: IntrinsicWidth(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: hintStyle,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
