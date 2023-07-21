import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "lang.dart";

class CodeBlock extends StatelessWidget {
  final String text;
  final bool copy;

  const CodeBlock(this.text, {this.copy = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(
          color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5),
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: SelectableText(
              text,
              style: const TextStyle(fontFamily: monospaceFont, fontSize: 19),
            ),
          ),
          if (copy)
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text));
              },
            )
        ],
      ),
    );
  }
}
