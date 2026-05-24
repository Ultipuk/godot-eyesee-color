shader_type canvas_item;

// Shader code is based on this shader:
// https://godotshaders.com/shader/color-vision-deficiency-cvd-simulation-shader/

// Achromatopsia is just luminance from ITU-R BT.601
// https://www.itu.int/rec/R-REC-BT.601-7-201103-I

void fragment() {
	COLOR.rgb = vec3(0.299 * COLOR.r + 0.587 * COLOR.g + 0.114 * COLOR.b);
}
