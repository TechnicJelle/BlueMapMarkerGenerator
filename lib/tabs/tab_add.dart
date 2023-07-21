import "package:flutter/material.dart";

import "../lang.dart";
import "tab_marker_set.dart";

class TabAdd extends StatefulWidget {
  final Map<String, MarkerSetTab> tabs;
  final StateSetter setState;

  const TabAdd(this.tabs, this.setState, {super.key});

  @override
  State<TabAdd> createState() => _TabAddState();
}

class _TabAddState extends State<TabAdd> {
  Map<String, MarkerSetTab> get tabs => widget.tabs;

  final formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final labelController = TextEditingController();

  void validateAndAdd() {
    final formState = formKey.currentState;
    if (formState != null && formState.validate()) {
      addTab(idController.text, labelController.text);
    }
  }

  void addTab(String id, String label) {
    widget.setState(() {
      tabs[id] = MarkerSetTab.empty(
        markerSetLabel: label,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(addMarkerSetTabHint),
                TextFormField(
                  controller: labelController,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: propertyLabel),
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? s) {
                    if (s == null || s.trim().isEmpty) {
                      return cannotBeEmpty;
                    }
                    return null;
                  },
                  onChanged: (String s) {
                    idController.text = s
                        .toLowerCase()
                        .replaceAll(regexLabelToID, " ")
                        .trim()
                        .replaceAll(regexMultipleSpaces, "-");
                  },
                ),
                Focus(
                  canRequestFocus: false,
                  onFocusChange: (bool gained) {
                    if (gained) {
                      idController.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: idController.text.length,
                      );
                    }
                  },
                  child: TextFormField(
                    controller: idController,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: propertyID),
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.none,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? s) {
                      if (s == null || s.trim().isEmpty) {
                        return cannotBeEmpty;
                      }
                      if (tabs.containsKey(s)) {
                        return noDuplicateIDs;
                      }
                      if (!regexIDValidation.hasMatch(s)) {
                        return invalidCharacter;
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => validateAndAdd(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => validateAndAdd(),
                  child: const Text(add),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
