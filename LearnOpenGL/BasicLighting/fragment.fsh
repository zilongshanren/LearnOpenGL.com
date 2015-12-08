#version 330 core
out vec4 color;

uniform vec3 objectColor;

in vec3 phoneColor;

void main()
{
    vec3 result = phoneColor * objectColor;
    color = vec4(result, 1.0f);
}