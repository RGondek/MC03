//
//  LexicusNode.swift
//  LabelsTest
//
//  Created by Bruno Omella Mainieri on 5/21/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import SpriteKit

class LexicusNode:SKSpriteNode {
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(texture:SKTexture, tam:CGFloat){
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.size = CGSizeMake(tam, tam)
        
    }
    
    func fire(target:SKSpriteNode, tela:SKNode){
        let magicSound = SKAction.playSoundFileNamed("magicSmite.wav", waitForCompletion: false);
        self.runAction(magicSound);
        
        let animation = self.actionForKey("idle")
        self.removeActionForKey("idle")
        
        let animLegal = SKAction.animateWithTextures([
            SKTexture(imageNamed: "lexBook"),
            SKTexture(imageNamed: "lexBook"),
            SKTexture(imageNamed: "lex1")
            ], timePerFrame: 0.5)
        
        self.runAction(animLegal, completion: { () -> Void in
            self.runAction(animation)
        })
        
        let projectile = SKSpriteNode(imageNamed: "projetil")
        projectile.size = CGSizeMake(20, 20)
        projectile.position = CGPointMake(self.position.x + 10, self.position.y)
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.dynamic = false
//        projectile.physicsBody?.categoryBitMask = projectileCategory
//        projectile.physicsBody?.contactTestBitMask = enemyCategory
        tela.addChild(projectile)
        let shotAction = SKAction.moveTo(target.position, duration: 0.5)
        projectile.runAction(shotAction, completion: { () -> Void in
            projectile.removeFromParent()
            var scene = tela.scene as! GameScene
            scene.enemyHit()
        })
    }
    
}
