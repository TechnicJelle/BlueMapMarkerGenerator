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
        itemBuilder: (context, index) {
          MapEntry<String, Marker> entry = markers.entries.elementAt(index);
          return InkWell(
            onTap: () {
              print("MarkerSet.toWidget: ${entry.key} tapped");
            },
            onLongPress: () {
              print("MarkerSet.toWidget: ${entry.key} long pressed");
            },
            onSecondaryTap: () {
              print("MarkerSet.toWidget: ${entry.key} secondary tapped");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 4),
                  entry.value.toWidget(setState),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(indent: 4, height: 0);
        },
      ),
    );
  }
}
