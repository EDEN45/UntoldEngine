//
//  U4DFlock.hpp
//  UntoldEngine
//
//  Created by Harold Serrano on 4/14/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#ifndef U4DFlock_hpp
#define U4DFlock_hpp

#include <stdio.h>
#include <vector>
#include "U4DDynamicModel.h"

namespace U4DEngine {
 
    /**
     @ingroup artificialintelligence
     @brief The U4DFlock class implements AI steering separation behavior
     */
    class U4DFlock {
        
    private:
        
        /**
         @brief maximum speed for steering
         */
        float maxSpeed;
        
        float desiredSeparation;
        
        float neighborDistanceAlignment;
        
        float neighborDistanceCohesion;
        
    public:
        
        /**
         @brief class construtor
         */
        U4DFlock();
        
        /**
         @brief class destructor
         */
        ~U4DFlock();
        
        /**
         @brief Computes the velocity for steering
         
         @param uPursuer 3D model represented as the pursuer
         @param uPursuer neighbor vehicles container
         @return velocity vector to apply to 3D model
         */
        U4DVector3n getSteering(U4DDynamicModel *uPursuer, std::vector<U4DDynamicModel*> uNeighborsContainer);
        
        /**
         @brief sets the maximum speed for steering

         @param uMaxSpeed maximum steering speed
         */
        void setMaxSpeed(float uMaxSpeed);
        
        /**
         @brief Sets the corresponding separation, alignment and cohesion neighbor distance
         
         @param uNeighborSeparationDistance Distance for neighbor separation
         @param uNeighborAlignDistance Distance for neighbor alignment
         @param uNeighborCohesionDistance Distance for neighbor cohesion
         */
        void setNeighborsDistance(float uNeighborSeparationDistance, float uNeighborAlignDistance, float uNeighborCohesionDistance);
        
    };
    
}
#endif /* U4DFlock_hpp */
