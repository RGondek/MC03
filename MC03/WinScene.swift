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
    
    var descobertas: NSMutableArray!
    
    override func didMoveToView(view: SKView) {
        self.size = view.frame.size
        lex = SKSpriteNode(texture: SKTexture(imageNamed: "lex1"))
        lex.size = CGSizeMake(200, 200)
        lex.position = CGPointMake(self.size.width/2, self.size.height*0.7)
        self.addChild(lex)
        
        winLabel = SKLabelNode(fontNamed: "Helvetica")
        winLabel.position = CGPointMake(self.size.width/2, self.size.height*0.9)
        winLabel.text = "Vencemos!"
        self.addChild(winLabel)
        
        let animLegal = SKAction.animateWithTextures([
            SKTexture(imageNamed: "lex1"),
            SKTexture(imageNamed: "lex2"),
            SKTexture(imageNamed: "lex3")
            ], timePerFrame: 0.2)
        
        let animAction = SKAction.repeatActionForever(animLegal)
        
        lex.runAction(animAction, withKey: "idle")
        
        if(descobertas.count > 0){
            self.displayDescobertas();
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.vc?.performSegueWithIdentifier("gameOver", sender: score);
    }
    
    func displayDescobertas(){
        var cont = 1;
        let labela : SKLabelNode = SKLabelNode(text: "Palavras Descobertas");
        labela.position = CGPointMake(self.size.width/2, self.size.height/2);
        labela.fontName = "Helvetica-Bold";
        self.addChild(labela);
        for palavra in descobertas {
            let lab : SKLabelNode  = SKLabelNode(text: palavra as! String);
            lab.position = CGPointMake(self.size.width / 2, CGFloat((self.size.height * 0.35) - CGFloat(cont * 50)));
            cont++;
            self.addChild(lab);
        }
        
    }
}
