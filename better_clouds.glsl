// Author: @isthisanart_
// Title: better_cloud_simulator

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random (in vec2 st) { 
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))* 
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) + 
            (c - a)* u.y * (1.0 - u.x) + 
            (d - b) * u.x * u.y;
}

#define OCTAVES 6
float fbm (in vec2 st) {
    // Initial values
    float value = 0.0;
    float amplitud = .5;
    float frequency = 0.;
    
    mat2 rot = mat2(cos(0.5), sin(0.5), 
                    -sin(0.5), cos(0.50));
    //
    // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitud * noise(st);
        st *= rot * 2.;
        amplitud *= .5;
    }
    return value;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;

    float scale = mix(1.5,7.,sin(u_time*.06));
    
    st.x = st.x + sin(u_time*0.07)*2.;
    st.y = st.y + sin(u_time*0.09)*2.;
    
    vec2 q = vec2(0.);
    q.x = fbm( st + 0.00*u_time);
    q.y = fbm( st + vec2(1.0));
    
    vec2 r = vec2(0.);
    r.x = fbm( st + 1.0*q + vec2(1.7,9.2)+ 0.15*u_time );
    r.y = fbm( st + 1.0*q + vec2(8.3,2.8)+ 0.126*u_time);
    
    vec3 color = vec3(0.0);
    float f = fbm(st*scale);// - (sin(u_time)*.5);
    
    color = mix(vec3(0.101961,0.10608,0.266667),
                vec3(0.966667,0.96667,0.998039),
                clamp((f*f)*2.0,0.0,1.0));
    color = color * .5 + clamp(abs(sin(u_time*0.2)), .2, .8);
    
    color = mix(color,
            vec3(0.06667,.46,.6),
            clamp(length(r.x),0.0,1.0));

    gl_FragColor = vec4(color,1.0);
}