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
    
    var categorias = ["Frutas", "Sei la", "Fantas"];
    var palavrasTeste = ["Bananas e Maçãs", "Ayy lmao", "Não é Sukita"];
    var clicado = false; //Possivelmente gambiarra estupida
    var currentDetail = 0;
    
    @IBOutlet weak var teste: UILabel!
    var q : String?
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
        q = "HUEHUEHUE";
        super.viewDidLoad();
        //        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible;
        //
        //        let value = UIInterfaceOrientation.LandscapeLeft.rawValue;
        //        UIDevice.currentDevice().setValue(value, forKey: "orientation");
        
        
        //teste.text = q;
        
        detailsTV.delegate = self;
        detailsTV.dataSource = self;
        
        masterTV.delegate = self;
        masterTV.dataSource = self;
        //self.configureView();
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView.tag == 0){
            return categorias.count;
        } else {
            return 2;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (tableView.tag == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath) as! UITableViewCell;
            cell.textLabel!.text = categorias[indexPath.row];
            
            return cell;
        } else {
            var celula = detailsTV.dequeueReusableCellWithIdentifier("EncyDetCell") as! EncyDetailsCell;
            if(clicado){
                //celula.backgroundColor = UIColor.yellowColor();
                celula.palavra.text = palavrasTeste[currentDetail];
                celula.traducao.text = palavrasTeste[currentDetail];
                celula.dica.text = palavrasTeste[currentDetail];
            } else {
                celula.palavra.text = "";
                celula.traducao.text = "";
                celula.dica.text = "";
            }
            return celula;
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(tableView.tag == 0){
            currentDetail = indexPath.row;
            clicado = true;
            detailsTV.reloadData();
        }
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