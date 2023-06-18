import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "../dialog_add.dart";
import "../schemas/marker.dart";
import "../schemas/marker_set.dart";

class MarkerSetTab extends StatefulWidget {
  final String label;
  final MarkerSet markerSet;

  MarkerSetTab({required this.label, super.key})
      : markerSet = MarkerSet(
          label: label,
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
          const SingleActivator(LogicalKeyboardKey.keyN, control: true): () =>
              _addMarker(),
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
        tooltip: "Add Marker (Ctrl+N)",
        child: const Icon(Icons.add),
      ),
    );
  }
}
