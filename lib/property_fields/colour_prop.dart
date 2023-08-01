import "dart:math";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_colorpicker/flutter_colorpicker.dart";

import "../lang.dart";
import "wrapper.dart";

class PropertyColour extends StatelessWidget {
  final String label;
  final Color? initialColour;
  final Color defaultColour;
  final void Function(Color colour) onChanged;

  const PropertyColour({
    required this.label,
    required this.initialColour,
    this.defaultColour = Colors.grey,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color pickerColor = initialColour ?? getRandomColour();
    return PropertyWrapper(
      label: label,
      children: [
        IndexedStack(
          index: initialColour == null ? 0 : 1,
          children: [
            OutlinedButton.icon(
              onPressed: () {
                pickerColor = getRandomColour();
                showPopup(context, pickerColor);
              },
              icon: Icon(
                Icons.color_lens,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              label: Text(
                propertyNull,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: pickerColor,
                shadowColor: pickerColor.opacity < 0.2
                    ? useWhiteForeground(pickerColor)
                        ? Colors.black
                        : Colors.white
                    : Colors.black,
              ),
              onPressed: () => showPopup(context, pickerColor),
              icon: Icon(
                Icons.color_lens,
                color: getTextColourForBackground(pickerColor),
              ),
              label: Text(
                myColorToHex(pickerColor),
                style: TextStyle(
                  color: getTextColourForBackground(pickerColor),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  void showPopup(BuildContext context, Color pickerColor) {
    showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        final controller = TextEditingController(
          text: colorToHex(pickerColor),
        );
        return AlertDialog(
          title: const Text(colourPickerTitle),
          scrollable: true,
          content: Column(
            children: [
              ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: (Color value) => pickerColor = value,
                displayThumbColor: true,
                paletteType: PaletteType.hsv,
                labelTypes: const [],
                hexInputController: controller,
              ),
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: "Hex",
                  prefixText: "#",
                ),
                autofocus: true,
                maxLength: 8,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                  FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
                ],
                onEditingComplete: () => Navigator.of(context).pop(pickerColor),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(cancel),
              onPressed: () => Navigator.of(context).pop(null),
            ),
            TextButton(
              child: const Text(confirm),
              onPressed: () => Navigator.of(context).pop(pickerColor),
            ),
          ],
        );
      },
    ).then((Color? value) {
      if (value == null) return; //Dialog was dismissed
      onChanged(value);
    });
  }
}

Color getTextColourForBackground(Color backgroundColour) {
  return ThemeData.estimateBrightnessForColor(backgroundColour) ==
          Brightness.dark
      ? Colors.white
      : Colors.black;
}

String myColorToHex(Color color) {
  return colorToHex(
    color,
    includeHashSign: true,
    enableAlpha: true,
    toUpperCase: true,
  );
}

Color getRandomColour() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
