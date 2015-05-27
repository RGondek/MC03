//
//  Scramble.swift
//  LabelsTest
//
//  Created by Bruno Omella Mainieri on 5/18/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import SpriteKit

class Scramble:GameScene {
    var prompt:SKLabelNode!
    
    var palavrasBanco:NSMutableArray!
    
    var target:String!
    
    //colocar na super classe depois
    var letrasSelecionadas:NSMutableArray!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.cols = 5
        self.rows = 3
        
//        self.size = view.frame.size
//        myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.name = "label"
//        myLabel.physicsBody = SKPhysicsBody(rectangleOfSize: myLabel.frame.size)
//        myLabel.physicsBody?.dynamic = false
//        myLabel.text = curString
//        myLabel.fontSize = 65;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:100);
//        
//        self.addChild(myLabel)
//        
//        prompt = SKLabelNode(fontNamed: "Helvetica")
//        prompt.position = CGPointMake(self.size.width/2, self.size.height * 0.7)
//        
//        self.addChild(prompt)
//
//        tabuleiro = Tabuleiro(x: 5, y: 3, tamanho: tam)
//        tabuleiro.position = CGPointMake(self.size.width/2 - tam*5/2, self.size.height * 0.18)
//        self.addChild(tabuleiro)
//        
//        self.palavrasBanco = CategoryManager.sharedInstance.fetchWordsForCategory(5, categoryName: "Frutas")
//        
//        self.encheLetras(seedar(3))
//        
//        timeLabel = SKLabelNode(fontNamed: "Comic Sans")//AYY
//        timeLabel.position = CGPointMake(self.frame.size.width * 0.1, self.frame.size.height * 0.9);
        
        letrasSelecionadas = NSMutableArray()
        
        self.palavrasBanco = CategoryManager.sharedInstance.fetchWordsForCategory(5, categoryName: "Frutas")
        prompt = SKLabelNode(fontNamed: "Helvetica")
        prompt.position = CGPointMake(self.size.width/2, self.size.height * 0.7)
        
        self.addChild(prompt)

        
        self.setupScene(1)
        
        
        self.setupLex()
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if (!perdeu && !venceu){
            
            for touch in (touches as! Set<UITouch>) {
                let location = touch.locationInNode(self)
                let locationGrid = touch.locationInNode(self.tabuleiro)
                
                if let body = physicsWorld.bodyAtPoint(location) {
                    if body.node!.name == "letra" {
                        
                        //buscando a letra pela posição do toque na grid, e nao no bodyAtPoint
                        if let tilezinha = self.tabuleiro.tileForCoord(locationGrid.x, y: locationGrid.y){
                            if tilezinha.isActive == true{
//                            tabuleiro.tileForCoord(locationGrid.x, y: locationGrid.y)!.content?.alpha = 0.5
//                            let nodinho = tilezinha.content
//                            let letrinha:String = nodinho!.letra
//                            self.validaLetra(letrinha)
//                            self.curString = "\(curString)\(letrinha)"
//                            self.myLabel.text = curString
//                            self.myLabel.physicsBody = SKPhysicsBody(rectangleOfSize: myLabel.frame.size)
//                            myLabel.physicsBody?.dynamic = false
                            self.eventoToque(tilezinha, locationGrid: locationGrid)
                            }
                        }
                    }
                    if body.node!.name == "refresh" {
                        self.apagar()
                    }
                }
            }
        }
    }
    
    func eventoToque(tile:Tile, locationGrid:CGPoint){
        tile.content?.alpha = 0.5
        tile.isActive = false
        let node = tile.content
        letrasSelecionadas.addObject(tile)
        let letra:String = node!.letra
        self.curString = "\(curString)\(letra)"
        self.myLabel.text = curString
        self.myLabel.physicsBody = SKPhysicsBody(rectangleOfSize: myLabel.frame.size)
        myLabel.physicsBody?.dynamic = false
        self.validaPalavra(myLabel.text)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            let locationGrid = touch.locationInNode(self.tabuleiro)
            if let tile = tabuleiro.tileForCoord(locationGrid.x, y: locationGrid.y) {
                //tile.content?.alpha = 1.0
            }
        }
    }
    
    override func validaPalavra(palavra: String) {
        if palavra == target {
            //self.popScore("👍+8001!")
            popScore("ACERTOU!")
            self.player.fire(self.enemy!, tela: self.telaNode)
            self.trocaLetras()
            self.curString = ""
            self.myLabel.text = ""
        }
    }
    
    override func trocaLetras() {
        //precisa trocar aqui
        self.tabuleiro.esvazia()
        self.encheLetras(self.seedar(1))
    }
    
    func validaLetra(letra: String) {
        let auxPalavra = "\(curString)\(letra)"
        if target == auxPalavra {
            popScore("ACERTOU!")
            self.player.fire(self.enemy!, tela: self.telaNode)
            self.trocaLetras()
            self.curString = ""
            self.myLabel.text = ""
        }
        if !target.hasPrefix(auxPalavra){
            //popScore("ERROU!")
        }
        
    }
    
    func apagar(){
        curString = ""
        possibleScore = 0;
        for tile in letrasSelecionadas {
            //jesus
            let tileAux = tile as! Tile
            tileAux.isActive = true
            tileAux.content!.alpha = 1.0
        }
        self.myLabel.text = ""
        letrasSelecionadas = NSMutableArray()
    }
    
    override func popScore(score:String){
        let scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.text = score
        scoreLabel.position = CGPointMake(self.size.width/2, self.size.height*0.2)
        scoreLabel.fontColor = UIColor.redColor()
        let fadeAction = SKAction.fadeOutWithDuration(1.5)
        let moveAction = SKAction.moveToY(self.size.height*0.8, duration: 1.5)
        self.addChild(scoreLabel)
        scoreLabel.runAction(moveAction)
        scoreLabel.runAction(fadeAction, completion: { () -> Void in
            scoreLabel.removeFromParent()
        })
    }
    
    override func seedar(num:Int) -> NSMutableArray{
        
        //define as palavras para seedar
        var letrasSeedadas:NSMutableArray = NSMutableArray()
        let rand = arc4random_uniform(UInt32(palavrasBanco.count-1))
        target = (palavrasBanco.objectAtIndex(Int(rand)) as! Palavra).word
        self.prompt.text = target
        
        
        //garante que as letras apareçam na tela
        let letras = Array(target)
        for letra in letras {
            let letraStr = "\(letra)"
            letrasSeedadas.addObject(letraStr)
        }
        
        return letrasSeedadas
        
    }
    
    override func encheLetras(seed:NSMutableArray) {
        var letrasFinal = Array<LetraNode>()
        for i in 0...seed.count-1 {
            let letraAux:LetraNode = LetraNode(texture: SKTexture(imageNamed: "square"), letra: seed.objectAtIndex(i) as! String, tam: self.tam)
            letrasFinal.append(letraAux)
        }
        for i in seed.count...(self.tabuleiro.grid.columns*self.tabuleiro.grid.rows)-1 {
            let letraAux = LetraNode(texture: SKTexture(imageNamed: "square"), letra: self.randomLetra(), tam: self.tam)
            letrasFinal.append(letraAux)
        }
        letrasFinal = letrasFinal.shuffled()
        for i in 0...self.tabuleiro.grid.columns*self.tabuleiro.grid.rows-1 {
            tabuleiro.addLetraNode(i/self.tabuleiro.grid.rows, y: i%self.tabuleiro.grid.rows, letra: letrasFinal[i])
        }
    }
    
    

    
}
