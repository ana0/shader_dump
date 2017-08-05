// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float rand(vec2 x) {
    float y = fract(sin(dot(x.xy, x.xy))*100000.0);
    return y;
} 

void main() {
    // normalize pixels
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    //st -= vec2(-0.070,0.970);
    st *= 20.; // Scale the coordinate system by 10
    
    vec2 ipos = floor(st);  // get the integer coords
    vec2 fpos = fract(st) + .5;  // get the fractional coords
    
    float y = rand(st);
    
    vec3 color = vec3(0.);
    //color = vec3(rand(ipos));
    color = vec3(rand(ipos), fpos * abs(sin(u_time)));

    gl_FragColor = vec4(color,1.0);
}