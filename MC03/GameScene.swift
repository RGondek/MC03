//
//  GameScene.swift
//  LabelsTest
//
//  Created by Rubens Gondek on 5/14/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import SpriteKit

extension Array {
    func shuffled() -> [T] {
        var list = self
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
    
    func pegaValor() -> Int {
        return 0;
    }
}

class ValorLetra : NSObject {
    var valor : Int;
    var letra : String;

    
    init(valor: Int, letra: String) {
        self.valor = valor;
        self.letra = letra;
    }
}

class GameScene: SKScene {
    var vc : GameViewController?
    
    //Palavras que o jogador descobriu nessa rodada.
    var descobertas:NSMutableArray!
    
    var homeButton:SKSpriteNode!
    var promptLabel:SKLabelNode!
    var curString:String = "" //Palavra sendo formada
    var myLabel:SKLabelNode!
    var reButton:SKSpriteNode!
    var tam:CGFloat = CGFloat(70) //Tamanho dos quadrados
    var cols:Int = 8
    var rows:Int = 8
    
    //Para uso do timer
    var timeLabel : SKLabelNode!;
    var timeLeft = 10.00//Tempo inicial
    var totalScore : SKLabelNode!;
    var lastUpdate : NSTimeInterval = 0
    
    var diff:Int! = 0
    
    //Pontuação do jogador
    var score = 0;
    var possibleScore = 0;
    
    var enemiesDefeated:Int = 0
    var perdeu = false
    var venceu = false
    
    //da tela do Lexicus
    var enemy:EnemyNode? = nil
    var player:LexicusNode!
    var telaNode:SKSpriteNode!

    var scienceVector = [ValorLetra(valor: 1, letra: "A"), ValorLetra(valor: 1, letra: "A"), ValorLetra(valor: 1, letra: "A"), ValorLetra(valor: 1, letra: "A"), ValorLetra(valor: 2, letra: "B"), ValorLetra(valor: 2, letra: "B"), ValorLetra(valor: 2, letra: "C"), ValorLetra(valor: 2, letra: "C"), ValorLetra(valor: 1, letra: "D"), ValorLetra(valor: 1, letra: "D"), ValorLetra(valor: 1, letra: "D"), ValorLetra(valor: 1, letra: "E"), ValorLetra(valor: 1, letra: "E"), ValorLetra(valor: 1, letra: "E"), ValorLetra(valor: 1, letra: "E"), ValorLetra(valor: 1, letra: "E"), ValorLetra(valor: 2, letra: "F"), ValorLetra(valor: 2, letra: "F"), ValorLetra(valor: 2, letra: "G"), ValorLetra(valor: 2, letra: "G"), ValorLetra(valor: 1, letra: "H"), ValorLetra(valor: 1, letra: "H"), ValorLetra(valor: 1, letra: "H"), ValorLetra(valor: 1, letra: "I"), ValorLetra(valor: 1, letra: "I"), ValorLetra(valor: 1, letra: "I"), ValorLetra(valor: 3, letra: "J"), ValorLetra(valor: 3, letra: "K"), ValorLetra(valor: 2, letra: "L"), ValorLetra(valor: 2, letra: "L"), ValorLetra(valor: 2, letra: "M"), ValorLetra(valor: 2, letra: "M"), ValorLetra(valor: 2, letra: "N"), ValorLetra(valor: 2, letra: "N"), ValorLetra(valor: 1, letra: "O") , ValorLetra(valor: 1, letra: "O"), ValorLetra(valor: 1, letra: "O"), ValorLetra(valor: 2, letra: "P"), ValorLetra(valor: 2, letra: "P"), ValorLetra(valor: 3, letra: "Q"), ValorLetra(valor: 2, letra: "R"), ValorLetra(valor: 2, letra: "R"), ValorLetra(valor: 1, letra: "S"), ValorLetra(valor: 1, letra: "S"), ValorLetra(valor: 1, letra: "S"), ValorLetra(valor: 1, letra: "T"), ValorLetra(valor: 1, letra: "T"), ValorLetra(valor: 1, letra: "T"), ValorLetra(valor: 1, letra: "T"), ValorLetra(valor: 2, letra: "U"), ValorLetra(valor: 2, letra: "U"), ValorLetra(valor: 3, letra: "V"), ValorLetra(valor: 2, letra: "W"), ValorLetra(valor: 2, letra: "W"), ValorLetra(valor: 3, letra: "X"), ValorLetra(valor: 3, letra: "Y"), ValorLetra(valor: 3, letra: "Z")];//Puta vida. Conferir se valores estão todos certos
    
