//
//  Rocket.cpp
//  UntoldEngine
//
//  Created by Harold Serrano on 8/4/16.
//  Copyright © 2016 Untold Game Studio. All rights reserved.
//

#include "Rocket.h"
#include "U4DDigitalAssetLoader.h"

Rocket::Rocket(){
    
}

Rocket::~Rocket(){
    
}

void Rocket::init(const char* uName, const char* uBlenderFile){
    
    if (loadModel(uName, uBlenderFile)) {
        
        //initialize everything else here
        //translateBy(2.0,0.0,0.0);
        //rotateTo(0.0, 5.0, 0.0);
        enableCollisionBehavior();
        enableKineticsBehavior();
        //setBroadPhaseBoundingVolumeVisibility(true);
        setShader("gouraudShader");
        
    }
    
    
}

void Rocket::update(double dt){
    
        //rotateBy(0.0,1.0,0.0);
}