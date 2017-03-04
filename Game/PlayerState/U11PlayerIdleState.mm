//
//  U11PlayerIdleState.cpp
//  UntoldEngine
//
//  Created by Harold Serrano on 2/18/17.
//  Copyright © 2017 Untold Game Studio. All rights reserved.
//

#include "U11PlayerIdleState.h"
#include "U11PlayerChaseBallState.h"
#include "U11PlayerReceiveBallState.h"

U11PlayerIdleState* U11PlayerIdleState::instance=0;

U11PlayerIdleState::U11PlayerIdleState(){
    
}

U11PlayerIdleState::~U11PlayerIdleState(){
    
}

U11PlayerIdleState* U11PlayerIdleState::sharedInstance(){
    
    if (instance==0) {
        instance=new U11PlayerIdleState();
    }
    
    return instance;
    
}

void U11PlayerIdleState::enter(U11Player *uPlayer){
    
    //set the standing animation
    uPlayer->setNextAnimationToPlay(uPlayer->getIdleAnimation());
}

void U11PlayerIdleState::execute(U11Player *uPlayer, double dt){
    
    //track the ball
    uPlayer->seekBall();
    
    if (uPlayer->getJoystickActive()) {
        
        U11PlayerChaseBallState *chaseBallState=U11PlayerChaseBallState::sharedInstance();
        
        uPlayer->changeState(chaseBallState);
    }
    
    if (uPlayer->getButtonAPressed()) {
        
        uPlayer->changeState(U11PlayerReceiveBallState::sharedInstance());
    }
}

void U11PlayerIdleState::exit(U11Player *uPlayer){
    
}

bool U11PlayerIdleState::isSafeToChangeState(U11Player *uPlayer){
    
    return true;
}
