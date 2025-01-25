shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float gray_a : hint_range(0, 1);

void fragment()
{
	vec4 tex_color = texture(SCREEN_TEXTURE,SCREEN_UV);
	
	float gray = tex_color.r * 0.299 + tex_color.g * 0.587 + tex_color.b * 0.114;
	
	COLOR = vec4(vec3(gray), gray_a);
}
