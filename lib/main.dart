import "package:flutter/material.dart";

import "tab.dart";

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
      title: "Flutter Demo",
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
            title: const Text("BlueMap Static Marker Generator"),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                for (MarkerSetTab markerSet in tabs.values)
                  Tab(
                    text: markerSet.markerSet.label,
                  ),
                const Tab(text: "Add")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              for (MarkerSetTab markerSet in tabs.values) markerSet,
              Center(
                child: Column(
                  children: [
                    const Text("Add a new tab"),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          tabs["test${tabs.length}"] = MarkerSetTab(
                            label: "Test ${tabs.length}",
                          );
                        });
                      },
                      child: const Text("Add"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
