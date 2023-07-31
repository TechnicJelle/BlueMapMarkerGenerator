import "package:flutter/material.dart";

import "../lang.dart";
import "../math/vector_types.dart";
import "../property_fields/bool_prop.dart";
import "../property_fields/double_prop.dart";
import "../property_fields/string_prop.dart";
import "../property_fields/vector3d_prop.dart";
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

  List<Vector3d> line;
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
            .map((e) => Vector3d.fromJson(e))
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
        PropertyString(
          label: propertyDetail,
          hint: label,
          onFinished: (String? result) => detail = result,
        ),
        PropertyString(
          label: propertyLink,
          hint: propertyNull,
          hintStyle: const TextStyle(fontStyle: FontStyle.italic),
          onFinished: (String? result) => link = result, //TODO: validate URL
        ),
        PropertyBool(
          label: propertyNewTab,
          state: newTab,
          onChanged: (bool? result) => setState(() => newTab = result ?? false),
        ),
        PropertyBool(
          label: propertyDepthTest,
          state: depthTest,
          onChanged: (bool? result) =>
              setState(() => depthTest = result ?? false),
        ),
        PropertyDouble(
          label: propertyLineWidth,
          hint: propertyNull,
          number: lineWidth,
          nullable: true,
          onFinished: (result) => lineWidth = result,
        ),
        Text("$propertyLineColor: ${lineColor ?? propertyNull}"),
        const Text("$propertyLine:"),
        for (int i = 0; i < line.length; i++)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PropertyVector3d(
                label: padToMax(i + 1, line.length),
                labelStyle: const TextStyle(fontFamily: monospaceFont),
                vector: line[i],
              ),
              Visibility(
                visible: line.length > minLinePoints,
                child: Focus(
                  descendantsAreTraversable: false,
                  child: IconButton(
                    onPressed: () => setState(() => line.removeAt(i)),
                    icon: const Icon(Icons.delete_forever),
                  ),
                ),
              ),
            ],
          ),
        IconButton(
          onPressed: () => setState(() => line.add(Vector3d(0, 0, 0))),
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
