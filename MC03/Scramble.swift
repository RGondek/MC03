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
    var targetPalavra:Palavra!
    
    //colocar na super classe depois
    var letrasSelecionadas:NSMutableArray!
    
    
    override func didMoveToView(view: SKView) {
        self.cols = 5
        self.rows = 3
        
        letrasSelecionadas = NSMutableArray()
        
        self.palavrasBanco = CategoryManager.sharedInstance.fetchWordsForRandomCategory(5)
        prompt = SKLabelNode(fontNamed: "Helvetica")
        prompt.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height*0.8)
        prompt.fontColor = UIColor.blackColor()
        
        
        self.addChild(prompt)

        
        self.setupScene(1)
        
        
        self.setupLex()
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if(self.view!.paused){
            var pausedTime = NSDate().timeIntervalSinceDate(self.pauseTime)
            self.lastUpdateTimeInterval = self.lastUpdateTimeInterval + pausedTime
            self.view?.paused = false;
            self.pauseScreen.hidden = true;
            self.pauseLabel.hidden = true;
        } else {
        if (!perdeu && !venceu){
            
            for touch in (touches as! Set<UITouch>) {
                let location = touch.locationInNode(self)
                let locationGrid = touch.locationInNode(self.tabuleiro)
                
                if let body = physicsWorld.bodyAtPoint(location) {
                    if body.node != nil {
                        if body.node!.name == "letra" {
                            
                            //buscando a letra pela posição do toque na grid, e nao no bodyAtPoint
                            if let tilezinha = self.tabuleiro.tileForCoord(locationGrid.x, y: locationGrid.y){
                                if tilezinha.isActive == true{
                                    if count(curString) > 9 {
                                        self.popScore("Tamanho máximo")
                                    }
                                    else{
                                        self.eventoToque(tilezinha, locationGrid: locationGrid)
                                    }
                                }
                            }
                        }
                        else{
                            if body.node!.name != nil{
                                if body.node!.name == "refresh" {
                                    self.apagar()
                                }
                                if body.node!.name == "home" {
                                    self.goBack()
                                }
                                if body.node!.name == "pause" {
                                    self.pausaJogo();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    }
    
    func eventoToque(tile:Tile, locationGrid:CGPoint){
        let plop = SKAction.playSoundFileNamed("plop.mp3", waitForCompletion: false)
        self.runAction(plop)
        tile.content?.alpha = 0.5
        tile.isActive = false
        let node = tile.content
        letrasSelecionadas.addObject(tile)
        let letra:String = node!.letra
        self.curString = "\(curString)\(letra)"
        self.myLabel.text = curString
        
        for vl in scienceVector{
            if(vl.letra == letra){
                possibleScore += vl.valor;//Adiciona o valor da letra no possivel valor.
                println(possibleScore);
                break;
            }
        }
        
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
            //Muda pra conhecida no banco:
            if(targetPalavra.known == 0){
                descobertas.addObject(targetPalavra.word);
                targetPalavra.known = 1;
                WordManager.sharedInstance.save();
            }
            
            score += Int(timeLeft)*10 * count(palavra) * possibleScore;
            totalScore.text = "\(score)";
            self.popScore("\(Int(timeLeft)*10 * count(palavra) * possibleScore)")
            possibleScore = 0;

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
        targetPalavra = palavrasBanco.objectAtIndex(Int(rand)) as! Palavra
        target = targetPalavra.word.uppercaseString
        //self.prompt.text = target
        self.darDica(targetPalavra)
        
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
            let letraAux:LetraNode = LetraNode(texture: SKTexture(imageNamed: "tile"), letra: seed.objectAtIndex(i) as! String, tam: self.tam)
            letrasFinal.append(letraAux)
        }
        for i in seed.count...(self.tabuleiro.grid.columns*self.tabuleiro.grid.rows)-1 {
            let letraAux = LetraNode(texture: SKTexture(imageNamed: "tile"), letra: self.randomLetra(), tam: self.tam)
            letrasFinal.append(letraAux)
        }
        letrasFinal = letrasFinal.shuffled()
        for i in 0...self.tabuleiro.grid.columns*self.tabuleiro.grid.rows-1 {
            tabuleiro.addLetraNode(i/self.tabuleiro.grid.rows, y: i%self.tabuleiro.grid.rows, letra: letrasFinal[i])
        }
    }
    
    func darDica(word: Palavra){
        
        switch (self.diff){
        case 0:
            prompt.text = word.prompt as String
            break
        case 1:
            prompt.text = word.promptUS as String
            break
        case 2:
            prompt.text = "Categoria: \(word.categoria.nome)"
            break
        default:
            prompt.text = word.prompt as String
            break
        }
        if(count(prompt.text) > 25){
            prompt.fontSize = 24;
        } else {
            prompt.fontSize = 32;//Tamanho padrão
        }
        
    }
    
    

    
}
