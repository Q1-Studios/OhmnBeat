shader_type canvas_item;
//vibe-shader-coding

uniform float scanline_count : hint_range(0, 1800) = 50.0;
uniform float scanline_speed = 0.5;
uniform float scanline_strength : hint_range(0.0, 1.0) = 1.0;
uniform float v_scan_strength : hint_range(0.0, 1.0) = 0.25;

uniform float rgb_offset_uv = 0.003;
uniform float curvature = 1.0;
uniform vec2 screen_aspect = vec2(1.0, 1.0);

uniform float phosphor_bias_red = 1.0;
uniform float phosphor_bias_blue = 1.0;
uniform float phosphor_bias_green = 1.2;
uniform float phosphor_clamp = 0.95;
uniform float noise_strength : hint_range(0.0, 1.0) = 0.12;
uniform float noise_scale = 240.0;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}
vec2 uv_curve(vec2 uv)
{
    if (curvature == 0.0) return uv;

    vec2 p = uv * 2.0 - 1.0;
    p.x *= screen_aspect.x / screen_aspect.y;

    float r2 = dot(p, p);
    p *= 1.0 + r2 * curvature * -0.15;

    p.x *= screen_aspect.y / screen_aspect.x;

    return p * 0.5 + 0.5;
}


void fragment() {
    // curve UV and clamp so we don't sample outside the texture
    vec2 curved = clamp(uv_curve(UV), vec2(0.0), vec2(1.0));
	// aspect-correct scan coordinates
	vec2 scan_uv = curved;
	scan_uv.x *= screen_aspect.x / screen_aspect.y;

    // RGB subpixel sampling (offset in UV units)
    float r = texture(TEXTURE, curved + vec2(0.0, 0.0)).r;
    float g = texture(TEXTURE, curved + vec2(rgb_offset_uv, 0.0)).g;
    float b = texture(TEXTURE, curved + vec2(-rgb_offset_uv, 0.0)).b;
    vec3 col = vec3(r, g, b);

    // scanlines
    float phase = TIME * scanline_speed;
    float scan_y = scan_uv.y + phase;

    float s = sin(scan_y * scanline_count * PI*2.0f);

    // normalize
    float s_norm = (s * 0.5 + 0.5) * 0.9 + 0.1;
    float scan_brightness = pow(s_norm, 0.25);

    // Blend Scanlines
    float final_scan = mix(1.0, scan_brightness, clamp(scanline_strength, 0.0, 1.0));
    col *= final_scan;
	// X-Axis Scanlines
	float v = sin((scan_uv.x + phase * 0.2) * scanline_count * PI * 2.0);

	float v_norm = (v * 0.5 + 0.5) * 0.9 + 0.1;
	float v_scan = pow(v_norm, 0.35);

	// Blend Vert Scanlines
	col *= mix(1.0, v_scan, clamp(v_scan_strength, 0.0, 1.0));


	col = pow(col, vec3(0.6));
	col = pow(col, vec3(phosphor_clamp));
	col.r *= phosphor_bias_red;
	col.g *= phosphor_bias_green;
	col.b *= phosphor_bias_blue;

	// Noise
	vec2 n_uv = curved * noise_scale;
	n_uv += vec2(TIME * 12.0, TIME * 7.0);

	float n = hash(floor(n_uv));

	n = pow(n, 2.2);

	float lum = dot(col, vec3(0.299, 0.587, 0.114));
	float noise = (n - 0.5) * noise_strength * (0.4 + lum);

	col += vec3(noise * 0.6, noise, noise * 0.4);


	col = clamp(col, 0.0, 1.0);
    COLOR = vec4(col, 1.0);
}
