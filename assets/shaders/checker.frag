#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 resolution;

out vec4 fragColor;

vec3 black = vec3(0.5);
vec3 white = vec3(1.0);

void main() {
    vec2 st = FlutterFragCoord().xy;

    float total = int(floor(st.x) + floor(st.y));

    vec3 col = mix(white, black, mod(total + 1.0, 2.0));

    fragColor = vec4(col, 1.0);
}