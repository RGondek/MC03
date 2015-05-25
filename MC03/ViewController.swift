//
//  ViewController.swift
//  MC03
//
//  Created by Rubens Gondek on 5/18/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let categorias = ["Frutas", "Animais", "Cores"]
    let words = [["Apple", "Pineapple", "Pear", "Banana", "Strawberry"],["Bear", "Dog", "Cat", "Fish", "Platypus"],["Red", "Blue", "Yellow", "Green", "Orange"]]
    let palavras = [["Maçã", "Abacaxi", "Pêra", "Banana", "Morango"],["Urso", "Cachorro", "Gato", "Peixe", "Ornitorrinco"],["Vermelho", "Azul", "Amarelo", "Verde", "Laranja"]]
    let prompt = [["Ótima fruta para fazer tortas", "Tem coroa mas não é rei", "?, uva, maçã ou salada mista", "Macacos gostam dessa fruta", "Fruta vermelha que fica uma delícia com chocolate"],["De pelúcia ou Polar", "É o melhor amigo do homem", "Bebe leite e adora caçar ratos", "Vive em baixo d'água", "Mistura de Pato com castor"],["Cor da maçã", "Cor do céu", "Cor do ouro", "Cor da grama", "Cor da Tangerina"]]
    let promptIngles = [["Great to make pies", "Has a crown, but isn't a king", "P + part of you that listen to music", "Monkeys like this fruit", "A red fruit that is delicious with chocolate"],["It can be Furry or Gummy", "Man's best friend", "Drink milk and love to chase mice", "Lives underwater", "Duck + Beaver"],["The color of the apple", "The color of the sky", "The color of gold", "The color of grass", "The color of a tangerine"]]
    
    
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
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

