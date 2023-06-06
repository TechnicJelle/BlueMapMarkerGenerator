import "package:flutter/material.dart";

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

  void addTab(String id, String label) {
    widget.setState(() {
      tabs[id] = MarkerSetTab(
        label: label,
      );
    });
  }

  void validateAndAdd() {
    final formState = formKey.currentState;
    if (formState != null && formState.validate()) {
      addTab(idController.text, labelController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Text("Add a new Marker Set"),
            //ID
            TextFormField(
              controller: idController,
              autofocus: true,
              decoration: const InputDecoration(labelText: "ID"),
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.none,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? s) {
                if (s == null || s.trim().isEmpty) {
                  return "Cannot be empty";
                }
                if (tabs.containsKey(s)) {
                  return "Can't have a duplicate ID";
                }
                if (!RegExp(r"^[a-zA-Z0-9_-]+$").hasMatch(s)) {
                  return "Invalid character";
                }
                return null;
              },
            ),
            TextFormField(
              controller: labelController,
              autofocus: false,
              decoration: const InputDecoration(labelText: "Label"),
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.words,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? s) {
                if (s == null || s.trim().isEmpty) {
                  return "Cannot be empty";
                }
                return null;
              },
              onFieldSubmitted: (_) => validateAndAdd(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => validateAndAdd(),
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
