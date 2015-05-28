//
//  GameViewController.swift
//  LabelsTest
//
//  Created by Rubens Gondek on 5/14/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    var howToScreen:UIView!
    var gameType:Int = 0 //0 BookWorm, 1 Scramble
    var skView:SKView!
    var inGame:Bool! = false
    var instructions:UILabel!
    var doneLabel:UILabel!
    var ready:Bool! = false
    
    lazy var scene:GameScene = {
        var aux:GameScene
        if self.gameType == 0{
            aux = Bookworm()
        }
        else if self.gameType == 1{
            aux = Scramble()
        } else {
            aux = Scramble();
        }
        aux.vc = self
        return aux
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        skView = SKView()
        skView.frame.size = self.view.frame.size
        self.view.addSubview(skView)
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let nibContents:NSArray = NSBundle.mainBundle().loadNibNamed("HowTo", owner: nil, options: nil)
        howToScreen = nibContents.lastObject as! UIView
        howToScreen.frame = (CGRectMake(50, 50, self.view.frame.size.width-100, self.view.frame.size.height-100))
        self.view.addSubview(howToScreen)
        
        //colocar instruções aqui
//        instructions = UILabel(frame: CGRectMake(self.view.frame.size.width/2 - 175, 300, 350, 150))
//        instructions.text = "Tela de Loading - ainda não implementada."
//        self.view.addSubview(instructions)
        
        
        
        self.doneLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2 - 175, self.view.frame.size.height - 200, 350, 150))
        self.doneLabel.text = "Carregando..."
        self.view.addSubview(self.doneLabel)
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
            self.scene.size = self.view.frame.size
            self.scene.prep()
            self.skView.ignoresSiblingOrder = true
            self.scene.scaleMode = .AspectFill
            sleep(2)
            
            dispatch_async(dispatch_get_main_queue(), {
                println("DONE")
                self.doneLabel.text = "Carregado! Toque para continuar."
                self.ready = true
            })
        })
    }


    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if (!(inGame) && ready == true){
            inGame = true
            let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.3)
            //self.instructions.removeFromSuperview()
            self.howToScreen.removeFromSuperview()
            self.doneLabel.removeFromSuperview()
            self.skView.presentScene(self.scene, transition: transition)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        skView.presentScene(nil)
        var pontuacao = segue.destinationViewController as! PontuacaoViewController
        pontuacao.recebe = sender as! Int
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func showInstructions(){
        //instrucoes do BookWorm
        if gameType == 0 {
            
        }
        
        //instrucoes do Scramble
        if gameType == 1 {
            
        }
    }
    
}
