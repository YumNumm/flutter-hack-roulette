#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 uSize;
uniform float uTime;
uniform vec3 uColor;
uniform float uIntensity;

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;

    // ネオン効果のための距離計算
    float dist = length(uv - vec2(0.5));

    // パルス効果
    float pulse = sin(uTime * 2.0) * 0.5 + 0.5;

    // グロー効果
    float glow = exp(-dist * 8.0) * uIntensity;
    glow += exp(-dist * 4.0) * uIntensity * 0.5;

    // 色の計算
    vec3 neonColor = uColor * glow * (0.8 + pulse * 0.2);

    fragColor = vec4(neonColor, glow);
}
