import "package:flutter/material.dart";
import "package:web_unload_confirmation_popup/web_unload_confirmation_popup.dart";

import "lang.dart";
import "marker_types/marker_base.dart";

class MarkerSet {
  static const String _jsonKeyLabel = "label";
  static const String _jsonKeyToggleable = "toggleable";
  static const String _jsonKeyDefaultHidden = "default-hidden";
  static const String _jsonKeySorting = "sorting";
  static const String _jsonKeyMarkers = "markers";

  final ScrollController scrollController = ScrollController();
  late Offset mouse;

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
  }) {
    WebUnloadConfirmationPopup.activate();
  }

  MarkerSet.fromJson(Map<String, dynamic> json)
      : label = json[_jsonKeyLabel],
        toggleable = json[_jsonKeyToggleable],
        defaultHidden = json[_jsonKeyDefaultHidden],
        sorting = json[_jsonKeySorting],
        markers = {} {
    for (MapEntry<String, dynamic> entry in json[_jsonKeyMarkers].entries) {
      markers[entry.key] = Marker.newFromJson(entry.value);
    }
  }

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
            onTapDown: (details) => mouse = details.globalPosition,
            onLongPress: () => rightClickMenu(context, setState, entry.key),
            onSecondaryTapDown: (details) => mouse = details.globalPosition,
            onSecondaryTap: () => rightClickMenu(context, setState, entry.key),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(child: entry.value.toWidget(entry.key)),
                  // IconButton(
                  //   onPressed: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) => AlertDialog(
                  //         title: const Text(deleteMarker),
                  //         content: const Text(areYouSure),
                  //         actions: [
                  //           TextButton(
                  //             onPressed: () => Navigator.pop(context),
                  //             child: const Text(cancel),
                  //           ),
                  //           TextButton(
                  //             onPressed: () {
                  //               setState(() {
                  //                 markers.remove(entry.key);
                  //               });
                  //               Navigator.pop(context);
                  //             },
                  //             child: const Text(delete),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  //   icon: const Icon(Icons.delete_forever),
                  // )
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

  void rightClickMenu(BuildContext context, StateSetter setState, String key) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(mouse.dx, mouse.dy, double.infinity, 0),
      items: [
        PopupMenuItem(
          child: const Text(deleteMarker),
          onTap: () {
            setState(() {
              markers.remove(key);
            });
          },
        ),
      ],
    );
  }

  Map<String, dynamic> toJson() => {
        _jsonKeyLabel: label,
        _jsonKeyToggleable: toggleable,
        _jsonKeyDefaultHidden: defaultHidden,
        _jsonKeySorting: sorting,
        _jsonKeyMarkers:
            markers.map((key, value) => MapEntry(key, value.toJson())),
      };
}
