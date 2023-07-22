import "package:flutter/material.dart";

import "home.dart";
import "lang.dart";

void main() {
  runApp(const MyApp());
}

const Color myBlue = Color(0xFF1a72ff);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: const ColorScheme.light(
          primary: myBlue,
          secondary: Colors.blue,
        ),
        appBarTheme: const AppBarTheme(
          color: myBlue,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: false,
        colorScheme: const ColorScheme.dark(
          primary: myBlue,
          secondary: Colors.blue,
        ),
        appBarTheme: const AppBarTheme(
          color: myBlue,
        ),
      ),
      // themeMode: ThemeMode.light,
      themeMode: ThemeMode.dark,
      home: const MyHome(),
    );
  }
}
