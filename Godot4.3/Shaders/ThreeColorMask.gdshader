shader_type canvas_item;
uniform vec4 color_r: source_color;
uniform vec4 color_g: source_color;
uniform vec4 color_b: source_color;

uniform vec3 brightness = vec3(1.0,1.0,1.0);
uniform float strength = 1.0;

void fragment() {
	vec4 color = COLOR;
	if (strength > 0.0) {
		color.rgb = (color_r*COLOR.r*brightness.r).rgb;
		color.rgb += (color_g*COLOR.g*brightness.g).rgb;
		color.rgb += (color_b*COLOR.b*brightness.b).rgb;
		if(COLOR.a > 0.0){
			if(COLOR.r > 0.0){
				color.a = color_r.a;
			}
			if(COLOR.g > 0.0){
					color.a = color_g.a;
			}
			if(COLOR.b > 0.0){
				color.a = color_b.a;
			}
		}
		if (strength == 1.0) {
			COLOR = color;
		}
		else{
			COLOR = mix(COLOR,color,strength);
		}
	}
}

