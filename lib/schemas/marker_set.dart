import "package:flutter/material.dart";

import "marker.dart";

class MarkerSet {
  ScrollController scrollController = ScrollController();

  String label;
  bool? toggleable;
  bool? defaultHidden;
  int? sorting;
  Map<String, Marker> markers;

  MarkerSet({
    required this.label,
    this.toggleable,
    this.defaultHidden,
    this.sorting,
    required this.markers,
  });

  void add(String id, Marker marker) {
    markers[id] = marker;
  }

  Widget toWidget(StateSetter setState) {
    return Scrollbar(
      thumbVisibility: true,
      controller: scrollController,
      child: ListView.separated(
        controller: scrollController,
        itemCount: markers.length,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        itemBuilder: (context, index) {
          return markers.values.elementAt(index).toWidget(setState);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
