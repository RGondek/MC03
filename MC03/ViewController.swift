//
//  ViewController.swift
//  MC03
//
//  Created by Rubens Gondek on 5/18/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let categorias = ["Frutas", "Animais", "Cores", "Objetos", "Esportes"]
    let words = [["Apple", "Pineapple", "Pear", "Banana", "Strawberry", "Grape"],["Bear", "Dog", "Cat", "Fish", "Platypus", "Spider"],["Red", "Blue", "Yellow", "Green", "Orange", "Pink"],["Pillow", "Fan", "Door", "Keyboard", "Key", "Towel", "Umbrella"], ["Marathon", "Swimming", "Chess", "Bowling", "Fencing", "Boxing"]]
    let palavras = [["Maçã", "Abacaxi", "Pêra", "Banana", "Morango", "Uva"],["Urso", "Cachorro", "Gato", "Peixe", "Ornitorrinco", "Aranha"],["Vermelho", "Azul", "Amarelo", "Verde", "Laranja", "Rosa"], ["Travesseiro", "Ventilador", "Porta", "Teclado", "Chave", "Toalha", "Guarda-Chuva"], ["Maratona", "Natação", "Xadrez", "Boliche", "Esgrima", "Boxe"]]
    let prompt = [["Ótima fruta para fazer tortas", "Tem coroa mas não é rei", "?, uva, maçã ou salada mista", "Macacos gostam dessa fruta", "Fruta vermelha que fica uma delícia com chocolate", "Fruta roxa ou verde. Pode ser usada para fazer geléia"],["De pelúcia ou Polar", "É o melhor amigo do homem", "Bebe leite e adora caçar ratos", "Vive em baixo d'água", "Mistura de Pato com castor", "Tem oito pernas e faz teias"],["Cor da maçã", "Cor do céu", "Cor do ouro", "Cor da grama", "Cor da Tangerina", "Cor do flamingo"], ["Usado para deitar a cabeça enquanto dormimos", "Faz ventos nos dias quentes", "Abre e fecha. Deixa entrar ou sair", "Digita palavras no computador", "Tranca outros objetos usando suas fechaduras", "Seca o corpo após o banho", "Te protege da chuva"], ["Corrida de 42 kilometros.", "Corrida dentro da água", "Estratégia em tabuleiro. Peças tem movimentos específicos.", "Uma bola é usada para derrubar os pinos.", "Praticado pelo Zorro com uma espada.", "Apenas golpes usando as mãos e acima da cintura "]]
    let promptIngles = [["Great to make pies", "Has a crown, but isn't a king", "P + part of you that listen to music", "Monkeys like this fruit", "A red fruit that is delicious with chocolate", "A purple or green fruit. Can be used to make jam."],["It can be Furry or Gummy", "Man's best friend", "Drink milk and love to chase mice", "Lives underwater", "Duck + Beaver", "Has eigth legs and makes web"],["The color of the apple", "The color of the sky", "The color of gold", "The color of grass", "The color of a tangerine", "Flamingo's color"], ["Used to lay down our heads when we sleep", "Makes winds on hot days", "Opens and closes. Lets get in or out", "Type words on the computer", "Locks other objects using their locks", "Dries the body after the bath", "Protects you from the rain"], ["42 Kilometers race", "Race inside water", "Strategy board game. Pieces have different moves.", "A ball is used to knock down the pins.", "Practiced by Zorro with a sword.", "Only blows using the hands and above the waist."]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let useDef = NSUserDefaults.standardUserDefaults()
        if useDef.valueForKey("first") == nil {
            useDef.setValue("true", forKey: "first")
            var ws:[Palavra] = []
            
            for iA in 0..<categorias.count {
                var categ = CategoryManager.sharedInstance.newCategory()
                categ.nome = categorias[iA]
                ws.removeAll(keepCapacity: false)
                for iB in 0..<words[iA].count{
                    var palavra = WordManager.sharedInstance.newWord()
                    palavra.word = words[iA][iB]
                    palavra.translate = palavras[iA][iB]
                    palavra.categoria = categ
                    palavra.prompt = prompt[iA][iB]
                    palavra.promptUS = promptIngles[iA][iB]
                    ws.append(palavra)
                }
                categ.palavras = NSSet(array: ws)
                CategoryManager.sharedInstance.save()
            }
        }
        
        var categories = CategoryManager.sharedInstance.fetchCategories()
        var wordsColor = CategoryManager.sharedInstance.fetchWordsForCategory(3, categoryName: "Cores")
        
//        // Código pra gerar a loading view a partir do xib
//        
//        let loadView = NSBundle.mainBundle().loadNibNamed("HowTo", owner: self, options: nil)[0] as! UIView
//        loadView.frame = CGRectMake(100, 100, 500, 700)
//        self.view.addSubview(loadView)
        

    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

