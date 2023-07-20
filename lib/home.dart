import "dart:convert";

import "package:file_picker/file_picker.dart";
import "package:file_saver/file_saver.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:web_unload_confirmation_popup/web_unload_confirmation_popup.dart";

import "schemas/marker_set.dart";
import "tabs/tab_add.dart";
import "tabs/tab_marker_set.dart";

const String _jsonKeyMarkerSets = "marker-sets";

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Map<String, MarkerSetTab> tabs = {};
  bool showTutorial = true;

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () =>
            _saveFile(),
        const SingleActivator(LogicalKeyboardKey.keyO, control: true): () =>
            _loadFile(),
      },
      child: DefaultTabController(
        length: tabs.length + 1,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("BlueMap Marker Generator"),
            actions: [
              IconButton(
                icon: const Icon(Icons.upload_file),
                tooltip: "Load Marker Set (Ctrl+O)",
                onPressed: () => _loadFile(),
              ),
              IconButton(
                icon: const Icon(Icons.save_alt),
                tooltip: "Save Marker Set (Ctrl+S)",
                onPressed: () async {
                  if (showTutorial) {
                    bool? show = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Usage Information"),
                        content: const UsageInformation(),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Don't show again this session"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Understood"),
                          ),
                        ],
                      ),
                    );
                    if (show == null) return;

                    showTutorial = show;
                  }

                  _saveFile();
                },
              ),
            ],
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                for (MapEntry<String, MarkerSetTab> entry in tabs.entries)
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(entry.value.markerSet.label),
                        Text(
                          entry.key,
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                const Tab(
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text("Add"),
                      SizedBox(width: 8),
                    ],
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              for (MarkerSetTab markerSetTab in tabs.values) markerSetTab,
              TabAdd(tabs, setState),
            ],
          ),
        ),
      ),
    );
  }

  void _saveFile() {
    JsonEncoder encoder = const JsonEncoder.withIndent("\t");
    Map<String, dynamic> json = {
      _jsonKeyMarkerSets: {
        for (MapEntry<String, MarkerSetTab> entry in tabs.entries)
          entry.key: entry.value.markerSet.toJson(),
      },
    };
    String string = encoder.convert(json);
    string = string.substring(1, string.length - 1).replaceAll("\n\t", "\n");

    FileSaver.instance.saveFile(
      name: "markers",
      ext: "conf",
      bytes: Uint8List.fromList(string.codeUnits),
    );

    WebUnloadConfirmationPopup.deactivate();
  }

  Future<void> _loadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["conf"],
    );

    if (result == null) return;

    Uint8List bytes = result.files.single.bytes!;
    String string = String.fromCharCodes(bytes);

    Map<String, dynamic> json = jsonDecode("{$string}");

    setState(() {
      for (MapEntry<String, dynamic> entry
          in json[_jsonKeyMarkerSets].entries) {
        MarkerSetTab tab = MarkerSetTab.withMarkerSet(
          markerSet: MarkerSet.fromJson(entry.value),
        );

        tabs[entry.key] = tab;
      }
    });
  }
}

class UsageInformation extends StatelessWidget {
  const UsageInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            "To use the marker file that will download after this dialog, place it somewhere sensible.\n"
            "Then, in your map's .conf file, replace this:"),
        SizedBox(
          width: double.infinity,
          child: Code(
            """
marker-sets: {
  # Please check out the wiki for information on how to configure this:
  # https://bluemap.bluecolored.de/wiki/customization/Markers.html
}""",
            copy: false,
          ),
        ),
        Text("With this:"),
        SizedBox(
          width: double.infinity,
          child: Code(
            "include required(file(\"path/to/markers.conf\"))",
            copy: true,
          ),
        ),
        Text(
            "Make sure to replace the path here with the correct path to the .conf file!"),
      ],
    );
  }
}

class Code extends StatelessWidget {
  final String text;
  final bool copy;

  const Code(this.text, {this.copy = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(
          color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5),
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: SelectableText(
              text,
              style: const TextStyle(fontFamily: "Inconsolata", fontSize: 19),
            ),
          ),
          if (copy)
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text));
              },
            )
        ],
      ),
    );
  }
}
