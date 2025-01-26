shader_type canvas_item;

uniform sampler2D noise : source_color, repeat_enable, filter_nearest;
uniform float alpha : hint_range(0.0, 1.0) = 1.;
uniform sampler2D falloff;
uniform sampler2D lineFalloff;
uniform float speed = 10.;

vec2 polar(vec2 uv, vec2 center, float zoom, float repeat)
{
	vec2 dir = uv - center;
	float radius = length(dir) * 2.0;
	float angle = atan(dir.y, dir.x) * 1.0/(3.1416 * 2.0);
	return mod(vec2(radius * zoom, angle * repeat), 1.0);
}

void fragment() {
	vec2 polar = polar(UV, vec2(.5), 1., 1.);
	float mask = distance(vec2(.5), UV);

	float polarStep = polar.y + TIME * speed;
	polarStep -= fract(polarStep * 1000.) / 1000.;
	vec2 polarLineUV = vec2(polarStep);
	float lines = texture(noise, polarLineUV).r;

	float n = texture(lineFalloff, vec2(lines, 0.)).r;

	COLOR.a = n * texture(falloff, vec2(mask, 0.)).r;

	COLOR.a *= alpha;
}