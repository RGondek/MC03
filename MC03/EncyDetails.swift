//
//  EncyDetail.swift
//  LabelsTest
//
//  Created by Lucas Leal Mendonça on 22/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class EncyDetails: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var clicado = false; //Possivelmente gambiarra estupida
    var currentDetail = 0;
    
//    @IBOutlet weak var nada: UILabel!
    var categorias : NSMutableArray?;
//    var frutas : NSMutableArray?;
//    var animais : NSMutableArray?;
//    var cores : NSMutableArray?;
    var palavras : NSMutableArray?;
    
    @IBOutlet weak var teste: UILabel!
    @IBOutlet weak var detailsTV: UITableView!
    //    var detailItem: AnyObject? {
    //        didSet {
    //            self.configureView()
    //        }
    //    }
    
    //    func configureView(){
    //        if let detail: AnyObject = detailItem {
    //            if let oTeste
    //        }
    //    }
    @IBOutlet weak var masterTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible;
        //
        //        let value = UIInterfaceOrientation.LandscapeLeft.rawValue;
        //        UIDevice.currentDevice().setValue(value, forKey: "orientation");
        
        
        //teste.text = q;
        categorias = NSMutableArray(array: CategoryManager.sharedInstance.fetchSortedCategories());
//        frutas = NSMutableArray();
//        animais = NSMutableArray();
//        cores = NSMutableArray();
        palavras = NSMutableArray();
        
        for cat in categorias! {//arrumar
            palavras?.addObject(NSMutableArray());
        }
        
        for palavra in WordManager.sharedInstance.fetchSortedKnownWords(){
            if(palavra.categoria.nome == "Animais"){
                palavras?.objectAtIndex(0).addObject(palavra);
            } else if(palavra.categoria.nome == "Cores"){
                palavras?.objectAtIndex(1).addObject(palavra);
            } else if(palavra.categoria.nome == "Esportes"){
                palavras?.objectAtIndex(2).addObject(palavra);
            }else if(palavra.categoria.nome == "Frutas"){
                palavras?.objectAtIndex(3).addObject(palavra);
            } else if(palavra.categoria.nome == "Objetos"){
                palavras?.objectAtIndex(4).addObject(palavra);
            }
        }
        
        detailsTV.delegate = self;
        detailsTV.dataSource = self;
        detailsTV.backgroundColor = UIColor.clearColor()
        masterTV.delegate = self;
        masterTV.dataSource = self;
        masterTV.backgroundColor = UIColor.clearColor()
        //self.configureView();
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView.tag == 0){
            return categorias!.count;
        } else {
            if(palavras!.objectAtIndex(currentDetail).count > 0){
                detailsTV.hidden = false;
            } else if (clicado){
//                nada.text = "Nada por aqui. Vai jogar lá, fera!1"
                detailsTV.hidden = true;
            } else {
//                nada.text = "Saudades Ibagem"
                detailsTV.hidden = true;
            }
            return palavras!.objectAtIndex(currentDetail).count;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (tableView.tag == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath) as! UITableViewCell;
            cell.textLabel!.text = ((categorias!.objectAtIndex(indexPath.row)) as! Categoria).nome;
            cell.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = UITableViewCellSelectionStyle.None;//Embelezar isso se achar um jeito mais melhor de bom.
            return cell;
        } else {
            var celula = detailsTV.dequeueReusableCellWithIdentifier("EncyDetCell") as! EncyDetailsCell;
            if(clicado){
                //celula.backgroundColor = UIColor.yellowColor();
                celula.palavra.text = ((palavras?.objectAtIndex(currentDetail).objectAtIndex(indexPath.row)) as! Palavra).word;
                celula.traducao.text = ((palavras?.objectAtIndex(currentDetail).objectAtIndex(indexPath.row)) as! Palavra).translate;
                celula.dica.text = ((palavras?.objectAtIndex(currentDetail).objectAtIndex(indexPath.row)) as! Palavra).prompt;
                celula.tip.text = ((palavras?.objectAtIndex(currentDetail).objectAtIndex(indexPath.row)) as! Palavra).promptUS;
                celula.selectionStyle = UITableViewCellSelectionStyle.None;
            } else {
                celula.palavra.text = "";
                celula.traducao.text = "";
                celula.dica.text = "";
                celula.tip.text = "";
            }
            celula.backgroundColor = UIColor.clearColor()
            return celula;
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(tableView.tag == 0){
            let cell = masterTV.cellForRowAtIndexPath(indexPath);
            cell!.textLabel?.textColor = UIColor.purpleColor();
            let attStr : NSMutableAttributedString = NSMutableAttributedString(string: cell!.textLabel!.text!);
            attStr.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSRange(location:0,length: attStr.length));
            cell?.textLabel?.attributedText = attStr;
            //masterTV.cellForRowAtIndexPath(indexPath)?.textLabel?.attributedText = nil
            currentDetail = indexPath.row;
            clicado = true;
            detailsTV.reloadData();
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if(tableView.tag == 0){
            let cell = masterTV.cellForRowAtIndexPath(indexPath);
            cell!.textLabel?.textColor = UIColor.blackColor();
            
            //Provavelmente sendo feito de um jeito burro \/
            let text = cell?.textLabel?.attributedText.string;
            cell?.textLabel?.attributedText = nil;
            cell?.textLabel!.text = text;
        }
    }
    
    @IBAction func btnHome(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //    override func supportedInterfaceOrientations() -> Int {
    //        return Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue)
    //    }
    //
    //    override func shouldAutorotate() -> Bool {
    //        return false;
    //    }
    
    //    func splitViewController(svc: UISplitViewController, shouldHideViewController vc: UIViewController, inOrientation orientation: UIInterfaceOrientation) -> Bool {
    //        return false;
    //
    //    }
    //    - (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation{
    //        return NO;
    //    }
}