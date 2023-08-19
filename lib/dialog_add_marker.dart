import "package:flutter/material.dart";

import "lang.dart";
import "marker_set.dart";
import "marker_types/marker_base.dart";
import "marker_types/marker_line.dart";
import "marker_types/marker_poi.dart";
import "marker_types/marker_shape.dart";

// ignore: must_be_immutable
class DialogAddMarker extends StatelessWidget {
  final MarkerSet markerSet;

  DialogAddMarker({super.key, required this.markerSet});

  final formKey = GlobalKey<FormState>();

  final idController = TextEditingController();

  Marker? marker;

  void validateAndAdd(context) {
    final formState = formKey.currentState;
    if (formState != null && formState.validate()) {
      Navigator.of(context).pop((idController.text, marker));
      marker = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(addMarkerTitle),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<Marker>(
              autofocus: true,
              decoration: const InputDecoration(labelText: addMarkerMarkerType),
              items: [
                _MarkerMenuItem(
                  tooltip: tooltipTypePOI,
                  value: MarkerPOI(),
                  child: const Text(addMarkerTypePOI),
                ),
                _MarkerMenuItem(
                  tooltip: tooltipTypeLine,
                  value: MarkerLine(),
                  child: const Text(addMarkerTypeLine),
                ),
                _MarkerMenuItem(
                  tooltip: tooltipTypeShape,
                  value: MarkerShape(),
                  child: const Text(addMarkerTypeShape),
                ),
              ],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (Marker? m) {
                if (m == null) {
                  return cannotBeEmpty;
                }
                return null;
              },
              onChanged: (Marker? m) => marker = m,
            ),
            Tooltip(
              message: tooltipLabelMarker,
              child: TextFormField(
                autofocus: false,
                decoration: const InputDecoration(labelText: propertyLabel),
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? s) {
                  if (s == null || s.trim().isEmpty) {
                    return cannotBeEmpty;
                  }
                  return null;
                },
                onChanged: (String s) {
                  marker?.label = s;
                  idController.text = s
                      .toLowerCase()
                      .replaceAll(regexLabelToID, " ")
                      .trim()
                      .replaceAll(regexMultipleSpaces, "-");
                },
              ),
            ),
            Focus(
              canRequestFocus: false,
              onFocusChange: (bool gained) {
                if (gained) {
                  idController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: idController.text.length,
                  );
                }
              },
              child: TextFormField(
                controller: idController,
                autofocus: false,
                decoration: const InputDecoration(labelText: propertyID),
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? s) {
                  if (s == null || s.isEmpty) {
                    return cannotBeEmpty;
                  }
                  if (markerSet.markers.containsKey(s)) {
                    //Prevent this validator from activating when just added:
                    if (marker == null) return null;
                    return noDuplicateIDs;
                  }
                  if (!regexIDValidation.hasMatch(s)) {
                    return invalidCharacter;
                  }
                  return null;
                },
                onFieldSubmitted: (_) => validateAndAdd(context),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          autofocus: false,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(cancel),
        ),
        TextButton(
          onPressed: () => validateAndAdd(context),
          child: const Text(add),
        ),
      ],
    );
  }
}

class _MarkerMenuItem<T extends Marker> extends DropdownMenuItem<T> {
  final String tooltip;

  const _MarkerMenuItem({
    super.key,
    required this.tooltip,
    required super.value,
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: super.build(context),
    );
  }
}