    var palavrasTeste = ["English", "Potato", "Pirate", "Lexicus", "Dog", "Car", "Cheese", "Rubens", "Word", "Ayylmao"]
    
    var tabuleiro:Tabuleiro!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.setupScene(2)//Parametro de quantas palavras serão seedadas.
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            let locationGrid = touch.locationInNode(self.tabuleiro)
            
            if let body = physicsWorld.bodyAtPoint(location) {
                if body.node!.name == "letra" {
                    
                    if let tilezinha = self.tabuleiro.tileForCoord(locationGrid.x, y: locationGrid.y){
                        if count(curString) > 9 {
                            self.popScore("Tamanho máximo")
                        }
                        else{
                            tabuleiro.tileForCoord(locationGrid.x, y: locationGrid.y)!.content?.alpha = 0.5
                            let nodinho = tilezinha.content
                            let letrinha:String = nodinho!.letra
                            println(letrinha)
                            self.curString = "\(curString)\(letrinha)"
                            self.myLabel.text = curString
                            self.myLabel.physicsBody = SKPhysicsBody(rectangleOfSize: myLabel.frame.size)
                            myLabel.physicsBody?.dynamic = false
                        }
                    }

                }
                if body.node!.name == "label" {
                    let nodelinho: SKLabelNode = body.node! as! SKLabelNode
                    //consultarDicionario(nodelinho.text)
                    validaPalavra(nodelinho.text)
                    curString = ""
                }
                if body.node!.name == "refresh" {
                    self.trocaLetras()
                }
            }
            
        }
    }
    
    func prep(){
        
    }
    
    func setupScene(num:Int){
        descobertas = NSMutableArray();

        //self.size = view!.frame.size
        diff = GameControlSingleton.sharedInstance.difficulty
        
        myLabel = SKLabelNode(fontNamed:"Helvetica")
        myLabel.name = "label"
        myLabel.physicsBody = SKPhysicsBody(rectangleOfSize: myLabel.frame.size)
        myLabel.physicsBody?.dynamic = false
        myLabel.text = curString
        myLabel.fontSize = 65;
        myLabel.fontColor = UIColor.blackColor()
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:100);
        
        let labelBg = SKSpriteNode(imageNamed: "scroll")
        labelBg.name = "labelBg"
        labelBg.size = CGSizeMake(self.size.width*0.8, 80)
        labelBg.position = CGPointMake(myLabel.position.x, myLabel.position.y + 15)
        
        self.addChild(myLabel)
        self.addChild(labelBg)
        
        reButton = SKSpriteNode(imageNamed: "eraser")
        reButton.name = "refresh"
        reButton.size = CGSizeMake(80, 80)
        reButton.physicsBody = SKPhysicsBody(rectangleOfSize: reButton.size)
        reButton.physicsBody?.dynamic = false
        reButton.position = CGPointMake(50, 50)
        
        self.addChild(reButton)
        
        
        tabuleiro = Tabuleiro(x: cols, y: rows, tamanho: tam)
        tabuleiro.position = CGPointMake(self.size.width/2 - tam * CGFloat(cols) / 2, self.size.height * 0.18)
        self.addChild(tabuleiro)
        
        //self.encheLetras()
        self.encheLetras(seedar(num))
        
        promptLabel = SKLabelNode(fontNamed: "Helvetica")
        promptLabel.text = ""
        promptLabel.fontColor = UIColor.blackColor()
        promptLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height*0.8)
        promptLabel.physicsBody = SKPhysicsBody(rectangleOfSize: promptLabel.frame.size)
        promptLabel.physicsBody?.dynamic = false
        
        let promptBg = SKSpriteNode(imageNamed: "scroll")
        promptBg.name = "promptBg"
        promptBg.size = CGSizeMake(self.size.width*0.8, 80)
        promptBg.position = CGPointMake(promptLabel.position.x, promptLabel.position.y + 15)
        
        self.addChild(promptBg)
        self.addChild(promptLabel)
        
        
        timeLabel = SKLabelNode(fontNamed: "Comic Sans")//AYY
        timeLabel.position = CGPointMake(self.frame.size.width * 0.1, self.frame.size.height * 0.9);
        self.addChild(timeLabel);
        
        totalScore = SKLabelNode(fontNamed: "Comic Sans")//AYY
        totalScore.position = CGPointMake(self.frame.size.width * 0.9, self.frame.size.height * 0.9);
        totalScore.text = "0";
        self.addChild(totalScore);
    }
    
    func setupLex(){
        telaNode = SKSpriteNode(imageNamed: "square")
        telaNode.size = CGSizeMake(self.size.width*0.8, self.size.height*0.15)
        telaNode.position = CGPointMake(self.size.width/2, self.size.height - self.telaNode.size.height/2)
        self.addChild(telaNode)
        
        player = LexicusNode(texture: SKTexture(imageNamed: "lex1"), tam: 80)
        player.size = CGSizeMake(100, 100)
        player.position = CGPointMake(-telaNode.size.width/2 + CGFloat(55), -telaNode.size.height/2 + CGFloat(55))
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody?.dynamic = false
//        player.physicsBody?.categoryBitMask = playerCategory
//        player.physicsBody?.contactTestBitMask = enemyCategory
        telaNode.addChild(player)
        
        homeButton = SKSpriteNode(imageNamed: "home")
        homeButton.name = "home"
        homeButton.position = CGPointMake((telaNode.position.x - telaNode.size.width/2)/2, telaNode.position.y)
        homeButton.size = CGSizeMake((telaNode.position.x - telaNode.size.width/2), (telaNode.position.x - telaNode.size.width/2))
        homeButton.physicsBody = SKPhysicsBody(rectangleOfSize: homeButton.size)
        homeButton.physicsBody?.dynamic = false
        self.addChild(homeButton)
        
        let animLegal = SKAction.animateWithTextures([
            SKTexture(imageNamed: "lex1"),
            SKTexture(imageNamed: "lex1b"),
            SKTexture(imageNamed: "lex1")
            ], timePerFrame: 1.5)
        
        let animAction = SKAction.repeatActionForever(animLegal)
        
        player.runAction(animAction, withKey: "idle")
        
        self.createEnemy()
    }
    
    func createEnemy(){
        if enemy == nil  && !venceu && !perdeu{
            enemy = EnemyNode(texture: SKTexture(imageNamed: "enemy1"), tam: CGFloat(40))
            enemy?.name = "enemy"
            enemy!.size = CGSizeMake(40, 40)
            enemy!.position = CGPointMake(telaNode.size.width/2 - CGFloat(40), -telaNode.size.height/2 + CGFloat(20))
            enemy!.physicsBody = SKPhysicsBody(rectangleOfSize: enemy!.size)
            enemy!.physicsBody?.dynamic = false
//            enemy!.physicsBody?.categoryBitMask = enemyCategory
//            enemy!.physicsBody?.contactTestBitMask = playerCategory | projectileCategory
            telaNode.addChild(enemy!)
        }
    }
    
    func enemyHit(){
        
        self.telaNode.childNodeWithName("enemy")?.removeFromParent()
        enemy = nil
        
        self.enemiesDefeated++
        if enemiesDefeated >= 2 {
            self.win()
        }
        else{
            self.createEnemy()
        }
    }
    
    func validaPalavra(palavra: String) {
        println(count(palavra));
        for resposta in palavrasTeste {
            if resposta == palavra {
                score += Int(timeLeft)*10 * count(palavra);
                totalScore.text = "\(score)";
                self.popScore("\(Int(timeLeft)*10 * count(palavra))")
            }
        }
    }
    
    func consultarDicionario(palavra: String){
        if UIReferenceLibraryViewController.dictionaryHasDefinitionForTerm(palavra) {
            let ref = UIReferenceLibraryViewController(term: palavra)
            let pop = UIPopoverController(contentViewController: ref)
            pop.presentPopoverFromRect(CGRectMake(self.size.width/2, self.size.height - 150, 1, 1), inView: self.view!, permittedArrowDirections: UIPopoverArrowDirection.Down, animated: true)
        }
    }
    
    //Pega a determinada quantidade de palavras do vetor de palavras
    //e inicia o processo de insersão delas no tabuleiro.
    func seedar(num: Int) -> NSMutableArray{
        
        //define as palavras para seedar
        var cont = num
        var palavrasSeedadas:NSMutableArray = NSMutableArray()
        var letrasSeedadas:NSMutableArray = NSMutableArray()
        var arrPalavras = NSMutableArray(array: palavrasTeste)
        while cont >= 0 {
            let rand = arc4random_uniform(UInt32(palavrasTeste.count-1))
            if (!palavrasSeedadas.containsObject(arrPalavras.objectAtIndex(Int(rand)))) {
                palavrasSeedadas.addObject(arrPalavras.objectAtIndex(Int(rand)))
                arrPalavras.removeObjectAtIndex(Int(rand))
                println(palavrasTeste[Int(rand)])
                cont--
            }
        }
        
        //garante que as letras apareçam na tela
        for palavra in palavrasSeedadas {
            let letras = Array(palavra as! String)
            for letra in letras {
                let letraStr = "\(letra)"
                if !letrasSeedadas.containsObject(letraStr){
                    letrasSeedadas.addObject(letraStr)
                }
            }
        }
        
        return letrasSeedadas
        
    }
    
    //Animação da subida da pontuação quando acerta algo
    func popScore(score:String){
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
    
    func encheLetras(seed:NSMutableArray) {
        var letrasFinal = Array<LetraNode>()
        //Coloca as letras das palavras seedadas em letrasFinal
        for i in 0...seed.count-1 {
            let letraAux:LetraNode = LetraNode(texture: SKTexture(imageNamed: "tile"), letra: seed.objectAtIndex(i) as! String, tam: self.tam)
            letrasFinal.append(letraAux)
        }
        
        //Completa o vetor letrasFinal pra se adequar ao tamanho do tabuleiro
        for i in seed.count...self.tabuleiro.grid.columns*self.tabuleiro.grid.rows-1 {
            let letraAux = LetraNode(texture: SKTexture(imageNamed: "tile"), letra: self.randomLetra(), tam: self.tam)
            letrasFinal.append(letraAux)
        }
        
        //Embaralha as letras do letrasfinal e coloca elas no tabuleiro.
        letrasFinal = letrasFinal.shuffled()
        for i in 0...self.tabuleiro.grid.columns*self.tabuleiro.grid.rows-1 {
            tabuleiro.addLetraNode(i/self.tabuleiro.grid.rows, y: i%self.tabuleiro.grid.rows, letra: letrasFinal[i])
        }
    }
    
    //Enche tabuleiro com letras aleatórias
    func encheLetras() {
        for i in 0...self.tabuleiro.grid.columns-1 {
            for j in 0...self.tabuleiro.grid.rows-1 {
                let letraAux = LetraNode(texture: SKTexture(imageNamed: "tile"), letra: self.randomLetra(), tam: self.tam)
                tabuleiro.addLetraNode(i, y: j, letra: letraAux)
            }
        }
    }
    
    //"Refaz" o tabuleiro com novas letras aleatórias
    func trocaLetras() {
        for i in 0...self.tabuleiro.grid.columns-1 {
            for j in 0...self.tabuleiro.grid.rows-1 {
                let letraAux = LetraNode(texture: SKTexture(imageNamed: "tile"), letra: self.randomLetra(), tam: self.tam)
                tabuleiro.updateLetraNode(i, y: j, letra: letraAux)
            }
        }
    }
    
    func criaLetraTeste(l:String){
        let letra = LetraNode(texture: SKTexture(imageNamed: "apple"), letra: l, tam: self.tam)
        letra.physicsBody = SKPhysicsBody(rectangleOfSize: letra.size)
        letra.physicsBody?.dynamic = false
        letra.name = "letra"
        let x = CGFloat(arc4random())%self.size.width
        let y = CGFloat(arc4random())%self.size.height
        println("\(x) y \(y)")
        letra.position = CGPointMake(x, y)
        self.addChild(letra)
        
        println(l)
    }
    
    //Pega uma letra aleatoriamente do vetor
    func randomLetra() -> String {
        let ij = arc4random_uniform(UInt32(scienceVector.count-1))
        return scienceVector[Int(ij)].letra;
        
    }
    
    func goBack(){
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        self.vc?.presentViewController(home, animated: true, completion: nil)
    }
    
    func win(){
        if(!venceu){
            score = score * (diff + 1);
            venceu = true
            self.myLabel.text = "VENCEU"
            let winScene = WinScene()
            winScene.descobertas = self.descobertas;
            winScene.vc = self.vc
            winScene.score = self.score
            var pontuacao = PontuacaoManager.sharedInstance.newPontuacao()
            pontuacao.pontos = self.score;
            if(vc?.gameType == 0){
                pontuacao.categoria = "Bookworm"
            } else if (vc?.gameType == 1){
                pontuacao.categoria = "Scrambled"
            } else {
                pontuacao.categoria = "Missigno"
            }
            pontuacao.data = NSDate();
            PontuacaoManager.sharedInstance.save();
            self.view?.presentScene(winScene, transition: SKTransition.doorsCloseHorizontalWithDuration(0.5))
        }
        
    }
    
    //Força a troca de view
    var fugiu = false;
    func gameOver(currentTime: CFTimeInterval) {
        if(!perdeu){
            player.xScale = -1.0
            let animLegal = SKAction.animateWithTextures([
                SKTexture(imageNamed: "lex1"),
                SKTexture(imageNamed: "lex2"),
                SKTexture(imageNamed: "lex3")
                ], timePerFrame: 0.2)
            
            let animAction = SKAction.repeatActionForever(animLegal)
            
            player.removeActionForKey("idle")
            player.runAction(animAction, withKey: "escapar")
            player.runAction(SKAction.moveTo(CGPointMake(player.position.x - 1000, player.position.y), duration: 15.0))
            perdeu = true;
            lastUpdate = currentTime;
        } else {
            if(currentTime > lastUpdate + 3.0 && !fugiu){
                score = score * (diff + 1) / 2
                fugiu = true;
                var pontuacao = PontuacaoManager.sharedInstance.newPontuacao()
                pontuacao.pontos = self.score;
                if(vc?.gameType == 0){
                    pontuacao.categoria = "Bookworm"
                } else if (vc?.gameType == 1){
                    pontuacao.categoria = "Scrambled"
                } else {
                    pontuacao.categoria = "Missigno"
                }
                pontuacao.data = NSDate();
                PontuacaoManager.sharedInstance.save();
                //self.vc?.performSegueWithIdentifier("gameOver", sender: score);
                self.myLabel.text = "FUGIMOS"
                let winScene = WinScene()
                winScene.isLose = true
                winScene.descobertas = self.descobertas;
                winScene.vc = self.vc
                winScene.score = self.score
                self.view?.presentScene(winScene, transition: SKTransition.doorsCloseHorizontalWithDuration(0.5))
            }
        }
    }
    
    
    var lastUpdateTimeInterval:NSTimeInterval = 0.0
    var timeSinceLast:NSTimeInterval = 0
    var prevSeconds:Int = -1
    
    override func update(currentTime: CFTimeInterval) {
        
        timeSinceLast = currentTime - self.lastUpdateTimeInterval
        self.lastUpdateTimeInterval = currentTime;
        
        //controles da tela do Lexicus
        if (enemy != nil){
            self.enemy!.runBehavior(self)
            
            if(enemy?.position.x <= -200){//player.position.x + player.size.width/2){
                self.gameOver(currentTime);
            }
        }
        
    }
    
    
}
