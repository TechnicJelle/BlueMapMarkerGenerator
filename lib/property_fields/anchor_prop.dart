import "dart:async";
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
  Size? imageSize;

  final imageAreaKey = GlobalKey();
  final viewportAreaKey = GlobalKey();

  final controller = TransformationController();

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
                imageSize = Size(img.width.toDouble(), img.height.toDouble());

                setState(() {
                  imageBytes = bytes;
                });

                Timer(const Duration(milliseconds: 100), () {
                  //Ideally this wouldn't be a timer, but oh well...
                  Size viewportSize = viewportAreaKey.currentContext!.size!;
                  Size halfViewportSize = viewportSize / 2.0;
                  Size scaledImageSize =
                      imageSize! * controller.value.getMaxScaleOnAxis();
                  Size halfScaledImageSize = scaledImageSize / 2.0;

                  setState(() {
                    controller.value.setTranslationRaw(
                      halfViewportSize.width - halfScaledImageSize.width,
                      halfViewportSize.height - halfScaledImageSize.height,
                      0,
                    );
                  });
                });
              },
              icon: const Icon(Icons.upload),
              label: const Text(anchorPickerUpload),
            )
          else
            Flexible(
              key: viewportAreaKey,
              child: InteractiveViewer(
                transformationController: controller,
                minScale: double.minPositive,
                maxScale: double.infinity,
                constrained: false,
                boundaryMargin: const EdgeInsets.all(1000),
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    Size imageAreaSize = imageAreaKey.currentContext!.size!;

                    Size factor = Size(
                      imageAreaSize.width / imageSize!.width,
                      imageAreaSize.height / imageSize!.height,
                    );

                    Offset tapPos = details.localPosition;

                    double x = tapPos.dx * factor.width;
                    double y = tapPos.dy * factor.height;

                    setState(() {
                      vector.x = x.truncate();
                      vector.y = y.truncate();
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
