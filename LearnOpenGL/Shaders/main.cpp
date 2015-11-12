//
//  main.cpp
//  LearnOpenGL
//
//  Created by guanghui on 11/10/15.
//  Copyright © 2015 guanghui. All rights reserved.
//

#include <iostream>
#include <math.h>
#include "GLFW/glfw3.h"
//include this header for using glGenVertexArrays
#include <OpenGL/gl3.h>
#include "glhelpers.h"

const GLuint WIDTH = 800, HEIGHT = 600;

void key_callback(GLFWwindow* window, int key, int scancode, int action, int mode);

int main(int argc, const char * argv[]) {
    if(!glfwInit()){
        return -1;
    }
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_RESIZABLE, GL_FALSE);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);


    auto window = glfwCreateWindow(WIDTH, HEIGHT, "Shaders", nullptr, nullptr);

    if (nullptr == window) {
        std::cout << "Failed to create GLFW windows" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);

    int actualWidth;
    int actualHeight;
    glfwGetFramebufferSize(window, &actualWidth, &actualHeight);
    glViewport(0, 0, actualWidth, actualHeight);

    glfwSetKeyCallback(window, key_callback);
    
    GLint nrAttributes;
    glGetIntegerv(GL_MAX_VERTEX_ATTRIBS, &nrAttributes);
    std::cout << "Maximum nr of vertex attributes supported: " << nrAttributes << std::endl;
    
    GLuint shaderProgram = createShaderProgramWithFilenames("vertex.vsh", "fragment.fsh");
    
    GLfloat vertices[] = {
        // Positions         // Colors
        0.5f, -0.5f, 0.0f,  1.0f, 0.0f, 0.0f,   // Bottom Right
        -0.5f, -0.5f, 0.0f,  0.0f, 1.0f, 0.0f,   // Bottom Left
        0.0f,  0.5f, 0.0f,  0.0f, 0.0f, 1.0f    // Top
    };
    
    GLuint indices[] = {  // Note that we start from 0!
        0, 1, 2   // First Triangle
    };
    
    GLuint VAO;
    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);
    
    GLuint VBO;
    glGenBuffers(1, &VBO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    GLuint EBO;
    glGenBuffers(1, &EBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
    
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), (GLvoid*)0);
    glEnableVertexAttribArray(0);
    
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), (GLvoid*)(3 * sizeof(GLfloat)));
    glEnableVertexAttribArray(1);

    glBindVertexArray(0);
    
    
//    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

    while (!glfwWindowShouldClose(window)) {
        glfwPollEvents();
        //do rendering
        glClearColor(0.2, 0.3, 0.3, 1.0);
        glClear(GL_COLOR_BUFFER_BIT);
        
//        GLfloat timeValue = glfwGetTime();
//        GLfloat greenValue = (sin(timeValue) / 2) + 0.5;
//        GLint vertexColorLocation = glGetUniformLocation(shaderProgram, "ourColor");
        GLint offsetLocation = glGetUniformLocation(shaderProgram, "offset");

        glUseProgram(shaderProgram);
        
        glUniform1f(offsetLocation, 0.4f);
        
//        glUniform4f(vertexColorLocation, 0.0f, greenValue, 0.0f, 1.0);

        //draw the first triangles
        glBindVertexArray(VAO);
        glDrawElements(GL_TRIANGLES, 3, GL_UNSIGNED_INT, 0);
        glBindVertexArray(0);
    
       
        glfwSwapBuffers(window);
    }

    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
    glDeleteBuffers(1, &EBO);
    glDeleteProgram(shaderProgram);
    
    glfwTerminate();
    return 0;
}


void key_callback(GLFWwindow* window, int key, int scancode, int action, int mode)
{
    // When a user presses the escape key, we set the WindowShouldClose property to true,
    // closing the application
    if(key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
        glfwSetWindowShouldClose(window, GL_TRUE);
}
