import "package:flutter/material.dart";

import "../input_fields/vector3.dart";
import "../lang.dart";
import "../math/vector.dart";
import "marker_base.dart";

class MarkerLine extends Marker {
  static const typeLine = "line";
  static const _jsonKeyLine = "line";
  static const _jsonKeyDetail = "detail";
  static const _jsonKeyLink = "link";
  static const _jsonKeyNewTab = "new-tab";
  static const _jsonKeyDepthTest = "depth-test";
  static const _jsonKeyLineWidth = "line-width";
  static const _jsonKeyLineColor = "line-color";

  static const int minLinePoints = 2;

  @override
  IconData get displayIcon => Icons.line_axis;

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
  List<Widget> getProperties(StateSetter setState) => [
        Text("$propertyDetail: ${detail ?? propertyNull}"),
        Text("$propertyLink: ${link ?? propertyNull}"),
        Text("$propertyNewTab: ${newTab ?? propertyNull}"),
        Text("$propertyDepthTest: ${depthTest ?? propertyNull}"),
        Text("$propertyLineWidth: ${lineWidth ?? propertyNull}"),
        Text("$propertyLineColor: ${lineColor ?? propertyNull}"),
        const Text("$propertyLine:"),
        for (int i = 0; i < line.length; i++)
          Row(
            children: [
              Vector3Field(label: "$i", vector: line[i]),
              if (line.length > minLinePoints)
                Focus(
                  descendantsAreTraversable: false,
                  child: IconButton(
                    onPressed: () => setState(() => line.removeAt(i)),
                    icon: const Icon(Icons.delete_forever),
                  ),
                ),
            ],
          ),
        IconButton(
          onPressed: () => setState(() => line.add(Vector3(0, 0, 0))),
          icon: const Icon(Icons.add),
        ),
      ];

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        _jsonKeyLine: line.map((e) => e.toJson()).toList(),
        if (detail != null) _jsonKeyDetail: detail,
        if (link != null) _jsonKeyLink: link,
        if (newTab != null) _jsonKeyNewTab: newTab,
        if (depthTest != null) _jsonKeyDepthTest: depthTest,
        if (lineWidth != null) _jsonKeyLineWidth: lineWidth,
        if (lineColor != null) _jsonKeyLineColor: lineColor,
      };
}
