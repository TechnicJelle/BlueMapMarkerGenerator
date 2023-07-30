import "package:flutter/material.dart";
import "package:web_unload_confirmation_popup/web_unload_confirmation_popup.dart";

import "../input_fields/double_field.dart";
import "../lang.dart";
import "../math/vector_types.dart";
import "../property_fields/label_prop.dart";
import "../property_fields/vector3_prop.dart";
import "../property_fields/wrapper.dart";
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
        maxDistance = json[_jsonKeyMaxDistance];

  Widget toWidget(String id, StateSetter setState) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        Icon(displayIcon),
        Wrap(
          direction: Axis.vertical,
          spacing: 12,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              children: [
                PropertyLabel(label: label, onChanged: (s) => label = s),
                Text(
                  "($id)",
                  style: const TextStyle(
                    fontFamily: monospaceFont,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            PropertyVector3(label: propertyPosition, vector: position),
            Text("$propertySorting: ${sorting ?? propertyNull}"),
            Text("$propertyListed: ${listed ?? propertyNull}"),
            Text("$propertyMinDistance: ${minDistance ?? propertyNull}"),
            Text("$propertyMaxDistance: ${maxDistance ?? propertyNull}"),
            const SizedBox(height: 1),
            ...getProperties(setState),
          ],
        )
      ],
    );
  }

  IconData get displayIcon;

  List<Widget> getProperties(StateSetter setState);

  Map<String, dynamic> toJson() => {
        _jsonKeyType: type,
        _jsonKeyPosition: position.toJson(),
        _jsonKeyLabel: label,
        if (sorting != null) _jsonKeySorting: sorting,
        if (listed != null) _jsonKeyListed: listed,
        if (minDistance != null) _jsonKeyMinDistance: minDistance,
        if (maxDistance != null) _jsonKeyMaxDistance: maxDistance,
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
