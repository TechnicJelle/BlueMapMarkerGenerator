import "package:flutter/material.dart";

class Colour {
  //between 0 and 255
  int r;
  int g;
  int b;

  //between 0 and 1
  double a;

  Colour(this.r, this.g, this.b, this.a);

  @override
  String toString() => "Colour($r, $g, $b, $a)";

  Map<String, dynamic> toJson() => {
        "r": r,
        "g": g,
        "b": b,
        "a": a,
      };

  static Colour fromJson(Map<String, dynamic> json) {
    return Colour(
      json["r"],
      json["g"],
      json["b"],
      json["a"],
    );
  }

  static Colour fromColor(Color color) {
    return Colour(
      color.red,
      color.green,
      color.blue,
      color.opacity,
    );
  }

  Color toColor() => Color.fromRGBO(r, g, b, a);
}
