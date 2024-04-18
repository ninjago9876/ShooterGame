shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform float intensity = 1.;

void fragment() {
	float dist = length(SCREEN_UV-.5);
	COLOR = texture(screen_texture, SCREEN_UV) + vec4(.05, .15*intensity/1.5, .2*intensity, 1.0)*dist*
		(sin(SCREEN_UV.y*1500.)/2.+1.2)*2. * intensity;
}
