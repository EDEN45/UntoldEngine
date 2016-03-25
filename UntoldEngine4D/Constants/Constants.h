//
//  Constants.h
//  UntoldEngine
//
//  Created by Harold Serrano on 6/21/13.
//  Copyright (c) 2013 Untold Story Studio. All rights reserved.
//

#ifndef UntoldEngine_Constants_h
#define UntoldEngine_Constants_h

namespace U4DEngine {
    
    const float PI=3.141592653589793;
    const float sleepEpsilon=0.2;
    const float baseBias=0.1;
    const float collisionDistanceEpsilon=1.0e-4f;
    const float collisionTimeEpsilon=0.1;
    const float minimumTimeOfImpact=0.1;
    const float motionEpsilon=180.0;
    const float velocityEpsilon=0.0005;
    const float barycentricEpsilon=1.0;
    const float timeStep=0.01;
}

#define DegreesToRad(angle) angle*M_PI/180
#define RadToDegrees(angle) angle*180/M_PI

#define DEPTHSHADOWWIDTH 1024
#define DEPTHSHADOWHEIGHT 1024

#endif
