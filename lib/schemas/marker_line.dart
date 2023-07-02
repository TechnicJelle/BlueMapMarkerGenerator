import "package:flutter/material.dart";

import "../math/vector.dart";
import "marker.dart";

class MarkerLine extends Marker {
  List<Vector3> line;
  String? detail;
  String? link;
  bool? newTab;
  bool? depthTest;
  double? lineWidth;
  Color? lineColor;

  MarkerLine({
    required super.position,
    required super.label,
    required this.line,
    super.sorting,
    super.listed,
    super.minDistance,
    super.maxDistance,
  }) : super(type: "line");

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
            const Text("Line:"),
            for (final point in line)
              Text("  ${point.x}, ${point.y}, ${point.z}"),
          ],
        )
      ],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        "line": line.map((e) => e.toJson()).toList(),
        "detail": detail,
        "link": link,
        "new-tab": newTab,
        "depth-test": depthTest,
        "line-width": lineWidth,
        "line-color": lineColor,
      };
}
