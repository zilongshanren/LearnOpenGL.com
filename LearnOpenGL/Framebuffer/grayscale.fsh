#version 330 core
in vec2 TexCoords;
out vec4 color;

uniform sampler2D screenTexture;

//void main()
//{
//    color = texture(screenTexture, TexCoords);
//    float average = (color.r + color.g + color.b) / 3.0;
//    
//    color = vec4(average, average, average, 1.0);
//}

void main()
{
    color = texture(screenTexture, TexCoords);
    float average = 0.2126 * color.r + 0.7152 * color.g + 0.0722 * color.b;
    color = vec4(average, average, average, 1.0);
}