// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
  //normalize the fragcoord
  vec2 st = gl_FragCoord.xy/u_resolution;
  float pct = 0.0;
  float xpos = sin(u_time);
  float ypos = cos(u_time);
  pct = distance(st,vec2(xpos,ypos));
  vec3 color = vec3(pct);
  gl_FragColor = vec4(sin((u_time)*color),1.000);
}