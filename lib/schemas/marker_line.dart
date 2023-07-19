import "package:flutter/material.dart";

import "../math/vector.dart";
import "marker.dart";

class MarkerLine extends Marker {
  static const typeLine = "line";
  static const _jsonKeyLine = "line";
  static const _jsonKeyDetail = "detail";
  static const _jsonKeyLink = "link";
  static const _jsonKeyNewTab = "new-tab";
  static const _jsonKeyDepthTest = "depth-test";
  static const _jsonKeyLineWidth = "line-width";
  static const _jsonKeyLineColor = "line-color";

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
  }) : super(type: typeLine);

  @override
  MarkerLine.fromJson(super.json)
      : line = (json[_jsonKeyLine] as List<dynamic>)
            .map((e) => Vector3.fromJson(e))
            .toList(),
        detail = json[_jsonKeyDetail],
        link = json[_jsonKeyLink],
        newTab = json[_jsonKeyNewTab],
        depthTest = json[_jsonKeyDepthTest],
        lineWidth = json[_jsonKeyLineWidth],
        lineColor = json[_jsonKeyLineColor] == null
            ? null
            : Color(json[_jsonKeyLineColor]),
        super.fromJson();

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
        _jsonKeyLine: line.map((e) => e.toJson()).toList(),
        _jsonKeyDetail: detail,
        _jsonKeyLink: link,
        _jsonKeyNewTab: newTab,
        _jsonKeyDepthTest: depthTest,
        _jsonKeyLineWidth: lineWidth,
        _jsonKeyLineColor: lineColor,
      };
}
