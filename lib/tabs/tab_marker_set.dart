import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "../dialog_add.dart";
import "../marker_set.dart";
import "../marker_types/marker_base.dart";

class MarkerSetTab extends StatefulWidget {
  final MarkerSet markerSet;

  const MarkerSetTab.withMarkerSet({
    required this.markerSet,
    super.key,
  });

  MarkerSetTab.empty({required String markerSetLabel, super.key})
      : markerSet = MarkerSet(
          label: markerSetLabel,
          markers: {},
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
      body: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.keyN): () => _addMarker(),
        },
        child: Focus(
          autofocus: true,
          child: markerSet.markers.isEmpty
              ? const Center(child: Text("Press the + button to add a marker"))
              : markerSet.toWidget(setState),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMarker,
        tooltip: "Add Marker (N)",
        child: const Icon(Icons.add),
      ),
    );
  }
}
