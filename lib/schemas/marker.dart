import "package:flutter/material.dart";
import "package:vector_math/vector_math.dart";

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
}
