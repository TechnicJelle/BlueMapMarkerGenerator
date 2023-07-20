import "package:flutter/material.dart";

import "../math/vector.dart";
import "marker_base.dart";

class MarkerPOI extends Marker {
  static const typePOI = "poi";
  static const _jsonKeyDetail = "detail";
  static const _jsonKeyIcon = "icon";
  static const _jsonKeyAnchor = "anchor";

  String? detail;
  String? icon;
  Vector2? anchor;

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
            : Vector2.fromJson(json[_jsonKeyAnchor]),
        super.fromJson();

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
            Text("$position: ${position.x}, ${position.y}, ${position.z}"),
          ],
        )
      ],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        _jsonKeyDetail: detail,
        _jsonKeyIcon: icon,
        _jsonKeyAnchor: anchor,
      };
}
