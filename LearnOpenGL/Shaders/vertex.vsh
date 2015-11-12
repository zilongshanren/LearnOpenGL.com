#version 330 core

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 color;

out vec4 vertexColor;
out vec3 vertexPosition;

uniform float offset;

void main()
{
    gl_Position = vec4(position.x + offset, position.y, position.z, 1.0);
    vertexColor = vec4(color, 1.0);
    vertexPosition = position;
}