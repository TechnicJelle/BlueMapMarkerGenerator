import "dart:convert";
import "dart:io";

import "package:file_picker/file_picker.dart";
import "package:file_saver/file_saver.dart";
import "package:flutter/foundation.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:url_launcher/url_launcher.dart";
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
    ThemeData scrollbarTheme = Theme.of(context).copyWith(
        scrollbarTheme: ScrollbarThemeData(
      thickness: MaterialStateProperty.all(2),
      thumbVisibility: MaterialStateProperty.all(true),
      interactive: false,
    ));
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
            leading: Padding(
              padding: const EdgeInsets.all(4),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3,
                      offset: const Offset(2, 1),
                    ),
                  ],
                ),
                child: Image.asset(
                  "assets/images/icons/icon.png",
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
            title: const Text(appName, maxLines: 2),
            actions: [
              IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip: helpTitle,
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(helpTitle),
                      content: Theme(
                        data: scrollbarTheme,
                        child: SingleChildScrollView(
                          controller: PrimaryScrollController.of(context),
                          child: const _Help(),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(understood),
                        ),
                      ],
                    ),
                  )
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.upload_file),
                tooltip: loadButtonTooltip,
                onPressed: () async {
                  try {
                    await _loadFile();
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          errorOpeningFile,
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(
                          e.toString(),
                          style: const TextStyle(fontFamily: monospaceFont),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(understood),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.save),
                tooltip: saveButtonTooltip,
                onPressed: () async {
                  if (showTutorial) {
                    bool? show = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(installInstructionsTitle),
                        content: Theme(
                          data: scrollbarTheme,
                          child: SingleChildScrollView(
                            controller: PrimaryScrollController.of(context),
                            child: const _UsageInformation(),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child:
                                const Text(installInstructionsDoNotShowAgain),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text(understood),
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

class _UsageInformation extends StatelessWidget {
  const _UsageInformation();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(installInstructionsText1),
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
        Text(installInstructionsText2),
        SizedBox(
          width: double.infinity,
          child: CodeBlock(
            """include required(file("$installInstructionsPathTo$_fileName.$_fileExtension"))""",
            copy: true,
          ),
        ),
        Text(installInstructionsText3),
      ],
    );
  }
}

class _Help extends StatelessWidget {
  const _Help();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(
          children: [
            const TextSpan(text: helpText1),
            _link(
              helpText1Link,
              "https://bluemap.bluecolored.de/wiki/customization/Markers.html",
            ),
            const TextSpan(text: helpText2),
            _link(
              helpText2Link,
              "https://bluecolo.red/map-discord",
            ),
            const TextSpan(text: helpText3),
            _link(
              helpText3link,
              "https://discord.com/channels/665868367416131594/863844716047106068",
            ),
            const TextSpan(text: helpText4),
          ],
        )),
        const SizedBox(height: 32),
        Text(
          installInstructionsTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 24),
        const _UsageInformation(),
      ],
    );
  }

  static TextSpan _link(String text, String sUrl) {
    return TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
      recognizer: _tapLink(sUrl),
    );
  }

  static TapGestureRecognizer _tapLink(String sUrl) {
    return TapGestureRecognizer()
      ..onTap = () async {
        final Uri url = Uri.parse(sUrl);
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw Exception("Could not launch $url");
        }
      };
  }
}
