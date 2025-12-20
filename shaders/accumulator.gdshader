shader_type canvas_item;
//vibe-shader-coding

uniform sampler2D screen : hint_screen_texture;
uniform float decay : hint_range(0.0, 1.0) = 0.1;
uniform float hard_cut : hint_range(0.0, 0.5) = 0.03;

void fragment() {
    vec4 prev = textureLod(screen, SCREEN_UV, 0.0);
    vec3 next = (prev.rgb - hard_cut) * (1.0 - decay);
    COLOR = vec4(max(next, 0.0), prev.a);
}