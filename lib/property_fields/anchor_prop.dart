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
        return _Dialog(vector: vector);
      },
    ).then((Vector2i? value) {
      if (value == null) return; //Dialog was cancelled
      onFinished(value);
    });
  }
}

// ignore: must_be_immutable
class _Dialog extends StatefulWidget {
  Uint8List? imageBytes;
  Vector2i? imageSize;

  _Dialog({required this.vector});

  final Vector2i vector;

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  final imageAreaKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(anchorPickerTitle),
      scrollable: false,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.imageBytes == null)
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
                widget.imageSize = Vector2i(img.width, img.height);

                setState(() {
                  widget.imageBytes = bytes;
                });
              },
              icon: const Icon(Icons.upload),
              label: const Text(anchorPickerUpload),
            )
          else
            Flexible(
              child: InteractiveViewer(
                key: imageAreaKey,
                minScale: 1,
                maxScale: double.infinity,
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    Offset tapPos = details.localPosition;
                    Vector2i imageSize = widget.imageSize!;
                    Size widgetSize = imageAreaKey.currentContext!.size!;

                    double x = tapPos.dx * (imageSize.x / widgetSize.width);
                    double y = tapPos.dy * (imageSize.y / widgetSize.height);

                    Vector2i clickPos = Vector2i(x.toInt(), y.toInt());
                    setState(() {
                      widget.vector.x = clickPos.x;
                      widget.vector.y = clickPos.y;
                    });
                  },
                  child: Image.memory(
                    widget.imageBytes!,
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
                number: widget.vector.x,
                onFinished: (int? result) => widget.vector.x = result ?? 0,
              ),
              const SizedBox(width: 10),
              FieldInt(
                label: "Y",
                number: widget.vector.y,
                onFinished: (int? result) => widget.vector.y = result ?? 0,
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
          onPressed: () => Navigator.of(context).pop(widget.vector),
        ),
      ],
    );
  }
}
