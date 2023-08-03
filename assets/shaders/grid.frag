#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 resolution;
uniform float zoom;
uniform float thickness; // 0.0 - 1.0
out vec4 fragColor;

vec3 lineColour = vec3(0.0);

void main() {
    if (zoom < 20) {
        fragColor = vec4(0.0);
        return;
    }

    vec2 st = FlutterFragCoord().xy;
    vec2 fraction = fract(st);
    vec2 subtract = fraction - 0.5;
    vec2 a = abs(subtract);
    float d = max(a.x, a.y);
    float thick = thickness * 0.5;

    fragColor = vec4(lineColour, d > thick);
}