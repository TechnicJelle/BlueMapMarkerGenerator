import "package:flutter/material.dart";
import "package:web_unload_confirmation_popup/web_unload_confirmation_popup.dart";

import "../custom_types/vector_types.dart";
import "../lang.dart";
import "../property_fields/bool_prop.dart";
import "../property_fields/double_prop.dart";
import "../property_fields/int_prop.dart";
import "../property_fields/label_prop.dart";
import "../property_fields/vector3d_prop.dart";
import "marker_line.dart";
import "marker_poi.dart";
import "marker_shape.dart";

abstract class Marker {
  static const _jsonKeyType = "type";
  static const _jsonKeyPosition = "position";
  static const _jsonKeyLabel = "label";
  static const _jsonKeySorting = "sorting";
  static const _jsonKeyListed = "listed";
  static const _jsonKeyMinDistance = "min-distance";
  static const _jsonKeyMaxDistance = "max-distance";

  String type;
  Vector3d position;
  String label;
  int? sorting;
  bool? listed;
  double? minDistance;
  double? maxDistance;

  Marker({
    required this.type,
    this.label = ">!!This should never appear!!<",
    this.sorting,
    this.listed,
    this.minDistance,
    this.maxDistance,
  }) : position = Vector3d(0, 0, 0) {
    WebUnloadConfirmationPopup.activate();
  }

  Marker.fromJson(Map<String, dynamic> json)
      : type = json[_jsonKeyType],
        position = Vector3d.fromJson(json[_jsonKeyPosition]),
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
        Tooltip(
          message: tooltipType,
          child: Icon(displayIcon),
        ),
        Wrap(
          direction: Axis.vertical,
          spacing: 12,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              children: [
                Tooltip(
                  message: tooltipLabelMarker,
                  child: PropertyLabel(
                    label: label,
                    onChanged: (s) => label = s,
                    onFinished: (s) => setState(() => label = s),
                  ),
                ),
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
            PropertyVector3d(
              label: propertyPosition,
              tooltip: tooltipPosition,
              vector: position,
            ),
            PropertyInt(
              label: propertySorting,
              tooltip: tooltipSortingMarker,
              hint: propertyAuto,
              hintStyle: const TextStyle(fontStyle: FontStyle.italic),
              number: sorting,
              nullable: true,
              onFinished: (result) => sorting = result,
            ),
            PropertyBool(
              label: propertyListed,
              tooltip: tooltipListed,
              state: listed,
              onChanged: (bool? result) => setState(
                () => listed = result ?? false,
              ),
            ),
            PropertyDouble(
              label: propertyMinDistance,
              tooltip: tooltipDistance,
              hint: propertyAuto,
              hintStyle: const TextStyle(fontStyle: FontStyle.italic),
              number: minDistance,
              nullable: true,
              onFinished: (result) => minDistance = result,
            ),
            PropertyDouble(
              label: propertyMaxDistance,
              tooltip: tooltipDistance,
              hint: propertyAuto,
              hintStyle: const TextStyle(fontStyle: FontStyle.italic),
              number: maxDistance,
              nullable: true,
              onFinished: (result) => maxDistance = result,
            ),
            const SizedBox(height: 1),
            ...getProperties(setState),
          ],
        )
      ],
    );
  }

  IconData get displayIcon;

  String get tooltipType;

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
      case MarkerShape.typeShape:
        return MarkerShape.fromJson(json);
      default:
        throw Exception("Unknown marker type: ${json[_jsonKeyType]}");
    }
  }
}
