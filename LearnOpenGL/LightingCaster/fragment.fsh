#version 330 core
out vec4 color;

in vec3 FragPos;
in vec3 Normal;

struct Material {
    sampler2D diffuse;
    sampler2D specular;
    float shininess;
};

struct Light {
    vec3 position;
    
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    
    float constant;
    float linear;
    float quadratic;
    
    //for spotlight
    vec3  direction;
    float cutOff;
};

uniform vec3 viewPos;

uniform Light light;
uniform Material material;

in vec2 TexCoords;


void main()
{
   
    vec3 lightDir = normalize(light.position - FragPos);
    
    float theta = dot(lightDir, normalize(-light.direction));
    if (theta > light.cutOff) {
        float distance    = length(light.position - FragPos);
        float attenuation = 1.0f / (light.constant + light.linear * distance +
                                    light.quadratic * (distance * distance));
        
        
        // Ambient
        vec3 ambient = light.ambient * vec3(texture(material.diffuse, TexCoords));
        vec3 norm = normalize(Normal);

        // // Diffuse
        float diff = max(dot(norm, lightDir), 0.0);
        vec3 diffuse = light.diffuse * (diff * vec3(texture(material.diffuse, TexCoords)));
        
        // Specular
        vec3 viewDir = normalize(viewPos - FragPos);
        vec3 reflectDir = reflect(-lightDir, norm);
        float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
        vec3 specular = light.specular * (spec * (vec3(texture(material.specular, TexCoords))));
        
        diffuse  *= attenuation;
        specular *= attenuation;
        
        vec3 result = vec3(0.1f) * ambient + diffuse + specular;
        color = vec4(result, 1.0f);

    }else{
        color = vec4(light.ambient * vec3(texture(material.diffuse, TexCoords)), 1.0f);
    }
    }