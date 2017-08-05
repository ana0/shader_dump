// Author: @isthisanart_
// Title: cloud_simulator

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ), 
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ), 
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}


void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;

    float scale = mix(3.5,4.,abs(sin(u_time*.00000000001)));
    st.x = st.x + sin(u_time*0.07)*2.;
    st.y = st.y + sin(u_time*0.09)*2.;
    vec2 pos = vec2(st*scale);

    // Use the noise function
    float n = noise(pos) * .5 + max(abs(sin(u_time*0.2)), .5);
    
    if (n < .5) {
        n = mix(.4,.6,n);
    }
    float r = n;
    float g = n;

    gl_FragColor = vec4(r, g, 1., 1.0);
}