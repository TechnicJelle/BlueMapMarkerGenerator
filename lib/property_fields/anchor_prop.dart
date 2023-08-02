import "dart:io";
import "dart:ui" as ui show Image;

import "package:file_picker/file_picker.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import "../custom_types/vector_types.dart";
import "../input_fields/int_field.dart";
import "../lang.dart";
import "wrapper.dart";

class PropertyAnchor extends StatelessWidget {
  final String label;
  final Vector2i? initialVector;
  final void Function(Vector2i? result) onFinished;

  const PropertyAnchor({
    required this.label,
    required this.initialVector,
    required this.onFinished,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color? textColour = Theme.of(context).textTheme.bodyLarge?.color;
    return PropertyWrapper(
      label: label,
      children: [
        IndexedStack(
          index: initialVector == null ? 0 : 1,
          children: [
            OutlinedButton.icon(
              onPressed: () => showPopup(context),
              icon: Icon(
                Icons.highlight_alt,
                color: textColour,
              ),
              label: Text(
                propertyNull,
                style: TextStyle(
                  color: textColour,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => showPopup(context),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
              icon: Icon(
                Icons.highlight_alt,
                color: textColour,
              ),
              label: Text(
                "X: ${initialVector?.x}   Y: ${initialVector?.y}",
                style: TextStyle(
                  color: textColour,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  void showPopup(BuildContext context) {
    showDialog<Vector2i>(
      context: context,
      builder: (BuildContext context) {
        Vector2i vector = initialVector ?? Vector2i(0, 0);
        return _Dialog(initialVector: vector);
      },
    ).then((Vector2i? value) {
      if (value == null) return; //Dialog was cancelled
      onFinished(value);
    });
  }
}

class _Dialog extends StatefulWidget {
  final Vector2i initialVector;

  const _Dialog({required this.initialVector});

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  late Vector2i vector;
  Uint8List? imageBytes;
  Vector2i? imageSize;
  final imageAreaKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    vector = widget.initialVector;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(anchorPickerTitle),
      scrollable: false,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imageBytes == null)
            ElevatedButton.icon(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );

                if (result == null) return; // Dialog was canceled

                Uint8List bytes;
                if (kIsWeb) {
                  bytes = result.files.single.bytes!;
                } else {
                  File file = File(result.files.single.path!);
                  bytes = await file.readAsBytes();
                }

                ui.Image img = await decodeImageFromList(bytes);
                imageSize = Vector2i(img.width, img.height);

                setState(() {
                  imageBytes = bytes;
                });
              },
              icon: const Icon(Icons.upload),
              label: const Text(anchorPickerUpload),
            )
          else
            Flexible(
              child: InteractiveViewer(
                minScale: 1,
                maxScale: double.infinity,
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    Offset tapPos = details.localPosition;
                    Size widgetSize = imageAreaKey.currentContext!.size!;

                    double x = tapPos.dx * (imageSize!.x / widgetSize.width);
                    double y = tapPos.dy * (imageSize!.y / widgetSize.height);

                    Vector2i clickPos = Vector2i(x.toInt(), y.toInt());
                    setState(() {
                      vector.x = clickPos.x;
                      vector.y = clickPos.y;
                    });
                  },
                  child: Image.memory(
                    key: imageAreaKey,
                    imageBytes!,
                    filterQuality: FilterQuality.none,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FieldInt(
                label: "X",
                number: vector.x,
                onFinished: (int? result) => vector.x = result ?? 0,
              ),
              const SizedBox(width: 10),
              FieldInt(
                label: "Y",
                number: vector.y,
                onFinished: (int? result) => vector.y = result ?? 0,
              ),
            ],
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
          onPressed: () => Navigator.of(context).pop(vector),
        ),
      ],
    );
  }
}
