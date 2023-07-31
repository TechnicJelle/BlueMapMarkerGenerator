import "package:flutter/material.dart";

import "../custom_types/vector_types.dart";
import "../lang.dart";
import "../property_fields/string_prop.dart";
import "marker_base.dart";

class MarkerPOI extends Marker {
  static const typePOI = "poi";
  static const _jsonKeyDetail = "detail";
  static const _jsonKeyIcon = "icon";
  static const _jsonKeyAnchor = "anchor";

  @override
  IconData get displayIcon => Icons.place;

  String? detail;
  String? icon;
  Vector2i? anchor;

  MarkerPOI({
    required super.position,
    required super.label,
    super.sorting,
    super.listed,
    super.minDistance,
    super.maxDistance,
  }) : super(type: typePOI);

  @override
  MarkerPOI.fromJson(super.json)
      : detail = json[_jsonKeyDetail],
        icon = json[_jsonKeyIcon],
        anchor = json[_jsonKeyAnchor] == null
            ? null
            : Vector2i.fromJson(json[_jsonKeyAnchor]),
        super.fromJson();

  @override
  List<Widget> getProperties(StateSetter setState) => [
        PropertyString(
          label: propertyDetail,
          hint: label,
          onFinished: (String? result) => detail = result,
        ),
        PropertyString(
          label: propertyIcon,
          hint: propertyNull,
          hintStyle: const TextStyle(fontStyle: FontStyle.italic),
          onFinished: (String? result) => icon = result,
        ),
        Text("$propertyAnchor: ${anchor ?? propertyNull}"),
      ];

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        if (detail != null) _jsonKeyDetail: detail,
        if (icon != null) _jsonKeyIcon: icon,
        if (anchor != null) _jsonKeyAnchor: anchor,
      };
}
