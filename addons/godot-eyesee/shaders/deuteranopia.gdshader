shader_type canvas_item;

// Shader code is based on this shader:
// https://godotshaders.com/shader/color-vision-deficiency-cvd-simulation-shader/

// Deuteranopia simulation filter method:
// Viénot, F., Brettel, H., & Mollon, J. D. (1999).
// Digital video colourmaps for checking the legibility of displays by dichromats. Color Research & Application, 24(4), 243–252.
// https://vision.psychol.cam.ac.uk/jdmollon/papers/colourmaps.pdf

const mat3 vienot_deutan = mat3(
	vec3(0.29275, 0.29275, -0.02234),
	vec3(0.70725, 0.70725,  0.02234),
	vec3(0.00000, -0.00000, 1.00000)
);

// This is Godot implementation of sRGB
vec3 linear_to_srgb(vec3 color) {
	// If going to srgb, clamp from 0 to 1.
	color = clamp(color, vec3(0.0), vec3(1.0));
	const vec3 a = vec3(0.055f);
	return mix(
		(vec3(1.0f) + a) * pow(color.rgb, vec3(1.0f / 2.4f)) - a,
		12.92f * color.rgb,
		lessThan(color.rgb, vec3(0.0031308f))
	);
}
vec3 srgb_to_linear(vec3 color) {
	return mix(
		pow((color.rgb + vec3(0.055)) * (1.0 / (1.0 + 0.055)), vec3(2.4)),
		color.rgb * (1.0 / 12.92),
		lessThan(color.rgb, vec3(0.04045))
	);
}

void fragment() {
	vec3 lin_rgb = srgb_to_linear(COLOR.rgb);
	vec3 rgb_cvd = vienot_deutan * lin_rgb;
	COLOR.rgb = linear_to_srgb(rgb_cvd);
}
