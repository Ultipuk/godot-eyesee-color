shader_type canvas_item;

// Shader code is based on this shader:
// https://godotshaders.com/shader/color-vision-deficiency-cvd-simulation-shader/

// Tritanopia simulation filter method:
// Brettel, H., Viénot, F., & Mollon, J. D. (1997).
// Computerized simulation of color appearance for dichromats. Journal of the Optical Society of America A, 14(10), 2647–2655.
// https://doi.org/10.1364/josaa.14.002647

const mat3 brettel_tritan_1 = mat3(
    vec3(1.01277, -0.01243, 0.07589),
    vec3(0.13548,  0.86812, 0.80500),
    vec3(-0.14826, 0.14431, 0.11911)
);
const mat3 brettel_tritan_2 = mat3(
    vec3(0.93678, 0.06154, -0.37562),
    vec3(0.18979, 0.81526,  1.12767),
    vec3(-0.12657, 0.12320,  0.24796)
);
const vec3 brettel_tritan_plane_normal = vec3(0.03901, -0.02788, -0.01113);

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
	
	float d = dot(lin_rgb, brettel_tritan_plane_normal);
	mat3 m = d >= 0.0 ? brettel_tritan_1 : brettel_tritan_2;
	vec3 rgb_cvd = clamp(m * lin_rgb, 0.0, 1.0);
	
	COLOR.rgb = linear_to_srgb(rgb_cvd);
}