import "package:flutter/material.dart";

import "../math/vector.dart";

abstract class Marker {
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
  });

  Widget toWidget(StateSetter setState);

  Map<String, dynamic> toJson() => {
        "type": type,
        "position": position.toJson(),
        "label": label,
        "sorting": sorting,
        "listed": listed,
        "min-distance": minDistance,
        "max-distance": maxDistance,
      };
}
