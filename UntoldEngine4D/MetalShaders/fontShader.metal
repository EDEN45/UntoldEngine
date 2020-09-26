//
//  fontShader.metal
//  UntoldEngine
//
//  Created by Harold Serrano on 8/19/17.
//  Copyright © 2017 Untold Engine Studios. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

#include <simd/simd.h>
#include "U4DShaderProtocols.h"
#include "U4DShaderHelperFunctions.h"

struct VertexInput {
    
    float4    position [[ attribute(0) ]];
    float2    uv       [[ attribute(1) ]];
    
};

struct VertexOutput{
    
    float4 position [[position]];
    float4 color;
    float2 uvCoords;
    
};

vertex VertexOutput vertexFontImageShader(VertexInput vert [[stage_in]], constant UniformSpace &uniformSpace [[buffer(1)]], uint vid [[vertex_id]]){
    
    VertexOutput vertexOut;
    
    vertexOut.uvCoords=vert.uv;
    
    float4 position=uniformSpace.modelViewProjectionSpace*float4(vert.position);
    
    vertexOut.position=position;
    
    return vertexOut;
}

fragment float4 fragmentFontImageShader(VertexOutput vertexOut [[stage_in]], texture2d<float> texture[[texture(0)]], sampler sam [[sampler(0)]]){
    
    float4 sampledColor=texture.sample(sam,vertexOut.uvCoords);

    return sampledColor;
    
}


