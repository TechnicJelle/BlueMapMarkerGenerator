import "dart:math";

import "package:flutter/material.dart";

import "math/vector.dart";
import "schemas/marker.dart";
import "schemas/marker_line.dart";
import "schemas/marker_poi.dart";
import "schemas/marker_set.dart";
import "lang.dart";

// ignore: must_be_immutable
class DialogAdd extends StatelessWidget {
  final MarkerSet markerSet;

  DialogAdd({super.key, required this.markerSet});

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
      title: const Text("Add Marker"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<Marker>(
              autofocus: true,
              decoration: const InputDecoration(labelText: "Type"),
              items: [
                DropdownMenuItem(
                  value: MarkerPOI(
                    position: Vector3.random(),
                    label: "Marker",
                  ),
                  child: const Text("POI"),
                ),
                DropdownMenuItem(
                  value: MarkerLine(
                    position: Vector3.random(),
                    label: "Line",
                    line: [
                      for (int i = 0; i < Random().nextInt(10); i++)
                        Vector3.random(),
                    ],
                  ),
                  child: const Text("Line"),
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
            TextFormField(
              controller: idController,
              autofocus: false,
              decoration: const InputDecoration(labelText: "ID"),
              textInputAction: TextInputAction.next,
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
                if (!idRegex.hasMatch(s)) {
                  return invalidCharacter;
                }
                return null;
              },
            ),
            TextFormField(
              autofocus: false,
              decoration: const InputDecoration(labelText: "Label"),
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.words,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? s) {
                if (s == null || s.trim().isEmpty) {
                  return cannotBeEmpty;
                }
                return null;
              },
              onChanged: (String s) => marker?.label = s,
              onFieldSubmitted: (_) => validateAndAdd(context),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          autofocus: false,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => validateAndAdd(context),
          child: const Text("Add"),
        ),
      ],
    );
  }
}
