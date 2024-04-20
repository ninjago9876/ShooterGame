shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform vec4 col1;
uniform vec4 col2;

void fragment() {
	vec4 screenCol = texture(screen_texture, SCREEN_UV);
	
	vec4 fog = mix(col1, col2, texture(TEXTURE, UV));
	COLOR = screenCol + fog;
}
