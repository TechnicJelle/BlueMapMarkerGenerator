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
    return TechApp(
      title: appName,
      primaryColour: myBlue,
      secondaryColour: Colors.blue,
      // themeMode: ThemeMode.light,
      themeMode: ThemeMode.dark,
      home: const MyHome(),
    );
  }
}

class TechApp extends MaterialApp {
  final Color primaryColour;
  final Color secondaryColour;

  TechApp({
    required super.title,
    super.debugShowCheckedModeBanner = false,
    required this.primaryColour,
    required this.secondaryColour,
    required super.themeMode,
    super.routes,
    required super.home,
    super.key,
  }) : super(
          theme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme.light(
              primary: primaryColour,
              secondary: secondaryColour,
              surfaceVariant: lighten(secondaryColour, 0.075),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme.dark(
              primary: primaryColour,
              secondary: secondaryColour,
              surfaceVariant: lighten(secondaryColour, 0.075),
            ),
          ),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context).copyWith(
                appBarTheme: AppBarTheme(color: primaryColour),
                checkboxTheme: const CheckboxThemeData(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColour,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0.0 && amount <= 1.0);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
