import "package:flutter/material.dart";
import "package:vector_math/vector_math.dart" as vector_math;

import "marker.dart";

class MarkerPOI implements Marker {
  @override
  String type = "poi";

  @override
  vector_math.Vector3 position;

  @override
  String label;

  @override
  int? sorting;

  @override
  bool? listed;

  @override
  double? minDistance;

  @override
  double? maxDistance;

  MarkerPOI({
    required this.position,
    required this.label,
    this.listed,
    this.minDistance,
    this.maxDistance,
    this.sorting,
  });

  @override
  Widget toWidget(StateSetter setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(4),
          child: Icon(Icons.place),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Position: ${position.x}, ${position.y}, ${position.z}"),
          ],
        )
      ],
    );
  }
}
