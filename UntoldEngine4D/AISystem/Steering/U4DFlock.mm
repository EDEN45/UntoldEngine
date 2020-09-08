//
//  U4DFlock.cpp
//  UntoldEngine
//
//  Created by Harold Serrano on 4/14/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#include "U4DFlock.h"
#include "U4DDynamicModel.h"
#include "U4DSeparation.h"
#include "U4DAlign.h"
#include "U4DCohesion.h"
#include "Constants.h"

namespace U4DEngine {

    U4DFlock::U4DFlock(){
            
        }

    U4DFlock::~U4DFlock(){
        
    }


    U4DVector3n U4DFlock::getSteering(U4DDynamicModel *uPursuer, std::vector<U4DDynamicModel*> uNeighborsContainer){
        
        U4DSeparation separationBehavior;
        U4DAlign alignBehavior;
        U4DCohesion cohesionBehavior;
        
        //set max speed
        separationBehavior.setMaxSpeed(maxSpeed);
        alignBehavior.setMaxSpeed(maxSpeed);
        cohesionBehavior.setMaxSpeed(maxSpeed);
        
        U4DVector3n separationDesiredVelocity=separationBehavior.getSteering(uPursuer,uNeighborsContainer);
        U4DVector3n cohesionDesiredVelocity=cohesionBehavior.getSteering(uPursuer,uNeighborsContainer);
        U4DVector3n alignDesiredVelocity=alignBehavior.getSteering(uPursuer,uNeighborsContainer);
        
        U4DVector3n finalDesiredVelocity;
        
        //Priorities: 1. Separation. 2. Alignment. 3. Cohesion
        if(separationDesiredVelocity.magnitudeSquare()>U4DEngine::zeroEpsilon) {

            finalDesiredVelocity=separationDesiredVelocity;

        }else if(alignDesiredVelocity.magnitudeSquare()>U4DEngine::zeroEpsilon) {

            finalDesiredVelocity=alignDesiredVelocity;

        }else{

            finalDesiredVelocity=cohesionDesiredVelocity;
        }
        
        finalDesiredVelocity=(separationDesiredVelocity+alignDesiredVelocity+cohesionDesiredVelocity)*0.33;
        
        return finalDesiredVelocity;
        
    }

    void U4DFlock::setMaxSpeed(float uMaxSpeed){
        
        maxSpeed=uMaxSpeed;
        
    }

}
