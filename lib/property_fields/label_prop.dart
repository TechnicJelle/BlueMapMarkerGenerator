import "package:flutter/material.dart";

import "../lang.dart";

class PropertyLabel extends StatelessWidget {
  final String label;
  final Function(String label) onChanged;

  final TextEditingController _controller;

  PropertyLabel({required this.label, required this.onChanged, super.key})
      : _controller = TextEditingController(text: label);

  @override
  Widget build(BuildContext context) {
    return Focus(
      canRequestFocus: false,
      onFocusChange: (bool gained) {
        if (gained) {
          _controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _controller.text.length,
          );
        }
      },
      child: IntrinsicWidth(
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration.collapsed(
            hintText: propertyLabel,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
          style: const TextStyle(fontWeight: FontWeight.bold),
          textCapitalization: TextCapitalization.words,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
