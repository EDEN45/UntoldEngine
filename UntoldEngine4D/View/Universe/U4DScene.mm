//
//  U4DScene.cpp
//  MVCTemplate
//
//  Created by Harold Serrano on 4/23/13.
//  Copyright (c) 2013 Untold Engine Studios. All rights reserved.
//

#include "U4DScene.h"
#include "U4DWorld.h"
#include "U4DDirector.h"
#include "U4DTouches.h"

namespace U4DEngine {
    
    //constructor
    U4DScene::U4DScene(){
        
        

    };

    //destructor
    U4DScene::~U4DScene(){
        
        

    };

    void U4DScene::setGameWorldControllerAndModel(U4DWorld *uGameWorld,U4DControllerInterface *uGameController, U4DGameModelInterface *uGameModel){
        
        U4DDirector *director=U4DDirector::sharedInstance();
        director->setScene(this);
        
        gameWorld=uGameWorld;
        gameController=uGameController;
        gameModel=uGameModel;
        
        gameWorld->setGameController(gameController);
        gameWorld->setGameModel(gameModel);
        
        gameController->setGameWorld(uGameWorld);
        gameController->setGameModel(gameModel);
        
        gameModel->setGameWorld(gameWorld);
        gameModel->setGameController(uGameController);
        gameModel->setGameEntityManager(gameWorld->getEntityManager());
        
        gameWorld->init();
        gameController->init();
        gameModel->init();
    
    }


    void U4DScene::update(float dt){
        
        gameModel->update(dt);
        
        //update the entity manager
        gameWorld->entityManager->update(dt); //need to add dt to view
        
    }

    void U4DScene::render(id <MTLRenderCommandEncoder> uRenderEncoder){

        gameWorld->entityManager->render(uRenderEncoder);
        
    }
    
    void U4DScene::renderShadow(id <MTLRenderCommandEncoder> uRenderShadowEncoder, id<MTLTexture> uShadowTexture){
        
        gameWorld->entityManager->renderShadow(uRenderShadowEncoder, uShadowTexture);
    }


    void U4DScene::determineVisibility(){
        
        gameWorld->entityManager->determineVisibility();
        
    }
    
    void U4DScene::touchBegan(const U4DTouches &touches){
        
        gameController->touchBegan(touches);
    }

    void U4DScene::touchEnded(const U4DTouches &touches){
        
        gameController->touchEnded(touches);
    }

    void U4DScene::touchMoved(const U4DTouches &touches){
        
        gameController->touchMoved(touches);
    }
    
    void U4DScene::padPressBegan(GAMEPADELEMENT &uGamePadElement, GAMEPADACTION &uGamePadAction){
        
        gameController->padPressBegan(uGamePadElement, uGamePadAction);
    }
    
    void U4DScene::padPressEnded(GAMEPADELEMENT &uGamePadElement, GAMEPADACTION &uGamePadAction){
        
        gameController->padPressEnded(uGamePadElement, uGamePadAction);
    }
    
    void U4DScene::padThumbStickMoved(GAMEPADELEMENT &uGamePadElement, GAMEPADACTION &uGamePadAction, const U4DPadAxis &uPadAxis){
        
        gameController->padThumbStickMoved(uGamePadElement, uGamePadAction, uPadAxis);
    }
    
    void U4DScene::macKeyPressBegan(KEYBOARDELEMENT &uKeyboardElement, KEYBOARDACTION &uKeyboardAction){
        
        gameController->macKeyPressBegan(uKeyboardElement, uKeyboardAction);
        
    }
    
    void U4DScene::macKeyPressEnded(KEYBOARDELEMENT &uKeyboardElement, KEYBOARDACTION &uKeyboardAction){
        
        gameController->macKeyPressEnded(uKeyboardElement, uKeyboardAction);
        
    }
    
    void U4DScene::macArrowKeyActive(KEYBOARDELEMENT &uKeyboardElement, KEYBOARDACTION &uKeyboardAction, U4DVector2n & uPadAxis){
        
        gameController->macArrowKeyActive(uKeyboardElement, uKeyboardAction, uPadAxis);
        
    }
    
    void U4DScene::macMousePressBegan(MOUSEELEMENT &uMouseElement, MOUSEACTION &uMouseAction, U4DVector2n & uMouseAxis){
        
        gameController->macMousePressBegan(uMouseElement, uMouseAction, uMouseAxis);
    }
    
    void U4DScene::macMousePressEnded(MOUSEELEMENT &uMouseElement, MOUSEACTION &uMouseAction){
        
        gameController->macMousePressEnded(uMouseElement, uMouseAction);
    }
    
    void U4DScene::macMouseDragged(MOUSEELEMENT &uMouseElement, MOUSEACTION &uMouseAction, U4DVector2n & uMouseAxis){
        
        gameController->macMouseDragged(uMouseElement, uMouseAction, uMouseAxis);
    }
    
    void U4DScene::macMouseMoved(MOUSEELEMENT &uMouseElement, MOUSEACTION &uMouseAction, U4DVector2n & uMouseAxis){
        
        gameController->macMouseMoved(uMouseElement, uMouseAction, uMouseAxis);
    }
    
    void U4DScene::macMouseDeltaMoved(MOUSEELEMENT &uMouseElement, MOUSEACTION &uMouseAction, U4DVector2n & uMouseDelta){
        
        gameController->macMouseDeltaMoved(uMouseElement, uMouseAction, uMouseDelta);
    }
    
    void U4DScene::macMouseExited(MOUSEELEMENT &uMouseElement, MOUSEACTION &uMouseAction, U4DVector2n & uMouseAxis){
        
        gameController->macMouseExited(uMouseElement, uMouseAction, uMouseAxis);
    }

    void U4DScene::init(){
        
    }
    
}

