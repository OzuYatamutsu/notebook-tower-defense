shader_type canvas_item;

uniform vec4 dark_color = vec4(0.0, 0.5, 1.0, 1.0); // light blue
uniform vec4 light_color = vec4(1.0, 1.0, 1.0, 1.0); // white
uniform float dark_threshold = 0.3; // threshold value

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float brightness = tex_color.r;

    if (brightness < dark_threshold) {
        // Darker than threshold → turn fully dark_color
        COLOR = dark_color * tex_color.a;
    } else {
        // Lighter → normal interpolation
        COLOR = mix(dark_color, light_color, brightness) * tex_color.a;
    }
}