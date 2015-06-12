//
//  GameControlSingleton.swift
//  MC03
//
//  Created by Bruno Omella Mainieri on 5/26/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import Foundation
import SpriteKit

class GameControlSingleton: NSObject {
    
    static let sharedInstance = GameControlSingleton()
    
    var difficulty:Int = 0
    
    var gameScene:SKScene! = SKScene()
    
    private override init(){
    }
    
    func forcaPausa(){
        if gameScene.isKindOfClass(MC03.GameScene) {
            (gameScene as! GameScene).pausaJogo();
        }
    }
    
    
    
}
