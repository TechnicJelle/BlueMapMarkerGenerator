import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "../dialog_add_marker.dart";
import "../input_fields/int_field.dart";
import "../lang.dart";
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
        return DialogAddMarker(markerSet: markerSet);
      },
    );
    if (newMarker == null) return; // Cancelled

    setState(() {
      markerSet.add(newMarker.$1, newMarker.$2);
    });
  }

  @override
  Widget build(BuildContext context) {
    const double singleHeight = 48;
    const double totalHeight = singleHeight * 3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.secondary.withOpacity(0.7),
        toolbarHeight: totalHeight,
        centerTitle: true,
        title: SizedBox(
          width: 300,
          height: totalHeight,
          child: ListView(
            children: [
              // ListTile(
              //   leading: Text(propertyLabel,
              //       style: Theme.of(context).textTheme.titleMedium),
              //   titleAlignment: ListTileTitleAlignment.center,
              //   title: ConstrainedBox(
              //     constraints: const BoxConstraints(maxHeight: 32),
              //     child: TextField(
              //       decoration: const InputDecoration(
              //         border: OutlineInputBorder(),
              //         contentPadding: EdgeInsets.symmetric(horizontal: 8),
              //       ),
              //       onChanged: (String s) => setState(() {
              //         markerSet.label = s;
              //       }),
              //     ),
              //   ),
              // ),
              CheckboxListTile(
                title: const Text(propertyToggleable),
                value: markerSet.toggleable,
                tristate: true,
                onChanged: (bool? value) => setState(() {
                  markerSet.toggleable = value ?? false;
                }),
              ),
              CheckboxListTile(
                title: const Text(propertyDefaultHidden),
                value: markerSet.defaultHidden,
                tristate: true,
                onChanged: (bool? value) => setState(() {
                  markerSet.defaultHidden = value ?? false;
                }),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: singleHeight),
                child: ListTile(
                  leading: Text(propertySorting,
                      style: Theme.of(context).textTheme.titleMedium),
                  titleAlignment: ListTileTitleAlignment.center,
                  title: FieldInt(
                    hint: "0",
                    number: markerSet.sorting,
                    textAlign: TextAlign.right,
                    onFinished: (int? result) => setState(() {
                      markerSet.sorting = result;
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.slash, control: true): () =>
              _addMarker(),
        },
        child: Focus(
          autofocus: true,
          child: IndexedStack(
            index: markerSet.markers.isEmpty ? 0 : 1,
            children: [
              const Center(
                child: Text(markerSetTabHint),
              ),
              markerSet.toWidget(setState),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMarker,
        tooltip: markerSetTabFABTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }
}
