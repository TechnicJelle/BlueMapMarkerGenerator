import "package:flutter/material.dart";

import "../custom_types/colour_type.dart";
import "../custom_types/vector_types.dart";
import "../lang.dart";
import "../property_fields/bool_prop.dart";
import "../property_fields/colour_prop.dart";
import "../property_fields/double_prop.dart";
import "../property_fields/string_prop.dart";
import "../property_fields/vector2d_prop.dart";
import "marker_base.dart";

//TODO: Check if first and last point are the same, and warn user if they are.

class MarkerShape extends Marker {
  static const typeShape = "shape";
  static const _jsonKeyShape = "shape";
  static const _jsonKeyShapeY = "shape-y";
  static const _jsonKeyDetail = "detail";
  static const _jsonKeyLink = "link";
  static const _jsonKeyNewTab = "new-tab";
  static const _jsonKeyDepthTest = "depth-test";
  static const _jsonKeyLineWidth = "line-width";
  static const _jsonKeyLineColor = "line-color";
  static const _jsonKeyFillColor = "fill-color";

  static const int _minShapePoints = 3;

  @override
  IconData get displayIcon => Icons.shape_line;

  @override
  String get tooltipType => tooltipTypeShape;

  List<Vector2d> shape;
  double shapeY;
  String? detail;
  String? link;
  bool? newTab;
  bool? depthTest;
  double? lineWidth;
  Colour? lineColor;
  Colour? fillColor;

  MarkerShape({
    super.sorting,
    super.listed,
    super.minDistance,
    super.maxDistance,
  })  : shape = [
          for (int i = 0; i < _minShapePoints; i++) Vector2d(0, 0),
        ],
        shapeY = 64,
        super(type: typeShape);

  @override
  MarkerShape.fromJson(super.json)
      : shape = (json[_jsonKeyShape] as List<dynamic>)
            .map((e) => Vector2d.fromJson(e))
            .toList(),
        shapeY = json[_jsonKeyShapeY],
        detail = json[_jsonKeyDetail],
        link = json[_jsonKeyLink],
        newTab = json[_jsonKeyNewTab],
        depthTest = json[_jsonKeyDepthTest],
        lineWidth = json[_jsonKeyLineWidth],
        lineColor = json[_jsonKeyLineColor] == null
            ? null
            : Colour.fromJson(json[_jsonKeyLineColor]),
        fillColor = json[_jsonKeyFillColor] == null
            ? null
            : Colour.fromJson(json[_jsonKeyFillColor]),
        super.fromJson();

  @override
  List<Widget> getProperties(StateSetter setState) => [
        PropertyString(
          label: propertyDetail,
          tooltip: tooltipDetailShape,
          //TODO: Wait for Blue to confirm if this is a bug or not:
          hint: typeShape, //ideally this would be `label`, but it's not working
          onFinished: (String? result) => detail = result,
        ),
        PropertyString(
          label: propertyLink,
          tooltip: tooltipLinkShape,
          hint: propertyNull,
          hintStyle: const TextStyle(fontStyle: FontStyle.italic),
          onFinished: (String? result) => link = result, //TODO: validate URL
        ),
        PropertyBool(
          label: propertyNewTab,
          tooltip: tooltipNewTab,
          state: newTab,
          onChanged: (bool? result) => setState(() => newTab = result ?? false),
        ),
        PropertyBool(
          label: propertyDepthTest,
          tooltip: tooltipDepthTest,
          state: depthTest,
          onChanged: (bool? result) =>
              setState(() => depthTest = result ?? false),
        ),
        PropertyDouble(
          label: propertyLineWidth,
          tooltip: tooltipLineWidth,
          hint: propertyNull,
          hintStyle: const TextStyle(fontStyle: FontStyle.italic),
          number: lineWidth,
          nullable: true,
          onFinished: (result) => lineWidth = result,
        ),
        PropertyColour(
          label: propertyLineColor,
          tooltip: tooltipLineColor,
          initialColour: lineColor?.toColor(),
          onChanged: (Color result) =>
              setState(() => lineColor = Colour.fromColor(result)),
        ),
        PropertyColour(
          label: propertyFillColor,
          tooltip: tooltipFillColor,
          initialColour: fillColor?.toColor(),
          onChanged: (Color result) =>
              setState(() => fillColor = Colour.fromColor(result)),
        ),
        PropertyDouble(
            label: propertyShapeY,
            tooltip: tooltipShapeY,
            hint: 0.0.toString(),
            number: shapeY,
            onFinished: (double? result) =>
                setState(() => shapeY = result ?? 0)),
        Row(
          children: [
            const Tooltip(
              message: tooltipLine,
              child: Text("$propertyLine:"),
            ),
            IconButton(
              onPressed: () => setState(() => shape.add(Vector2d(0, 0))),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        for (int i = 0; i < shape.length; i++)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PropertyVector2d(
                label: padToMax(i + 1, shape.length),
                tooltip: "",
                labelStyle: const TextStyle(fontFamily: monospaceFont),
                vector: shape[i],
              ),
              Visibility(
                visible: shape.length > _minShapePoints,
                child: Focus(
                  descendantsAreTraversable: false,
                  child: IconButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 8,
                    ),
                    constraints: const BoxConstraints(maxHeight: 32),
                    onPressed: () => setState(() => shape.removeAt(i)),
                    icon: const Icon(Icons.delete_forever),
                  ),
                ),
              ),
            ],
          ),
      ];

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        _jsonKeyShape: shape.map((e) => e.toJson()).toList(),
        _jsonKeyShapeY: shapeY,
        if (detail != null) _jsonKeyDetail: detail,
        if (link != null) _jsonKeyLink: link,
        if (newTab != null) _jsonKeyNewTab: newTab,
        if (depthTest != null) _jsonKeyDepthTest: depthTest,
        if (lineWidth != null) _jsonKeyLineWidth: lineWidth,
        if (lineColor != null) _jsonKeyLineColor: lineColor,
        if (fillColor != null) _jsonKeyFillColor: fillColor,
      };
}
