//
//  U4DLogger.cpp
//  UntoldEngine
//
//  Created by Harold Serrano on 8/7/16.
//  Copyright © 2016 Untold Engine Studios. All rights reserved.
//

#include "U4DLogger.h"

namespace U4DEngine {

    U4DLogger* U4DLogger::instance=0;
    
    U4DLogger::U4DLogger():debugMode(true){
    }
    
    U4DLogger::~U4DLogger(){
        
    }

    U4DLogger* U4DLogger::sharedInstance(){
        
        if (instance==0) {
            instance=new U4DLogger();
        }

        return instance;
    }
    
    void U4DLogger::log(const char* uLog, ...){
        
        if (debugMode==true) {

            char buffer[1024];
            va_list args;
            va_start (args, uLog);
            vsprintf (buffer,uLog, args);
            
            std::cout<<buffer<<std::endl;
            
            va_end (args);
        
        }
    }
    
    void U4DLogger::setDebugMode(bool uValue){
        debugMode=uValue;
    }
    
}
