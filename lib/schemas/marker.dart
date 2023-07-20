import "package:flutter/material.dart";
import "package:web_unload_confirmation_popup/web_unload_confirmation_popup.dart";

import "../math/vector.dart";
import "marker_line.dart";
import "marker_poi.dart";

abstract class Marker {
  static const _jsonKeyType = "type";
  static const _jsonKeyPosition = "position";
  static const _jsonKeyLabel = "label";
  static const _jsonKeySorting = "sorting";
  static const _jsonKeyListed = "listed";
  static const _jsonKeyMinDistance = "min-distance";
  static const _jsonKeyMaxDistance = "max-distance";

  String type;
  Vector3 position;
  String label;
  int? sorting;
  bool? listed;
  double? minDistance;
  double? maxDistance;

  Marker({
    required this.type,
    required this.position,
    required this.label,
    this.sorting,
    this.listed,
    this.minDistance,
    this.maxDistance,
  }) {
    WebUnloadConfirmationPopup.activate();
  }

  Marker.fromJson(Map<String, dynamic> json)
      : type = json[_jsonKeyType],
        position = Vector3.fromJson(json[_jsonKeyPosition]),
        label = json[_jsonKeyLabel],
        sorting = json[_jsonKeySorting],
        listed = json[_jsonKeyListed],
        minDistance = json[_jsonKeyMinDistance],
        maxDistance = json[_jsonKeyMaxDistance] {
    WebUnloadConfirmationPopup.activate();
  }

  Widget toWidget(StateSetter setState);

  Map<String, dynamic> toJson() => {
        _jsonKeyType: type,
        _jsonKeyPosition: position.toJson(),
        _jsonKeyLabel: label,
        _jsonKeySorting: sorting,
        _jsonKeyListed: listed,
        _jsonKeyMinDistance: minDistance,
        _jsonKeyMaxDistance: maxDistance,
      };

  static Marker newFromJson(Map<String, dynamic> json) {
    switch (json[_jsonKeyType]) {
      case MarkerPOI.typePOI:
        return MarkerPOI.fromJson(json);
      case MarkerLine.typeLine:
        return MarkerLine.fromJson(json);
      default:
        throw Exception("Unknown marker type: ${json[_jsonKeyType]}");
    }
  }
}
