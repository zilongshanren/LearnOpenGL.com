#version 330 core
layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform vec3 lightColor;

out vec3 phoneColor;

uniform vec3 lightPos;

void main()
{
    gl_Position = projection * view * model * vec4(position, 1.0f);
    
    //convert position to word space
    vec3 positionInView = vec3(view * model * vec4(position, 1.0));
    vec3 lightPosInView = vec3(view * vec4(lightPos,1.0));
    vec3 Normal = mat3(transpose(inverse(view * model))) * normal;
    //ambient
    float ambientStrength = 0.2f;
    vec3 ambient = ambientStrength * lightColor;
    
    //diffuse
    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(lightPosInView - positionInView);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;
    
    //calculate specular light
    float specularStrength = 0.5f;
    vec3 viewDir = normalize(-positionInView);
    vec3 reflectDir = reflect(-lightDir, norm);
    
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
    vec3 specular = specularStrength * spec * lightColor;
    
    
    phoneColor = ambient + diffuse + specular;
}