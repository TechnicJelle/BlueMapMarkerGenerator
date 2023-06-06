import "package:flutter/material.dart";

import "package:vector_math/vector_math.dart";

import "marker.dart";

class MarkerLine implements Marker {
  @override
  String type = "line";

  @override
  String label;

  @override
  Vector3 position;

  @override
  int? sorting;

  @override
  bool? listed;

  @override
  double? maxDistance;

  @override
  double? minDistance;

  //TODO: Implement other Line marker properties

  MarkerLine({
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
          child: Icon(Icons.line_axis),
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
