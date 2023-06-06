import "package:flutter/material.dart";
import "package:vector_math/vector_math.dart" as vector_math;

import "schemas/marker.dart";
import "schemas/marker_line.dart";
import "schemas/marker_poi.dart";
import "schemas/marker_set.dart";
import "lang.dart";

// ignore: must_be_immutable
class DialogAdd extends StatelessWidget {
  final MarkerSet markerSet;

  DialogAdd({super.key, required this.markerSet});

  String? id;
  Marker? marker;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Marker"),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<Marker>(
              autofocus: true,
              decoration: const InputDecoration(labelText: "Type"),
              items: [
                DropdownMenuItem(
                  value: MarkerPOI(
                    position: vector_math.Vector3.random(),
                    label: "Marker",
                  ),
                  child: const Text("POI"),
                ),
                DropdownMenuItem(
                  value: MarkerLine(
                    position: vector_math.Vector3.random(),
                    label: "Line",
                  ),
                  child: const Text("Line"),
                ),
              ],
              onChanged: (Marker? value) {
                marker = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "ID"),
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.none,
              onChanged: (String s) {
                id = s;
              },
              validator: (String? s) {
                if (s == null || s.isEmpty) {
                  return "ID cannot be empty";
                }
                if (markerSet.markers.containsKey(s)) {
                  return "ID already exists";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (id == null || marker == null) return;
            Navigator.of(context).pop((id, marker));
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
