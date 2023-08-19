class Vector2i {
  int x;
  int y;

  Vector2i(this.x, this.y);

  @override
  String toString() => "Vector2i($x, $y)";

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };

  static Vector2i fromJson(Map<String, dynamic> json) {
    return Vector2i(
      json["x"],
      json["y"],
    );
  }
}

class Vector2d {
  double x;
  double z;

  Vector2d(this.x, this.z);

  @override
  String toString() => "Vector2d($x, $z)";

  Map<String, dynamic> toJson() => {
        "x": x,
        "z": z,
      };

  static Vector2d fromJson(Map<String, dynamic> json) {
    return Vector2d(
      json["x"],
      json["z"],
    );
  }
}

class Vector3d {
  double x;
  double y;
  double z;

  Vector3d(this.x, this.y, this.z);

  @override
  String toString() => "Vector3d($x, $y, $z)";

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "z": z,
      };

  static Vector3d fromJson(Map<String, dynamic> json) {
    return Vector3d(
      json["x"],
      json["y"],
      json["z"],
    );
  }
}
