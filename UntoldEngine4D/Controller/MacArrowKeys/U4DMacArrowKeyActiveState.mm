//
//  U4DMacArrowKeyActiveState.cpp
//  UntoldEngine
//
//  Created by Harold Serrano on 3/5/18.
//  Copyright © 2018 Untold Engine Studios. All rights reserved.
//

#include "U4DMacArrowKeyActiveState.h"
#include "U4DControllerInterface.h"

namespace U4DEngine {
    
    U4DMacArrowKeyActiveState* U4DMacArrowKeyActiveState::instance=0;
    
    U4DMacArrowKeyActiveState::U4DMacArrowKeyActiveState(){
        
    }
    
    U4DMacArrowKeyActiveState::~U4DMacArrowKeyActiveState(){
        
    }
    
    U4DMacArrowKeyActiveState* U4DMacArrowKeyActiveState::sharedInstance(){
        
        if (instance==0) {
            instance=new U4DMacArrowKeyActiveState();
        }
        
        return instance;
        
    }
    
    void U4DMacArrowKeyActiveState::enter(U4DMacArrowKey *uMacArrowKey){
        
        
    }
    
    void U4DMacArrowKeyActiveState::execute(U4DMacArrowKey *uMacArrowKey, double dt){
        
        U4DEngine::U4DVector2n padAxis(uMacArrowKey->padAxis.x,uMacArrowKey->padAxis.y);
        
        if (uMacArrowKey->dataPosition.dot(padAxis)<0.0) {

            uMacArrowKey->directionReversal=true;

        }else{
            uMacArrowKey->directionReversal=false;

        }
        
        uMacArrowKey->dataPosition=padAxis;
        
        uMacArrowKey->dataMagnitude=padAxis.magnitude();
        
        
        uMacArrowKey->action();
        
        
        if (uMacArrowKey->controllerInterface!=NULL) {
            uMacArrowKey->controllerInterface->setReceivedAction(true);
        }
        
    }
    
    void U4DMacArrowKeyActiveState::exit(U4DMacArrowKey *uMacArrowKey){
        
    }
    
}
