import "package:flutter/material.dart";
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
    Color pickerColor = initialColour ?? defaultColour;
    return PropertyWrapper(
      label: label,
      children: [
        IndexedStack(
          index: initialColour == null ? 0 : 1,
          children: [
            OutlinedButton(
              onPressed: () => showPopup(context, pickerColor),
              child: Text(
                setColour,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: pickerColor),
              onPressed: () => showPopup(context, pickerColor),
              child: Text(
                changeColour,
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

  Future<void> showPopup(BuildContext context, Color pickerColor) async {
    showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(colourPickerTitle),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color value) => pickerColor = value,
              hexInputBar: true,
              displayThumbColor: true,
              paletteType: PaletteType.hsv,
              labelTypes: const [
                ColorLabelType.rgb,
                ColorLabelType.hsv,
              ],
            ),
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
