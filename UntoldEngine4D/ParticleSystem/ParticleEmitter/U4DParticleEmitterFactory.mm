//
//  U4DParticleEmitterFactory.cpp
//  UntoldEngine
//
//  Created by Harold Serrano on 10/25/17.
//  Copyright © 2017 Untold Engine Studios. All rights reserved.
//

#include "U4DParticleEmitterFactory.h"
#include "U4DParticleEmitterLinear.h"
#include "U4DParticleEmitterTorus.h"
#include "U4DParticleEmitterSphere.h"

namespace U4DEngine {
    
    U4DParticleEmitterFactory::U4DParticleEmitterFactory(){
        
    }
    
    U4DParticleEmitterFactory::~U4DParticleEmitterFactory(){
        
    }
    
    U4DParticleEmitterInterface* U4DParticleEmitterFactory::createEmitter(int uParticleSystemType){
        
        U4DParticleEmitterInterface *particleEmitter=nullptr;
        
        switch (uParticleSystemType) {
            case LINEAREMITTER:

                particleEmitter=new U4DParticleEmitterLinear();
                
                break;
            case TORUSEMITTER:
                
                particleEmitter=new U4DParticleEmitterTorus();
                
                break;
                
            case SPHERICALEMITTER:
                
                particleEmitter=new U4DParticleEmitterSphere();
                
                break;
                
            default:
                break;
                
        }
        
        return particleEmitter;
        
    }
    
}
