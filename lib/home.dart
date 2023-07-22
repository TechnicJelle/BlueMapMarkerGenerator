import "dart:convert";
import "dart:io";

import "package:file_picker/file_picker.dart";
import "package:file_saver/file_saver.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:web_unload_confirmation_popup/web_unload_confirmation_popup.dart";

import "code_block.dart";
import "lang.dart";
import "marker_set.dart";
import "tabs/tab_add.dart";
import "tabs/tab_marker_set.dart";

const String _jsonKeyMarkerSets = "marker-sets";
const String _fileName = "markers";
const String _fileExtension = "conf";

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
            title: const Text(appName),
            actions: [
              IconButton(
                icon: const Icon(Icons.upload_file),
                tooltip: loadButtonTooltip,
                onPressed: () => _loadFile(),
              ),
              IconButton(
                icon: const Icon(Icons.save_alt),
                tooltip: saveButtonTooltip,
                onPressed: () async {
                  if (showTutorial) {
                    bool? show = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(usageInformationTitle),
                        content: Theme(
                          data: Theme.of(context).copyWith(
                            scrollbarTheme: ScrollbarThemeData(
                              thickness: MaterialStateProperty.all(2),
                              thumbVisibility: MaterialStateProperty.all(true),
                              interactive: false,
                            ),
                          ),
                          child: SingleChildScrollView(
                            controller: PrimaryScrollController.of(context),
                            child: const UsageInformation(),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text(usageInformationDoNotShowAgain),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text(usageInformationUnderstood),
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
                          style: const TextStyle(
                            fontFamily: monospaceFont,
                            fontStyle: FontStyle.italic,
                            color: Color(0xEEFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                const Tab(
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text(add),
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
      name: _fileName,
      ext: _fileExtension,
      bytes: Uint8List.fromList(string.codeUnits),
    );

    WebUnloadConfirmationPopup.deactivate();
  }

  Future<void> _loadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [_fileExtension],
    );

    if (result == null) return; // Dialog was canceled

    String string;
    if (kIsWeb) {
      Uint8List bytes = result.files.single.bytes!;
      string = String.fromCharCodes(bytes);
    } else {
      File file = File(result.files.single.path!);
      string = await file.readAsString();
    }

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
        Text(usageInformationText1),
        SizedBox(
          width: double.infinity,
          child: CodeBlock(
            """
marker-sets: {
  # Please check out the wiki for information on how to configure this:
  # https://bluemap.bluecolored.de/wiki/customization/Markers.html
}""",
            copy: false,
          ),
        ),
        Text(usageInformationText2),
        SizedBox(
          width: double.infinity,
          child: CodeBlock(
            """include required(file("$usageInformationPathTo$_fileName.$_fileExtension"))""",
            copy: true,
          ),
        ),
        Text(usageInformationText3),
      ],
    );
  }
}
