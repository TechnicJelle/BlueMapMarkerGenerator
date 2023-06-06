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
  final idKey = GlobalKey<FormFieldState>();
  final labelKey = GlobalKey<FormFieldState>();

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
    if (formKey.currentState == null) return;
    if (formKey.currentState!.validate()) {
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
              key: idKey,
              controller: idController,
              autofocus: true,
              decoration: const InputDecoration(labelText: "ID"),
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.none,
              onChanged: (String s) {
                idKey.currentState!.validate();
              },
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
            //Label
            TextFormField(
              key: labelKey,
              controller: labelController,
              autofocus: false,
              decoration: const InputDecoration(labelText: "Label"),
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.words,
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
