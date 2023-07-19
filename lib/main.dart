import "dart:convert";

import "package:file_picker/file_picker.dart";
import "package:file_saver/file_saver.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "schemas/marker_set.dart";
import "tabs/tab_add.dart";
import "tabs/tab_marker_set.dart";

const String _jsonKeyMarkerSets = "marker-sets";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, MarkerSetTab> tabs = {};

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () =>
            _saveFile(),
        const SingleActivator(LogicalKeyboardKey.keyO, control: true): () =>
            _loadFile(),
      },
      child: MaterialApp(
        title: "BlueMap Marker Generator",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          colorScheme: const ColorScheme.light(
            primary: Colors.blue,
            secondary: Colors.lightBlueAccent,
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.blue,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: false,
          colorScheme: const ColorScheme.dark(
            primary: Colors.blue,
            secondary: Colors.lightBlueAccent,
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.blue,
          ),
        ),
        // themeMode: ThemeMode.light,
        themeMode: ThemeMode.dark,
        home: DefaultTabController(
          length: tabs.length + 1,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("BlueMap Marker Generator"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.folder_open),
                  tooltip: "Load Marker Set (Ctrl+O)",
                  onPressed: () => _loadFile(),
                ),
                IconButton(
                  icon: const Icon(Icons.save_alt),
                  tooltip: "Save Marker Set (Ctrl+S)",
                  onPressed: () => _saveFile(),
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
