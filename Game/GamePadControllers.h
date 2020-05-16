//
//  GamePadControllers.hpp
//  UntoldEngine
//
//  Created by Harold Serrano on 2/10/18.
//  Copyright © 2018 Untold Game Studio. All rights reserved.
//

#ifndef GamePadControllers_hpp
#define GamePadControllers_hpp

#include <stdio.h>
#include "U4DGamepadController.h"
#include "U4DVector3n.h"
#include "UserCommonProtocols.h"
#include "U4DPadButton.h"
#include "U4DPadJoystick.h"

class GamePadController:public U4DEngine::U4DGamepadController{
    
private:
    
    
    
public:
    
    GamePadController(){};
    
    
    ~GamePadController(){};
    
    void init();
    
    void actionOnButtonA();
    
    void actionOnButtonB();
    
    void actionOnButtonX();
    
    void actionOnButtonY();
    
    void actionOnLeftTrigger();
    
    void actionOnRightTrigger();
    
    void actionOnLeftShoulder();
    
    void actionOnRightShoulder();
    
    void actionOnDPadUpButton();
    
    void actionOnDPadDownButton();
    
    void actionOnDPadLeftButton();
    
    void actionOnDPadRightButton();
    
    void actionOnLeftJoystick();
    
    void actionOnRightJoystick();
    
};
#endif /* GamePadControllers_hpp */
