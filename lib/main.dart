import "package:flutter/material.dart";

import "home.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHome(),
    );
  }
}
