import "dart:math";

class Vector2 {
  double x;
  double y;

  Vector2(this.x, this.y);

  @override
  String toString() => "Vector2($x, $y)";

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}

class Vector3 {
  double x;
  double y;
  double z;

  Vector3(this.x, this.y, this.z);

  Vector3.random()
      : x = Random().nextDouble(),
        y = Random().nextDouble(),
        z = Random().nextDouble();

  @override
  String toString() => "Vector3($x, $y, $z)";

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "z": z,
      };
}