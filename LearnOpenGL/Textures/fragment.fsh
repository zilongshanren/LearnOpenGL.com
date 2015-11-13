#version 330 core

in vec4 vertexColor;
in vec3 vertexPosition;

out vec4 color;

void main()
{
    color = vertexColor;
}