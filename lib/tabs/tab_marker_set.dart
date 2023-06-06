import "package:flutter/material.dart";
import "package:vector_math/vector_math.dart" as vector_math;

import "../dialog_add.dart";
import "../schemas/marker.dart";
import "../schemas/marker_set.dart";
import "../schemas/marker_poi.dart";

class MarkerSetTab extends StatefulWidget {
  final String label;
  final MarkerSet markerSet;

  MarkerSetTab({required this.label, super.key})
      : markerSet = MarkerSet(
          label: label,
          markers: {
            "marker1": MarkerPOI(
              position: vector_math.Vector3(1, 2, 3),
              label: "Marker 1",
            ),
            "marker2": MarkerPOI(
              position: vector_math.Vector3(4, 5, 6),
              label: "Marker 2",
            ),
          },
        );

  @override
  State<MarkerSetTab> createState() => _MarkerSetTabState();
}

class _MarkerSetTabState extends State<MarkerSetTab> {
  MarkerSet get markerSet => widget.markerSet;

  void _addMarker() async {
    (String, Marker)? newMarker = await showDialog<(String, Marker)>(
      context: context,
      builder: (context) {
        return DialogAdd(markerSet: markerSet);
      },
    );
    if (newMarker == null) return; // Cancelled

    setState(() {
      markerSet.add(newMarker.$1, newMarker.$2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: markerSet.toWidget(setState),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMarker,
        tooltip: "Add Marker",
        child: const Icon(Icons.add),
      ),
    );
  }
}
