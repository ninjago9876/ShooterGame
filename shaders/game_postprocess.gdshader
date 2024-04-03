shader_type canvas_item;

// If you intend to read from mipmaps with `textureLod()` LOD values greater than `0.0`,
// use `filter_nearest_mipmap` instead. This shader doesn't require it.
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// Parameters
uniform vec2 curvature;
 
float vignette(vec2 uv, float radius, float smoothness) {
	float diff = radius - distance(uv, vec2(0.5, 0.5));
	return smoothstep(-smoothness, smoothness, diff);
}

vec2 curveRemapUV(vec2 uv) {
    // as we near the edge of our screen apply greater distortion using a cubic function
    uv = uv * 2.0-1.0;
    vec2 offset = abs(uv.yx) / vec2(curvature.x, curvature.y);
    uv = uv + uv * offset * offset;
    uv = uv * 0.5 + 0.5;
    return uv;
}
void fragment() {
    vec2 remappedUV = curveRemapUV(SCREEN_UV);
    vec4 baseColor = textureLod(screen_texture, floor(remappedUV*vec2(640, 480))/vec2(640, 480), 0.0);
	// vec4 baseColor = vec4(remappedUV)
    if (remappedUV.x < 0.0 || remappedUV.y < 0.0 || remappedUV.x > 1.0 || remappedUV.y > 1.0){
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
		float yLines = (0.5 * sin(remappedUV.x * 640. * PI) + 0.5) * 1.3;
		float xLines = (0.5 * sin(remappedUV.y * 480. * PI) + 0.5) * 3.;
		baseColor = floor(baseColor*256.)/256.;
		float vig = vignette(remappedUV, .5, .4);
		baseColor *= vec4(vig, vig, vig, 1.0);
        COLOR = baseColor * (yLines + xLines)/2.;
		COLOR.a = 1.;
    }
}