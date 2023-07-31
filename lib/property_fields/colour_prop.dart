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
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: pickerColor),
          onPressed: () async {
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
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text(confirm),
                      onPressed: () {
                        Navigator.of(context).pop(pickerColor);
                      },
                    ),
                  ],
                );
              },
            ).then((Color? value) => onChanged.call(value ?? pickerColor));
          },
          child: Text(
            initialColour == null ? setColour : changeColour,
            style: TextStyle(
              color: getTextColourForBackground(pickerColor),
            ),
          ),
        )
      ],
    );
  }
}

Color getTextColourForBackground(Color backgroundColour) {
  return ThemeData.estimateBrightnessForColor(backgroundColour) ==
          Brightness.dark
      ? Colors.white
      : Colors.black;
}
