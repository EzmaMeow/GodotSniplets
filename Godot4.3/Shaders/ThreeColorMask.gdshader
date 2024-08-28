shader_type canvas_item;
uniform vec4 color_r: source_color;
uniform vec4 color_g: source_color;
uniform vec4 color_b: source_color;

uniform vec3 brightness = vec3(1.0,1.0,1.0);
uniform float strength = 1;

void fragment() {
	vec4 color = COLOR;
	if (strength > 0.0) {
		color.rgb = (color_r*COLOR.r*color_r.a*brightness.r).rgb;
		color.rgb += (color_g*COLOR.g*color_g.a*brightness.g).rgb;
		color.rgb += (color_b*COLOR.b*color_b.a*brightness.b).rgb;
		
		if (strength == 1.0) {
			COLOR = color;
		}
		else{
			COLOR = mix(COLOR,color,strength);
		}
	}
}

