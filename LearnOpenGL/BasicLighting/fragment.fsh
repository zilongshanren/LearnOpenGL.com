#version 330 core
out vec4 color;

uniform vec3 objectColor;
uniform vec3 lightColor;

in vec3 Normal;
in vec3 FragPos;

uniform vec3 lightPos;


void main()
{
    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(lightPos - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;
    
    float ambientStrength = 0.2f;
    vec3 ambient = ambientStrength * lightColor;
    
    vec3 result = (diffuse + ambient) * objectColor;
    color = vec4(result, 1.0f);
}