//
//  WinScene.swift
//  MC03
//
//  Created by Bruno Omella Mainieri on 5/27/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import SpriteKit

class WinScene: SKScene {

    var isLose:Bool! = false
    
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
        //winLabel.text = "Vencemos!"
        self.addChild(winLabel)
        
        if(descobertas.count > 0){
            self.displayDescobertas();
        }
        
        //win
        if isLose == false{
            let fanfare = SKAction.playSoundFileNamed("victory.wav", waitForCompletion: false);
            self.runAction(fanfare);
            
            winLabel.text = "Vencemos! Pontuação: \(score)"
            
            let animLegal = SKAction.animateWithTextures([
                SKTexture(imageNamed: "lex1"),
                SKTexture(imageNamed: "lex2"),
                SKTexture(imageNamed: "lex3")
                ], timePerFrame: 0.2)
            
            let animAction = SKAction.repeatActionForever(animLegal)
            
            lex.runAction(animAction, withKey: "idle")
        }
        else{
            winLabel.text = "Fugimos! Pontuação: \(score)"
            
            lex.xScale = -1.0
            let animLegal = SKAction.animateWithTextures([
                SKTexture(imageNamed: "lex1"),
                SKTexture(imageNamed: "lex1b")
                ], timePerFrame: 0.2)
            
            let animAction = SKAction.repeatActionForever(animLegal)
            
            lex.runAction(animAction, withKey: "idle")
            
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.vc?.performSegueWithIdentifier("gameOverPush", sender: score);
//        var pontuacao = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("pontuacao") as! PontuacaoViewController
//        //pontuacao.recebe = sender as! Int
//        pontuacao.tipoJogo = self.vc.gameType
//        self.vc.navigationController?.popToViewController(pontuacao, animated: true)
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
