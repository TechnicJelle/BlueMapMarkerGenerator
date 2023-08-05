import "package:flutter/material.dart";

import "../lang.dart";
import "string_prop.dart";

class PropertyClasses extends StatelessWidget {
  final StateSetter setState;

  const PropertyClasses({
    required this.classes,
    required this.setState,
    super.key,
  });

  final List<String> classes;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 12,
      children: [
        Row(
          children: [
            const Text("$propertyClasses:"),
            IconButton(
              onPressed: () => setState(() => classes.add("")),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        for (int i = 0; i < classes.length; i++)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PropertyString(
                label: padToMax(i + 1, classes.length),
                labelStyle: const TextStyle(fontFamily: monospaceFont),
                hint: " " * 20,
                text: classes[i],
                onFinished: (String? result) {
                  if (result == null) return;
                  setState(() => classes[i] = result);
                },
              ),
              IconButton(
                focusNode: FocusNode(skipTraversal: true),
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 8,
                ),
                constraints: const BoxConstraints(maxHeight: 32),
                onPressed: () => setState(() => classes.removeAt(i)),
                icon: const Icon(Icons.delete_forever),
              ),
            ],
          ),
      ],
    );
  }
}
