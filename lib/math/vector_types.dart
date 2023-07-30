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

  static Vector2 fromJson(Map<String, dynamic> json) {
    return Vector2(
      json["x"],
      json["y"],
    );
  }
}

class Vector3 {
  double x;
  double y;
  double z;

  Vector3(this.x, this.y, this.z);

  @override
  String toString() => "Vector3($x, $y, $z)";

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "z": z,
      };

  static Vector3 fromJson(Map<String, dynamic> json) {
    return Vector3(
      json["x"],
      json["y"],
      json["z"],
    );
  }
}
