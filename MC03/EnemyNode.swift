
//
//  EnemyNode.swift
//  LabelsTest
//
//  Created by Bruno Omella Mainieri on 5/21/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import SpriteKit

class EnemyNode:SKSpriteNode {
    
    //intervalo entre disparos
    let INTERVAL:Double = 5.0
    
    var reloadTime:Double = 5.0
    
    var movendo = false;
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(texture:SKTexture, tam:CGFloat){
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.size = CGSizeMake(tam, tam)
        self.reloadTime = 5.0
        
    }
    
    func runBehavior(scene:SKScene) {
        let gameScene = scene as! GameScene
        //Tá dando ruim por causa do timeSinceLast após pausa.
        self.reload(gameScene.timeSinceLast)
        self.avancar()
        
    }
    
    func avancar(){
        if reloadTime <= 0.0 {
            if(!movendo){
                movendo = true;
            let animLegal = SKAction.animateWithTextures([
                SKTexture(imageNamed: "enemyUp1"),
                SKTexture(imageNamed: "enemyUp1"),
                SKTexture(imageNamed: "enemyUp2"),
                SKTexture(imageNamed: "enemyUp2"),
                SKTexture(imageNamed: "enemyDown1"),
                SKTexture(imageNamed: "enemyDown1"),
                SKTexture(imageNamed: "enemyDown2"),
                SKTexture(imageNamed: "enemyDown2"),
                SKTexture(imageNamed: "enemy1")
                ], timePerFrame: 0.1)
            //self.runAction(animLegal)
                self.runAction(animLegal, completion: { () -> Void in
                    self.movendo = false;
                })
            let jumpAction = SKAction.sequence([SKAction.moveBy(CGVectorMake(-40, 30), duration: 0.4), SKAction.moveBy(CGVectorMake(-40, -30), duration: 0.4)])
            //let moveAction = SKAction.moveTo(CGPointMake(self.position.x - 80, self.position.y), duration: 0.8)
            self.runAction(jumpAction)
            self.reloadTime = self.INTERVAL
            }
        }
        
    }
    
    func reload(time:NSTimeInterval){
        if reloadTime > 0.0 {
            reloadTime -= time
        }
    }
    
    func getHit(){
        //animacoes e tal
        self.removeFromParent()
    }
    
}
