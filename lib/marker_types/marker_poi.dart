import "package:flutter/material.dart";

import "../custom_types/vector_types.dart";
import "../lang.dart";
import "../property_fields/anchor_prop.dart";
import "../property_fields/classes_prop.dart";
import "../property_fields/string_prop.dart";
import "marker_base.dart";

class MarkerPOI extends Marker {
  static const typePOI = "poi";
  static const _jsonKeyDetail = "detail";
  static const _jsonKeyIcon = "icon";
  static const _jsonKeyAnchor = "anchor";
  static const _jsonKeyClasses = "classes";

  @override
  IconData get displayIcon => Icons.place;

  @override
  String get tooltipType => tooltipTypePOI;

  String? detail;
  String? icon;
  Vector2i? anchor;
  List<String> classes;

  MarkerPOI({
    super.sorting,
    super.listed,
    super.minDistance,
    super.maxDistance,
  })  : classes = [],
        super(type: typePOI);

  @override
  MarkerPOI.fromJson(super.json)
      : detail = json[_jsonKeyDetail],
        icon = json[_jsonKeyIcon],
        anchor = json[_jsonKeyAnchor] == null
            ? null
            : Vector2i.fromJson(json[_jsonKeyAnchor]),
        classes = json[_jsonKeyClasses] == null
            ? []
            : List<String>.from(json[_jsonKeyClasses]),
        super.fromJson();

  @override
  List<Widget> getProperties(StateSetter setState) => [
        PropertyString(
          label: propertyDetail,
          tooltip: tooltipDetailPOI,
          hint: label,
          onFinished: (String? result) => detail = result,
        ),
        PropertyString(
          label: propertyIcon,
          tooltip: tooltipIcon,
          hint: propertyAuto,
          hintStyle: const TextStyle(fontStyle: FontStyle.italic),
          onFinished: (String? result) => icon = result,
        ),
        PropertyAnchor(
          label: propertyAnchor,
          initialVector: anchor,
          onFinished: (Vector2i? result) => setState(() => anchor = result),
        ),
        PropertyClasses(classes: classes, setState: setState),
      ];

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        if (detail != null) _jsonKeyDetail: detail,
        if (icon != null) _jsonKeyIcon: icon,
        if (anchor != null) _jsonKeyAnchor: anchor,
        if (classes.isNotEmpty) _jsonKeyClasses: classes,
      };
}
