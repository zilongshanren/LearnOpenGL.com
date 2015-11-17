#version 330 core

in vec4 vertexColor;
in vec2 TexCoord;

out vec4 color;

uniform sampler2D ourTexture1;
uniform sampler2D ourTexture2;
uniform float mixValue;

void main()
{
    color = mix(texture(ourTexture1, TexCoord), texture(ourTexture2, vec2(1 - TexCoord.x,1- TexCoord.y)), mixValue);
//    color = vertexColor;
}