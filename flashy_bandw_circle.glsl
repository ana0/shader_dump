// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float rand(vec2 x) {
    float y = fract(sin(dot(x.xy, x.xy))*1.0);
    return y;
} 

void main() {
    // normalize pixels
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st -= vec2(0.5, 0.5);
    st.x *= u_resolution.x/u_resolution.y;
    
    float y = rand(st * u_time);
    
    vec3 color = vec3(0.);
    color = vec3(y);

    gl_FragColor = vec4(color,1.0);
}