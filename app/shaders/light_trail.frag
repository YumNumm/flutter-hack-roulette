#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 uSize;
uniform float uTime;
uniform float uProgress;
uniform vec3 uColor;

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;

    // 光の軌跡エフェクト
    float trail = smoothstep(uProgress + 0.1, uProgress, uv.x);
    trail *= smoothstep(uProgress - 0.3, uProgress, uv.x);

    // 輝き
    float sparkle = sin(uTime * 10.0 + uv.x * 20.0) * 0.5 + 0.5;
    sparkle *= trail;

    // 距離による減衰
    float centerDist = abs(uv.y - 0.5) * 2.0;
    float fade = 1.0 - smoothstep(0.0, 0.3, centerDist);

    // 最終的な色
    vec3 finalColor = uColor * trail * fade * (0.7 + sparkle * 0.3);
    float alpha = trail * fade;

    fragColor = vec4(finalColor, alpha);
}
