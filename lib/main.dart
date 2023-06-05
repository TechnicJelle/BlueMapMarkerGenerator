import "package:flutter/material.dart";

import "tabs/tab_add.dart";
import "tabs/tab_marker_set.dart";

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
    return MaterialApp(
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
              for (MarkerSetTab markerSet in tabs.values) markerSet,
              TabAdd(tabs, setState),
            ],
          ),
        ),
      ),
    );
  }
}
