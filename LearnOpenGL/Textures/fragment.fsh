#version 330 core

in vec4 vertexColor;
in vec2 TexCoord;

out vec4 color;

uniform sampler2D ourTexture;

void main()
{
    color = texture(ourTexture, TexCoord);
//    color = vertexColor;
}