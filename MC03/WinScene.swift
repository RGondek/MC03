//
//  WinScene.swift
//  MC03
//
//  Created by Bruno Omella Mainieri on 5/27/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import SpriteKit

class WinScene: SKScene {
    
    var lex:SKSpriteNode!
    var winLabel:SKLabelNode!
    
    var vc:GameViewController!
    var score:Int!
    
    override func didMoveToView(view: SKView) {
        self.size = view.frame.size
        lex = SKSpriteNode(texture: SKTexture(imageNamed: "lex1"))
        lex.size = CGSizeMake(200, 200)
        lex.position = CGPointMake(self.size.width/2, self.size.height*0.4)
        self.addChild(lex)
        
        winLabel = SKLabelNode(fontNamed: "Helvetica")
        winLabel.position = CGPointMake(self.size.width/2, self.size.height*0.7)
        winLabel.text = "Vencemos!"
        self.addChild(winLabel)
        
        let animLegal = SKAction.animateWithTextures([
            SKTexture(imageNamed: "lex1"),
            SKTexture(imageNamed: "lex2"),
            SKTexture(imageNamed: "lex3")
            ], timePerFrame: 0.2)
        
        let animAction = SKAction.repeatActionForever(animLegal)
        
        lex.runAction(animAction, withKey: "idle")
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.vc?.performSegueWithIdentifier("gameOver", sender: score);
    }
    
}
