#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 uSize;
uniform float uTime;
uniform vec3 uColor;
uniform float uAlpha;

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;
    
    // スキャンライン効果
    float scanline = sin(uv.y * 100.0 + uTime * 5.0) * 0.05 + 0.95;
    
    // ホログラムのグリッチ効果
    float glitch = step(0.98, sin(uTime * 20.0 + uv.y * 50.0));
    float offset = glitch * sin(uTime * 100.0) * 0.02;
    
    // エッジグロー
    vec2 center = uv - vec2(0.5);
    float edgeDist = length(center);
    float edgeGlow = smoothstep(0.5, 0.3, edgeDist);
    
    // ホログラムのちらつき
    float flicker = sin(uTime * 3.0) * 0.1 + 0.9;
    
    // 色の計算
    vec3 hologramColor = uColor * scanline * flicker;
    hologramColor += uColor * edgeGlow * 0.3;
    
    float alpha = uAlpha * scanline * flicker;
    
    fragColor = vec4(hologramColor, alpha);
}

